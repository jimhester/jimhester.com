---
aliases: [vroom]
projects: [vroom]
authors: [jim]
abstract_short: ""
abstract: >
  File import in R could be considered a solved problem, with multiple widely
  used packages (data.table, readr, and others) providing fast, robust import
  of common formats in addition to the functions available in base R. However I
  feel there is still room for improvement in existing approaches. vroom is
  able to index and then query multi-Gigabyte files, including those with
  categorical, text and temporal data, in near real-time. This is a huge boon
  for interactive data analysis as you can jump directly into exploratory
  analysis without sampling or long waits for full import. vroom leverages the
  Altrep framework introduced in R 3.5 along with lazy, just-in-time parsing of
  the data to provide this improved latency without requiring changes to
  existing data manipulation code. I will throughly explain the techniques used
  in vroom to ensure good performance, describe challenges overcome in
  implementing it, and provide an interactive demonstration of its
  capabilities.
date: 2019-07-12T18:00:00Z
event: UseR! 2019
event_url: https://user2019.r-project.org
location: Toulouse, France
image:
  focal_point: Smart
selected: true
title: "vroom: Because life is too short to read slow"
links:
- icon: images
  icon_pack: fas
  name: slides
  url: https://speakerdeck.com/jimhester/vroom
- icon: video
  icon_pack: fas
  name: video
  url: https://www.youtube.com/watch?v=RA9AjqZXxMU&t=10s
tags: [talk, r, vroom]
---

<iframe width="720" height="405" src="https://www.youtube.com/embed/RA9AjqZXxMU?start=10" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<script async class="speakerdeck-embed" data-id="533c534c861840c7829b21ce2e1397a9" data-ratio="1.77777777777778" src="//speakerdeck.com/assets/embed.js"></script>
