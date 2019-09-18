---
date: '2019-04-24'
title: 'Using git bisect to pinpoint bugs in your commit history'
summary: This video demonstrates one of my favorite lesser known features of git, git bisect.
video: true
image:
  focal_point: Center
tags: [R, video, git]
---

git bisect is most useful when a bug is introduced in a codebase, but is not
discovered until later.

Pinpointing which commit introduced a bug often goes a long way towards
resolving it, and git bisect is the tool you can use to find the first bad
commit.

You could do this by simply starting at the first commit and testing each
commit in turn. However git bisect is smarter than this, and uses a binary
search, which can drastically reduce the number of commits you need to check.

{{< youtube KKeucpfAuuA>}}

