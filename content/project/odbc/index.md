---
title: odbc
date: 2017-02-05T13:41:00Z
authors: [jim]
summary: Connect to ODBC Compatible Databases (using the DBI Interface).
image:
  caption: '[Photo by Photo by Jordan Harrison on Unsplash](https://unsplash.com/photos/40XgDxBfYXM)'
  focal_point: Smart

links:

- icon: video
  icon_pack: fas
  name: video
  url: https://channel9.msdn.com/events/useR-international-R-User-conferences/useR-International-R-User-2017-Conference/odbc-A-modern-database-interface
- icon: images
  icon_pack: fas
  name: slides
  url: https://rawgit.com/jimhester/presentations/master/2017_07_06-UseR2017-odbc/2017_07_06-UseR2017-odbc.html
- icon: github
  icon_pack: fab
  name: code
  url: https://github.com/rstats-db/odbc
- icon: home
  icon_pack: fas
  name: site
  url: https://db.rstudio.com/odbc/

categories:
- package
tags:
- R
- odbc
- package

url_code: ""
url_pdf: ""
url_slides: ""
url_video: ""
---

The goal of the odbc package is to provide a DBI-compliant interface to [Open
Database
Connectivity](https://msdn.microsoft.com/en-us/library/ms710252(v=vs.85).aspx)
(ODBC) drivers. This allows for an efficient, easy to setup connection to any
database with ODBC drivers available, including [SQL
Server](https://www.microsoft.com/en-us/sql-server/),
[Oracle](https://www.oracle.com/database), [MySQL](https://www.mysql.com/),
[PostgreSQL](https://www.postgresql.org/), [SQLite](https://sqlite.org/) and
others. The implementation builds on the
[nanodbc](http://nanodbc.lexicalunit.com/) C++ library.

<iframe src="https://channel9.msdn.com/Events/useR-international-R-User-conferences/useR-International-R-User-2017-Conference/odbc-A-modern-database-interface/player" width="720" height="405" allowFullScreen frameBorder="0" title="odbc - A modern database interface - Microsoft Channel 9 Video"></iframe>
