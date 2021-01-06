---
aliases: [cpp11-welding]
projects: [cpp11]
authors: [jim]
abstract_short: ""
abstract: |
    R and S have a long history of interacting with compiled languages.

    The Rcpp package has been a widely successful project, however over the years a number of issues and additional C++ features have arisen.
    Modifying Rcpp to fix or include these would require a great deal of work, or in some cases would be impossible without severely breaking backwards compatibility.

    cpp11 is a ground up rewrite of C++ bindings to R with different design trade-offs and features.

    This talk will focus on the new features of cpp11 including:

    - Enforcing copy-on-write semantics.
    - Improving the safety of using the R API from C++ code.
    - Supporting ALTREP objects.
    - Using UTF-8 strings everywhere.
    - Applying newer C++11 features.

    We will also discuss the mechanics of transitioning packages from Rcpp to cpp11 and why we feel cpp11 is a solid foundation to build upon in the years ahead.
date: 2020-11-14T11:00:00Z
event: satRday Columbus
event_url: https://columbus2020.satrdays.org/
location: Virtual
image:
  preview_only: true
selected: true
title: "cpp11 - welding R and C++"
links:
- icon: images
  icon_pack: fas
  name: slides
  url: https://speakerdeck.com/jimhester/cpp11-welding-r-and-c-plus-plus
- icon: video
  icon_pack: fas
  name: video
  url: https://youtu.be/_kq0N0FNIjA
tags: [talk, r, github-actions]
---

{{< youtube _kq0N0FNIjA>}}
