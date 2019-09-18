---
date: '2019-04-17'
title: 'RStats tip #2: avoid missing(), prefer NULL'
summary: This video explains why it is best to avoid using `missing()` when writing R functions.
video: true
image:
  focal_point: Center
tags: [R, video]
---

Functions in R often take optional values, one way to implement this is using
the `missing()` function.

`missing()` returns TRUE or FALSE if the user passed a value to an argument.
This behavior works well interactively.

However functions which use `missing()` are much more challenging to call
programmatically.

An alternative, using `NULL` to denote missing values, in contrast is simple to
call programmatically and better reveals that the argument is option.

{{< youtube dwS67RPq37Q>}}
