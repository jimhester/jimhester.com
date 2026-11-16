library(tidyverse)
library(lubridate)
library(ggthemes)
library(ggiraph)

# GitHub contributions and CRAN releases are snapshotted to CSV so rendering
# needs no network access. The graph covers 2016-2021, my time at RStudio;
# rerun `update_activity_data()` to refresh the snapshots.
activity_years <- 2016:2021
github_csv <- here::here("R/activity/github-contributions.csv")
cran_csv <- here::here("R/activity/cran-releases.csv")

fetch_github_contributions <- function(year, user = "jimhester") {
  query <- "
    query($user: String!, $from: DateTime!, $to: DateTime!) {
      user(login: $user) {
        contributionsCollection(from: $from, to: $to) {
          contributionCalendar {
            weeks { contributionDays { date contributionCount } }
          }
        }
      }
    }"
  res <- gh::gh_gql(query, variables = list(
    user = user,
    from = str_glue("{year}-01-01T00:00:00Z"),
    to = str_glue("{year}-12-31T23:59:59Z")
  ))
  weeks <- res$data$user$contributionsCollection$contributionCalendar$weeks
  days <- flatten(map(weeks, "contributionDays"))
  tibble(
    date = as.Date(map_chr(days, "date")),
    count = map_int(days, "contributionCount")
  )
}

github_data <- function(user = "jimhester") {
  read_csv(github_csv, col_types = "Di") %>%
    mutate(
      type = "github",
      tip = str_glue("{count} contributions"),
      link = str_glue("https://github.com/{user}?from={date}&to={date}&tab=overview")
    )
}

post_data <- function() {
  posts <- list.files(here::here("content/post"), recursive = TRUE, full.names = FALSE, pattern = "^index[.]R?md")
  post_data <- map_dfr(set_names(posts, dirname(posts)), function(file) {
    data <- rmarkdown::yaml_front_matter(here::here("content/post", file))
    list(
      date = as.Date(data$date),
      title = data$title,
      is_video = isTRUE(data$video)
    )
    }, .id = "dir") %>%
  mutate(
    type = ifelse(is_video, "video", "post"),
    link = file.path("post", dir),
    tip = title
    ) %>%
  select(-is_video)
}


talk_data <- function() {
  talks <- list.files(here::here("content/talk"), recursive = TRUE, full.names = FALSE, pattern = "^index[.]md")
  talk_data <- map_dfr(set_names(talks, dirname(talks)), function(file) {
    data <- rmarkdown::yaml_front_matter(here::here("content/talk", file))
    list(
      date = as.Date(data$date),
      title = data$title,
      is_workshop = "workshop" %in% data$tags
    )
  }, .id = "dir") %>%
    mutate(
      type = ifelse(is_workshop, "workshop", "talk"),
      link = file.path("talk", dir),
      tip = title
    ) %>%
    select(-is_workshop)
}

fetch_cran_releases <- function(pkgs) {
  out <- map(set_names(pkgs), ~ crandb::package(.x, "all"))

  map_dfr(out, ~ list(version = names(.x$timeline), date = as.Date(readr::parse_datetime(map_chr(.x$timeline, function(y) y %||% NA_character_)))), .id = "package")
}

jim_pkgs <- 
  c("devtools",
    "available",
    "bench",
    "covr",
    "fs",
    "glue",
    "gmailr",
    "knitrBootstrap",
    "lintr",
    "primerTree",
    "rex",
    "types",
    "archive",
    "brio",
    "cpp11",
    "decor",
    "memoise",
    "mockery",
    "odbc",
    "pkgbuild",
    "pkgload",
    "readr",
    "remotes",
    "urlchecker",
    "vroom",
    "withr",
    "xml2"
  )

pkg_data <- function() {
  read_csv(cran_csv, col_types = "ccD") %>%
    mutate(
      type = "pkg",
      link = str_glue("https://CRAN.R-project.org/package={package}"),
      tip = str_glue("{package}: {version}")
    )
}

update_activity_data <- function() {
  github <- map_dfr(activity_years, fetch_github_contributions)
  write_csv(github, github_csv)

  cran <- fetch_cran_releases(jim_pkgs) %>%
    filter(year(date) %in% activity_years) %>%
    arrange(date, package)
  write_csv(cran, cran_csv)
}

