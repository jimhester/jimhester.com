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
date: 2019-09-25T18:00:00Z
event: Cleveland R Users Group
event_url: https://www.meetup.com/Cleveland-UseR-Group/events/263391241/
location: Cleveland, OH
image:
  focal_point: Smart
selected: true
title: "Real-time file import with the vroom package"
links:
- icon: images
  icon_pack: fas
  name: slides
  url: https://speakerdeck.com/jimhester/vroom
tags: [talk, r, vroom]
---
