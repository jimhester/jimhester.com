---
title: lintr v2.0.0
date: '2019-09-30'
slug: lintr-2-0-0
tags: [package]
subtitle: ''
summary: '[lintr](https://github.com/jimhester/lintr) 2.0.0 is now on CRAN!'
image:
  caption: '[Photo by Waldemar Brandt on Unsplash](https://unsplash.com/photos/NPPNHZK1U0s)'
  focal_point: Smart
projects: [lintr]
package_release: true
---

[lintr](https://github.com/jimhester/lintr) 2.0.0 is now on CRAN!

lintr checks adherence to a given style, looks for syntax errors and possible
semantic errors. It is useful for automatically checking code style on CI
systems such as [Travis CI](https://travis-ci.org/), as well as local checking
of R code edited with the RStudio IDE, Emacs, Vim, Sublime Text and Atom.

This release is version 2.0.0 to signify it is a _major_ release,
containing changes that have been in the devel branch since the last major
release (1.0.0) on 2016-04-16, three and a half years ago! There have been a
few minor bugfix releases since that time, but
many new linters have only been available in the devel version of lintr. See the full
[Changelog](https://github.com/jimhester/lintr/releases/tag/v2.0.0) for details
on all of the changes.

## New linters

There are a number of new linters available in this release. Not all of them
are enabled by default, you can add a specific linter to the defaults by using
`with_defaults()` and the `linters` argument, e.g.

```r
library(lintr)
lint_package(linters = with_defaults(extraction_operator_linter()))
```

* `cyclocomp_linter()` - identifies overly complex functions
* `equals_na_linter()` - finds cases where code tries to check `x == NA` rather than `is.na(x)`
* `extraction_operator_linter()` - checks that the `[[` operator is used when extracting a single element from an object, not `[` (subsetting) nor `$` (interactive use)
* `function_left_parentheses_linter()` - to check that there is no space between a function name and its left parentheses
* `implicit_integer_linter()` - detects round numbers not declared as integers, i.e. 1 instead of 1L
* `nonportable_path_linter()` - identifies paths constructed without `file.path()`
* `paren_brace_linter()` - checks that there is a space between right parenthesis and an opening curly brace
* `pipe_continuation_linter()` - to ensure there is a space before %>% and newline afterwards
* `semicolon_terminator_linter()` - reports semicolons at the end a line and between expressions
* `seq_linter()` - finds `1:length(...)` (and similar) expressions
* `todo_comment_linter()` - lints TODOs
* `T_and_F_symbol_linter()` - warns when using T and F instead of TRUE and FALSE
* `undesirable_operator_linter()` - and `undesirable_function_linter()` lint uses of user-specified functions and operators
* `unneeded_concatenation_linter()` - lints uses of c() with a constant or no arguments

## New functions

There are a handful of new functions available in this release.

1. `lint_dir()` - Run lintr on any arbitrary directory, this is useful when you have a collection of scripts, but they aren't in a formal package.
2. `checkstyle_output()` - Output the lints in the [checkstyle](https://checkstyle.sourceforge.io/) format often used in Java applications. Many programs can read this format, so this allows lintr results to be used.
3. `summary.lints()` - You can now call `summary()` on your lint results to get a summation of the issues.

## New functions for writing linters

Writing custom linters in your own package is now easier thanks to more of
these internal functions being exported from lintr. See the [creating
linters](https://cran.r-project.org/web/packages/lintr/vignettes/creating_linters.html)
vignette on information on how to create a new linter, and if you find
additional functions are necessary please [open an
issue](https://github.com/jimhester/lintr/issues).

## Bugfixes

There are a _large_ number of bugfixes, see the full
[Changelog](https://github.com/jimhester/lintr/releases/tag/v2.0.0) for
details. Many of these fixes were submitted by community members, a huge thanks
to everyone who contributed!

## Become a maintainer!

The lintr package is looking for new contributors and maintainers, if you use
lintr in your work and think it could be improved please consider [joining the
project](https://github.com/jimhester/lintr/issues/318#issuecomment-389972589).
You can also join our gitter chatroom if you are interested in helping.
[![Join the chat at
https://gitter.im/jimhester-lintr/Lobby](https://badges.gitter.im/jimhester-lintr/Lobby.svg)](https://gitter.im/jimhester-lintr/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Thanks
This release would not have been possible without the contributions from the
community. I would like to thank in particular [Florent Angly
(&#x0040;fangly)](https://github.com/fangly) and [Russ Hyde
(&#x0040;russHyde)](https://github.com/russHyde). Florent did a large amount of
work making existing linters much more robust and adding new linters and Russ
has been a great help recently triaging issues and fixing bugs.

Also a huge thanks to all the rest of the 143 people who contributed code and opened issues for lintr 2.0.0!

[&#x0040;AdamSpannbauer](https://github.com/AdamSpannbauer),
[&#x0040;Agent-Sesame](https://github.com/Agent-Sesame),
[&#x0040;aksh7860](https://github.com/aksh7860),
[&#x0040;alessandro-gentilini](https://github.com/alessandro-gentilini),
[&#x0040;alex88](https://github.com/alex88),
[&#x0040;AlexAxthelm](https://github.com/AlexAxthelm),
[&#x0040;andrewychoi](https://github.com/andrewychoi),
[&#x0040;angrygoats](https://github.com/angrygoats),
[&#x0040;apandit24](https://github.com/apandit24),
[&#x0040;Arcanemagus](https://github.com/Arcanemagus),
[&#x0040;arekbee](https://github.com/arekbee),
[&#x0040;arnyeinstein](https://github.com/arnyeinstein),
[&#x0040;artemklevtsov](https://github.com/artemklevtsov),
[&#x0040;azoimide](https://github.com/azoimide),
[&#x0040;batpigandme](https://github.com/batpigandme),
[&#x0040;benman1](https://github.com/benman1),
[&#x0040;BenoitLondon](https://github.com/BenoitLondon),
[&#x0040;bfgray3](https://github.com/bfgray3),
[&#x0040;blindjesse](https://github.com/blindjesse),
[&#x0040;bmwilly](https://github.com/bmwilly),
[&#x0040;bnsh](https://github.com/bnsh),
[&#x0040;brnleehng](https://github.com/brnleehng),
[&#x0040;byapparov](https://github.com/byapparov),
[&#x0040;cboettig](https://github.com/cboettig),
[&#x0040;cdiener](https://github.com/cdiener),
[&#x0040;cnolanminich](https://github.com/cnolanminich),
[&#x0040;csgillespie](https://github.com/csgillespie),
[&#x0040;cwhoffmannch](https://github.com/cwhoffmannch),
[&#x0040;dchiu911](https://github.com/dchiu911),
[&#x0040;denrou](https://github.com/denrou),
[&#x0040;dfrankow](https://github.com/dfrankow),
[&#x0040;dirkschumacher](https://github.com/dirkschumacher),
[&#x0040;dirmeier](https://github.com/dirmeier),
[&#x0040;dragosmg](https://github.com/dragosmg),
[&#x0040;dschlaep](https://github.com/dschlaep),
[&#x0040;dy-kim](https://github.com/dy-kim),
[&#x0040;edlee123](https://github.com/edlee123),
[&#x0040;EdwinTh](https://github.com/EdwinTh),
[&#x0040;ellisvalentiner](https://github.com/ellisvalentiner),
[&#x0040;EmilRehnberg](https://github.com/EmilRehnberg),
[&#x0040;Enchufa2](https://github.com/Enchufa2),
[&#x0040;EndenDragon](https://github.com/EndenDragon),
[&#x0040;even4void](https://github.com/even4void),
[&#x0040;fabian-s](https://github.com/fabian-s),
[&#x0040;Fablepongiste](https://github.com/Fablepongiste),
[&#x0040;fangly](https://github.com/fangly),
[&#x0040;FerandDalatieh](https://github.com/FerandDalatieh),
[&#x0040;flodel](https://github.com/flodel),
[&#x0040;flying-sheep](https://github.com/flying-sheep),
[&#x0040;FvD](https://github.com/FvD),
[&#x0040;gaborcsardi](https://github.com/gaborcsardi),
[&#x0040;gdbassett](https://github.com/gdbassett),
[&#x0040;gdequeiroz](https://github.com/gdequeiroz),
[&#x0040;gdkrmr](https://github.com/gdkrmr),
[&#x0040;ghost](https://github.com/ghost),
[&#x0040;ginberg](https://github.com/ginberg),
[&#x0040;gitter-badger](https://github.com/gitter-badger),
[&#x0040;giuseppec](https://github.com/giuseppec),
[&#x0040;GregoireGauriot](https://github.com/GregoireGauriot),
[&#x0040;GregorDeCillia](https://github.com/GregorDeCillia),
[&#x0040;grssnbchr](https://github.com/grssnbchr),
[&#x0040;Guillawme](https://github.com/Guillawme),
[&#x0040;ha0ye](https://github.com/ha0ye),
[&#x0040;hadley](https://github.com/hadley),
[&#x0040;hanfeisun](https://github.com/hanfeisun),
[&#x0040;harryln](https://github.com/harryln),
[&#x0040;hfrick](https://github.com/hfrick),
[&#x0040;Hong-Revo](https://github.com/Hong-Revo),
[&#x0040;hstahl](https://github.com/hstahl),
[&#x0040;HyukjinKwon](https://github.com/HyukjinKwon),
[&#x0040;IndrajeetPatil](https://github.com/IndrajeetPatil),
[&#x0040;infotroph](https://github.com/infotroph),
[&#x0040;jabranham](https://github.com/jabranham),
[&#x0040;jackwasey](https://github.com/jackwasey),
[&#x0040;javierluraschi](https://github.com/javierluraschi),
[&#x0040;jayvdb](https://github.com/jayvdb),
[&#x0040;jcubic](https://github.com/jcubic),
[&#x0040;jennybc](https://github.com/jennybc),
[&#x0040;jeremymiles](https://github.com/jeremymiles),
[&#x0040;JhossePaul](https://github.com/JhossePaul),
[&#x0040;jimhester](https://github.com/jimhester),
[&#x0040;jmwerner](https://github.com/jmwerner),
[&#x0040;jonmcalder](https://github.com/jonmcalder),
[&#x0040;joshkgold](https://github.com/joshkgold),
[&#x0040;jrnold](https://github.com/jrnold),
[&#x0040;jvd10](https://github.com/jvd10),
[&#x0040;karawoo](https://github.com/karawoo),
[&#x0040;kenahoo](https://github.com/kenahoo),
[&#x0040;khughitt](https://github.com/khughitt),
[&#x0040;LiNk-NY](https://github.com/LiNk-NY),
[&#x0040;LukeGoodsell](https://github.com/LukeGoodsell),
[&#x0040;maelle](https://github.com/maelle),
[&#x0040;mattiaciollaro](https://github.com/mattiaciollaro),
[&#x0040;mattyb](https://github.com/mattyb),
[&#x0040;maxheld83](https://github.com/maxheld83),
[&#x0040;mb706](https://github.com/mb706),
[&#x0040;md0u80c9](https://github.com/md0u80c9),
[&#x0040;michaellevy](https://github.com/michaellevy),
[&#x0040;mindlessroman](https://github.com/mindlessroman),
[&#x0040;mjsteinbaugh](https://github.com/mjsteinbaugh),
[&#x0040;mpadge](https://github.com/mpadge),
[&#x0040;mplough](https://github.com/mplough),
[&#x0040;mschilli87](https://github.com/mschilli87),
[&#x0040;mwaldstein](https://github.com/mwaldstein),
[&#x0040;nathaneastwood](https://github.com/nathaneastwood),
[&#x0040;naught101](https://github.com/naught101),
[&#x0040;pachevalier](https://github.com/pachevalier),
[&#x0040;paulkaefer](https://github.com/paulkaefer),
[&#x0040;peterhurford](https://github.com/peterhurford),
[&#x0040;petobens](https://github.com/petobens),
[&#x0040;prosoitos](https://github.com/prosoitos),
[&#x0040;q23qweliuhan](https://github.com/q23qweliuhan),
[&#x0040;qianchd](https://github.com/qianchd),
[&#x0040;quartin](https://github.com/quartin),
[&#x0040;rafazaya](https://github.com/rafazaya),
[&#x0040;randy3k](https://github.com/randy3k),
[&#x0040;rentrop](https://github.com/rentrop),
[&#x0040;richelbilderbeek](https://github.com/richelbilderbeek),
[&#x0040;RMHogervorst](https://github.com/RMHogervorst),
[&#x0040;rmsharp](https://github.com/rmsharp),
[&#x0040;robinklaassen](https://github.com/robinklaassen),
[&#x0040;rpietro](https://github.com/rpietro),
[&#x0040;russHyde](https://github.com/russHyde),
[&#x0040;SchalkWBurger](https://github.com/SchalkWBurger),
[&#x0040;schloerke](https://github.com/schloerke),
[&#x0040;sfr](https://github.com/sfr),
[&#x0040;shashj199](https://github.com/shashj199),
[&#x0040;slmagus](https://github.com/slmagus),
[&#x0040;smilesun](https://github.com/smilesun),
[&#x0040;stefanoborini](https://github.com/stefanoborini),
[&#x0040;step-](https://github.com/step-),
[&#x0040;stufield](https://github.com/stufield),
[&#x0040;taqtiqa-mark](https://github.com/taqtiqa-mark),
[&#x0040;TARehman](https://github.com/TARehman),
[&#x0040;ThierryO](https://github.com/ThierryO),
[&#x0040;tvatter](https://github.com/tvatter),
[&#x0040;w0rp](https://github.com/w0rp),
[&#x0040;wamserma](https://github.com/wamserma),
[&#x0040;WilDoane](https://github.com/WilDoane),
[&#x0040;wlandau](https://github.com/wlandau),
[&#x0040;xiamaz](https://github.com/xiamaz),
[&#x0040;yitang](https://github.com/yitang), and
[&#x0040;zero323](https://github.com/zero323)
