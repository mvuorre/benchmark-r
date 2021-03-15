Test
================

``` r
sessionInfo()
```

    ## R version 4.0.3 (2020-10-10)
    ## Platform: x86_64-apple-darwin17.0 (64-bit)
    ## Running under: macOS Big Sur 10.16
    ## 
    ## Matrix products: default
    ## LAPACK: /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRlapack.dylib
    ## 
    ## locale:
    ## [1] en_GB.UTF-8/en_GB.UTF-8/en_GB.UTF-8/C/en_GB.UTF-8/en_GB.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] benchmarkme_1.0.6 rmarkdown_2.7.2  
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] benchmarkmeData_1.0.4 compiler_4.0.3        pillar_1.5.1          iterators_1.0.13     
    ##  [5] tools_4.0.3           digest_0.6.27         evaluate_0.14         lifecycle_1.0.0      
    ##  [9] tibble_3.1.0          lattice_0.20-41       pkgconfig_2.0.3       rlang_0.4.10         
    ## [13] Matrix_1.3-2          foreach_1.5.1         DBI_1.1.1             rstudioapi_0.13      
    ## [17] yaml_2.2.1            parallel_4.0.3        xfun_0.22             dplyr_1.0.5          
    ## [21] httr_1.4.2            stringr_1.4.0         knitr_1.31            generics_0.1.0       
    ## [25] vctrs_0.3.6           rsthemes_0.1.0        grid_4.0.3            tidyselect_1.1.0     
    ## [29] glue_1.4.2            R6_2.5.0              fansi_0.4.2           purrr_0.3.4          
    ## [33] magrittr_2.0.1        codetools_0.2-18      htmltools_0.5.1.1     ellipsis_0.3.1       
    ## [37] assertthat_0.2.1      utf8_1.2.1            stringi_1.5.3         doParallel_1.0.16    
    ## [41] crayon_1.4.1

``` r
knitr::opts_chunk$set(error = TRUE)
```

``` r
library(lme4)  # For example data
```

    ## Loading required package: Matrix

``` r
library(brms)
```

    ## Loading required package: Rcpp

    ## Loading 'brms' package (version 2.15.0). Useful instructions
    ## can be found by typing help('brms'). A more detailed introduction
    ## to the package is available through vignette('brms_overview').

    ## 
    ## Attaching package: 'brms'

    ## The following object is masked from 'package:lme4':
    ## 
    ##     ngrps

    ## The following object is masked from 'package:stats':
    ## 
    ##     ar

``` r
options(mc.cores = parallel::detectCores(logical = FALSE))
library(benchmarkme)
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────────────────────── tidyverse 1.3.0 ──

    ## ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
    ## ✓ tibble  3.1.0     ✓ dplyr   1.0.5
    ## ✓ tidyr   1.1.3     ✓ stringr 1.4.0
    ## ✓ readr   1.4.0     ✓ forcats 0.5.1

    ## ── Conflicts ────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## x tidyr::expand() masks Matrix::expand()
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()
    ## x tidyr::pack()   masks Matrix::pack()
    ## x tidyr::unpack() masks Matrix::unpack()

``` r
get_linear_algebra()
```

    ## $blas
    ## [1] ""
    ## 
    ## $lapack
    ## [1] "/Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRlapack.dylib"

``` r
get_cpu()
```

    ## $vendor_id
    ## [1] "GenuineIntel"
    ## 
    ## $model_name
    ## [1] "Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz"
    ## 
    ## $no_of_cores
    ## [1] 8

Standard benchmarks

``` r
res <- benchmark_std(runs = 5)
res %>% 
  group_by(test_group) %>% 
  summarise(across(user:elapsed, mean))
```

    ## # A tibble: 3 x 4
    ##   test_group  user system elapsed
    ##   <chr>      <dbl>  <dbl>   <dbl>
    ## 1 matrix_cal 2.44  0.0111   2.45 
    ## 2 matrix_fun 3.09  0.0108   3.11 
    ## 3 prog       0.664 0.0269   0.698

Model compilation time

``` r
system.time(
  brms_sampler <- brm(
    Reaction ~ Days + (Days | Subject), 
    data = sleepstudy, 
    chains = 0
  )
)
```

    ##    user  system elapsed 
    ##  31.797   1.914  35.131

Sampling time

``` r
system.time(
  update(
    brms_sampler, 
    iter = 10000, 
    chains = 1, 
    refresh = 0
  )
)
```

    ## Start sampling

    ##    user  system elapsed 
    ##   8.399   0.062   8.463
