---
aliases: [odbc]
authors: [jim]
abstract_short: ""
abstract: >
    Getting data into and out of databases is one of the most fundamental parts of data science. Much of the
    world’s data is stored in databases, including traditional databases such as SQL Server, MySQL, PostgreSQL,
    and Oracle, as well as non-traditional databases like Hive, BigQuery, Redshift and Spark.
    The odbc package provides an R interface to [Open Database Connectivity (ODBC)](https://docs.microsoft.com/en-us/sql/odbc/microsoft-open-database-connectivity-odbc?view=sql-server-2017) drivers and databases
    including all those listed previously. odbc provides consistent output; including support for timestamps and
    64-bit integers, improved performance for reading and writing, and complete compatibility with the [DBI](https://CRAN.R-project.org/package=DBI)
    package.

    odbc connections can be used as [dplyr](https://CRAN.R-project.org/package=dplyr) backends, allowing one to perform expensive queries within the
    database and reduce the need to transfer and load large amounts of data in an R session. odbc is also
    integrated into the [RStudio IDE](https://www.rstudio.com/products/rstudio/), with dialogs to setup and establish connections, preview available tables
    and schemas and run ad-hoc SQL queries. The [RStudio Professional Products](https://www.rstudio.com/products/team/) are bundled with a suite of
    ODBC drivers, to make it easy for System Administrators to establish and support connections to a variety
    of database technologies.
date: 2017-07-06T18:00:00Z
event: UseR! 2017
event_url: https://www.user2017.brussels/
image:
  caption: '[Photo by NeONBRAND on Unsplash](https://unsplash.com/photos/uq5RMAZdZG4)'
  focal_point: Smart
location: Brussels, Belgium
selected: true
title: "odbc: A modern database interface"
project: odbc
links:
- icon: images
  icon_pack: fas
  name: slides
  url: https://rawgit.com/jimhester/presentations/master/2017_07_06-UseR2017-odbc/2017_07_06-UseR2017-odbc.html
- icon: video
  icon_pack: fas
  name: video
  url: https://channel9.msdn.com/events/useR-international-R-User-conferences/useR-International-R-User-2017-Conference/odbc-A-modern-database-interface
tags: [talk, r]
---

<iframe src="https://channel9.msdn.com/Events/useR-international-R-User-conferences/useR-International-R-User-2017-Conference/odbc-A-modern-database-interface/player" width="960" height="540" allowFullScreen frameBorder="0" title="odbc - A modern database interface - Microsoft Channel 9 Video"></iframe>
