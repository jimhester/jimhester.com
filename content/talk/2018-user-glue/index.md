---
aliases: [glue]
authors: [jim]
abstract_short: ""
projects: [glue]
abstract: >
  String interpolation, evaluating a variable name to a value within a string,
  isa feature of many programming languages including Python, Julia,
  Javascript,Rust, and most Unix Shells. R's `sprintf()` and `paste()`
  functions provide some of this functionality, but have limitations which make
  them cumbersome to use. There are also some existing add on packages with
  similar functionality,however each has drawbacks.The glue package performs
  robust string interpolation for R. This includes evaluation of variables and
  arbitrary R code,with a clean and simple syntax. Because it is
  dependency-free, it is easy to incorporate into packages. In addition, glue
  provides an extensible interface to perform more complex transformations; such
  as `glue_sql()` to construct SQL queries with automatically quoted
  variables.This talk will show how to utilize glue to write beautiful code
  which is easy to read, write and maintain. We will also discuss ways to best
  use glue when performance is a concern. Finally we will create custom glue
  functions tailored towards specific use cases, such as JSON construction,
  colored messages, emoji interpolation and more.
date: 2018-07-13T18:00:00Z
event: UseR! 2018
image:
  focal_point: Center
location: Brisbane, Australia
selected: true
title: "Glue Strings To Data With Glue"
links:
- icon: images
  icon_pack: fas
  name: slides
  url: https://rawgit.com/jimhester/presentations/master/2018_07_13-Glue_strings_to_data_with_glue/2018_03_28-Glue_string_to_data_with_glue.html
- icon: video
  icon_pack: fas
  name: video
  url: https://www.youtube.com/watch?v=XQmBcpQl8K8
tags: [talk, r, glue]
---

{{< youtube XQmBcpQl8K8 >}}
