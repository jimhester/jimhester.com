---
title: vroom
date: 2019-05-04T19:10:00Z
authors: [jim]
summary: Read and write rectangular data (like 'csv', 'tsv' and 'fwf') quickly into R.
image:
  caption: '[Photo by Chris Peeters from Pexels](https://www.pexels.com/photo/speed-racing-speedway-racing-car-12801/)'
  focal_point: Smart

links:

- icon: video
  icon_pack: fas
  name: video
  url: https://www.youtube.com/watch?v=RA9AjqZXxMU&t=10s
- icon: images
  icon_pack: fas
  name: slides
  url: https://speakerdeck.com/jimhester/vroom
- icon: github
  icon_pack: fab
  name: code
  url: https://github.com/r-lib/vroom
- icon: home
  icon_pack: fas
  name: site
  url: https://vroom.r-lib.org/
- icon: pencil-alt
  icon_pack: fas
  name: 1.0.0 post
  url: https://www.tidyverse.org/articles/2019/05/vroom-1-0-0/

categories:
- package
tags:
- R
- vroom
- package

url_code: ""
url_pdf: ""
url_slides: ""
url_video: ""
---

When reading it uses a quick initial indexing step, then reads the
values lazily ,so only the data you actually use needs to be read. The writer
formats the data in parallel and writes to disk asynchronously from formatting.

vroom excels at text heavy datasets, in some cases exceeding 1 Gb per second
reading time on commodity laptops.

<iframe width="720" height="405" src="https://www.youtube.com/embed/RA9AjqZXxMU?start=10" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<script async class="speakerdeck-embed" data-id="533c534c861840c7829b21ce2e1397a9" data-ratio="1.77777777777778" src="//speakerdeck.com/assets/embed.js"></script>

