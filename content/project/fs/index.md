---
title: fs
date: 2018-01-19T13:56:00Z
authors: [jim]
summary: A cross-platform, uniform interface to file system operations.
image:
  caption: '[Photo by Maarten van den Heuvel on Unsplash](https://unsplash.com/photos/8EzNkvLQosk)'
  focal_point: Smart

links:

- icon: github
  icon_pack: fab
  name: code
  url: https://github.com/r-lib/fs
- icon: home
  icon_pack: fas
  name: site
  url: https://fs.r-lib.org/
- icon: pencil-alt
  icon_pack: fas
  name: 1.0.0 post
  url: https://www.tidyverse.org/articles/2018/01/fs-1.0.0/

categories:
- package
tags:
- R
- fs
- package

url_code: ""
url_pdf: ""
url_slides: ""
url_video: ""
---

**fs** provides a cross-platform, uniform interface to file system
operations. It shares the same back-end component as
[nodejs](https://nodejs.org), the
[libuv](http://docs.libuv.org/en/v1.x/fs.html) C library, which brings
the benefit of extensive real-world use and rigorous cross-platform
testing. The name, and some of the interface, is partially inspired by
Rust’s [fs module](https://doc.rust-lang.org/std/fs/index.html).