calendar_data <- function(from, to = from + years(1) - days(1)) {
  from <- as_date(from)
  to <- as_date(to)

  github_data <- github_data()

  all_data <- bind_rows(
    select(filter(github_data, count > 0), date, type, tip, link, count),
    select(talk_data(), date, type, tip, link),
    select(pkg_data(), date, type, tip, link),
    select(post_data(), date, type, tip, link)
  )

  empty_days <- filter(github_data, count == 0, !(date %in% all_data$date)) %>% mutate(type = NA) %>% select(date, type)

  bind_rows(
    all_data,
    empty_days
  ) %>% filter(date >= from, date <= to)
}

calendar_plot <- function(data = calendar_data()) {

  p_data <- mutate(data,
    x = floor_date(date, "week"),
    y = fct_rev(lubridate::wday(date, label = TRUE)),
    type = factor(type, levels = c("github", "video", "post", "talk", "workshop", "pkg")),
    on_click = str_glue('window.location.assign("{link}")'),
    data_id = ifelse(!is.na(type), as.character(seq_along(x)), NA_character_),
    tip = str_glue("<b>{tip}</b> on {date}")
  )

  counts <- count(p_data, type, .drop = FALSE) %>%
    na.omit() %>%
    mutate(
      n = case_when(
        type == "github" ~ count(na.omit(p_data), type, wt = as.integer(count)) %>% pull(),
        TRUE ~ n),
      emoji = c("💻", "📹", "📋", "📽", "⚒", "📦"),
      nice = c("GitHub", "videos", "posts", "talks", "workshops", "CRAN"),
      label = str_glue("{scales::comma_format(accuracy = 1)(n)} {emoji}\n{nice}")
    )

  my_pal = solarized_pal("green")(6)
  rebase <- ggthemes:::solarized_rebase()

  p <- ggplot() +
    geom_tile(data = filter(p_data, is.na(type)), width = 6, height = .8, aes(x, y, fill = type), key_glyph = draw_key_point, show.legend = TRUE) +
    geom_tile_interactive(data = filter(p_data, !is.na(type)), width = 6, height = .8, aes(x, y, fill = type, alpha = log(as.numeric(count)), tooltip = tip, onclick = on_click, data_id = data_id), show.legend = FALSE) +
    scale_fill_manual(
      values = c("github" = my_pal[[1]], "video" = my_pal[[2]], "post" = my_pal[[3]], "talk" = my_pal[[4]], workshop = my_pal[[5]], pkg = my_pal[[6]]),
      breaks = c("github", "video", "post", "talk", "workshop", "pkg"),
      labels = counts$label,
      na.translate = TRUE, na.value = "#eee8d5"
      ) +
    scale_y_discrete(breaks = c("Mon", "Wed", "Fri")) +
    theme_solarized() +
    theme(rect = element_blank(),
      line = element_blank(),
      plot.background = element_rect(fill = rebase[["rebase03"]]),
      text = element_text(family = "Lato", size = 7),
      legend.position = "bottom",
      aspect.ratio = .8/6
      ) +
    guides(
      alpha = "none",
      fill = guide_legend(
        title = NULL,
        override.aes = list(shape = 'square filled', size = 3, stroke = 0.5),
        theme = theme(
          legend.key.width = unit(3, "lines"),
          legend.text = element_text(family = "Lato", size = 7, colour = "black")
        ),
        label.position = "bottom",
        nrow = 1
      )
      ) +
    labs(x = NULL, y = NULL)

  # Register Lato for text metrics, but drop the font files ggiraph would
  # bundle: the site theme already loads Lato from Google Fonts.
  gdtools::register_gfont("Lato")
  fonts <- gdtools::font_set(sans = "Lato")
  fonts$dependencies <- list()

  x <- girafe(code = print(p), width_svg = 6, height_svg = 2, font_set = fonts)

  tooltip_css <- "background: #002b36; opacity: 1; color: #839496; border-radius: 5px; 
  padding: 5px; box-shadow: 3px 3px 5px 0px #888888;
  font-size: 12px; border-width 2px; border-color: #002b36;"

  girafe_options(x, opts_tooltip(css = tooltip_css))
}
