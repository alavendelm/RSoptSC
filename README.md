
<!-- README.md is generated from README.Rmd. Please edit that file -->
RSoptSC
=======

# RSoptSC <img src="man/figures/logo.svg" align="right" alt="" width="320" />

[![Build
Status](https://travis-ci.com/mkarikom/RSoptSC.svg?branch=master)](https://travis-ci.com/mkarikom/RSoptSC)

## Updates

SoptSC is also available as a MATLAB package [here](https://github.com/wangshuxiong/soptsc).

  - Read the SoptSC article in [NAR](https://doi.org/10.1093/nar/gkz204)

  - SoptSC is also available as a MATLAB package
    [here](https://github.com/wangshuxiong/soptsc)

## Installation

Installation
------------

``` r
install.packages("devtools")
library(devtools)
install_github("mkarikom/RSoptSC")
```

Features
--------

-   Inference of cell-cell communication between single cells

-   Integration of multiple analyses in a consistent mathematical framework: clustering, marker genes, pseudotime, and lineage inference

-   Cell-cell similarity matrix construction to improve clustering

-   NMF-based marker gene identification

-   Prediction of the number of clusters present (via eigengap properties of the similarity matrix)

-   Prediction of the initial cell in pseudotime

Documentation
-------------

Full details of RSoptSC and examples are available [here](https://mkarikom.github.io/RSoptSC).
