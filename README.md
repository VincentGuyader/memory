
<!-- README.md is generated from README.Rmd. Please edit that file -->
memory
======

The goal of memory is to provide a simple (useless) shiny app to *crash* test memroy usage in production (shinyproxy, kubernetes,...)

Installation
------------

``` r
#install.packages("remotes")
remotes::install_github("vincentguyader/memory")
```

Example
-------

``` r
memory::run_app()
```

![](readme-figs/demo.png)
