library(tidyverse)
library(rvest)
library(lubridate)
library(crandb)
library(ggthemes)
library(ggiraph)

github_data <- function(from = NULL, user = "jimhester") {
  if (is.null(from)) {
    url <- str_glue("https://github.com/users/{user}/contributions")
  } else {
    url <- str_glue("https://github.com/users/{user}/contributions?from={from}")
  }

  html <- xml2::read_html(url)

  calendar <- html_node(html, ".js-calendar-graph-svg")
  calendar_days <- html_nodes(calendar, "rect")
  gh_data <- tibble(
    date = as.Date(xml_attr(calendar_days, "data-date")),
    count = xml_attr(calendar_days, "data-count"),
    type = "github",
    tip = str_glue("{count} contributions"),
    link = str_glue("https://github.com/{user}?from={date}&to={date}&tab=overview")
  )
  gh_data
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

get_pkgs <- function(emails) {
  emails <- glue::glue_collapse(glue::double_quote(emails), ",")
  url <- str_glue("http://crandb.r-pkg.org/-/maintainer?keys=[{emails}]")

  res <- jsonlite::read_json(url)

  map_chr(res, 2L)
}

get_releases <- function(data) {
  out <- map(set_names(data), ~ crandb::package(.x, "all"))

  map_dfr(out, ~ list(version = names(.x$timeline), date = readr::parse_datetime(map_chr(.x$timeline, function(y) y %||% NA_character_))), .id = "package")
}

pkg_data <- function(emails = c("james.f.hester@gmail.com", "jim.hester@rstudio.com", "james.hester@rstudio.com")) {
  get_releases(get_pkgs(emails)) %>%
    mutate(
      type = "pkg",
      link = str_glue("https://CRAN.R-project.org/package={package}"),
      tip = str_glue("{package}: {version}"),
      date = as.Date(date)
    )
}


calendar_data <- function(from = NULL, to = from + years(1), github_user = "jimhester", email = c("james.f.hester@gmail.com", "jim.hester@rstudio.com", "james.hester@rstudio.com")) {
  github_data <- github_data(from, github_user)
  if (is.null(from)) {
    from <- today() - years(1)
  } else {
    from <- lubridate::as_date(from)
  }

  to <- lubridate::as_date(to)


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
    geom_tile(data = filter(p_data, is.na(type)), width = 6, height = .8, aes(x, y, fill = type), key_glyph = draw_key_point) +
    geom_tile_interactive(data = filter(p_data, !is.na(type)), width = 6, height = .8, aes(x, y, fill = type, alpha = log(as.numeric(count)), tooltip = tip, onclick = on_click, data_id = data_id), key_glyph = draw_key_point) +
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
        override.aes = list(shape = 'square filled', size = 3),
        keywidth = 3,
        label.theme = element_text(family = "Lato", size = 7),
        label.position = "bottom",
        nrow = 1
      )
      ) +
    labs(x = NULL, y = NULL)

  x <- girafe(code = print(p), width_svg = 6, height_svg = 2)

  tooltip_css <- "background: #002b36; opacity: 1; color: #839496; border-radius: 5px; 
  padding: 5px; box-shadow: 3px 3px 5px 0px #888888;
  font-size: 12px; border-width 2px; border-color: #002b36;"

  girafe_options(x, opts_tooltip(css = tooltip_css))
}
