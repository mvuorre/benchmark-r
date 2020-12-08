Test
================

``` r
sessionInfo()
```

    ## R version 4.0.3 (2020-10-10)
    ## Platform: x86_64-w64-mingw32/x64 (64-bit)
    ## Running under: Windows 10 x64 (build 19042)
    ## 
    ## Matrix products: default
    ## 
    ## locale:
    ## [1] LC_COLLATE=English_United Kingdom.1252 
    ## [2] LC_CTYPE=English_United Kingdom.1252   
    ## [3] LC_MONETARY=English_United Kingdom.1252
    ## [4] LC_NUMERIC=C                           
    ## [5] LC_TIME=English_United Kingdom.1252    
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets 
    ## [6] methods   base     
    ## 
    ## other attached packages:
    ## [1] benchmarkme_1.0.4 rmarkdown_2.5    
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] benchmarkmeData_1.0.4 rstudioapi_0.11      
    ##  [3] knitr_1.30            magrittr_1.5         
    ##  [5] tidyselect_1.1.0      doParallel_1.0.16    
    ##  [7] lattice_0.20-41       R6_2.5.0             
    ##  [9] rlang_0.4.8           foreach_1.5.1        
    ## [11] stringr_1.4.0         httr_1.4.2           
    ## [13] dplyr_1.0.2           tools_4.0.3          
    ## [15] parallel_4.0.3        grid_4.0.3           
    ## [17] xfun_0.19             tinytex_0.26         
    ## [19] htmltools_0.5.0       iterators_1.0.13     
    ## [21] ellipsis_0.3.1        yaml_2.2.1           
    ## [23] digest_0.6.27         tibble_3.0.4         
    ## [25] lifecycle_0.2.0       crayon_1.3.4         
    ## [27] Matrix_1.2-18         purrr_0.3.4          
    ## [29] vctrs_0.3.4           codetools_0.2-16     
    ## [31] glue_1.4.2            evaluate_0.14        
    ## [33] stringi_1.5.3         pillar_1.4.6         
    ## [35] compiler_4.0.3        generics_0.1.0       
    ## [37] pkgconfig_2.0.3

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

    ## Loading 'brms' package (version 2.14.4). Useful instructions
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

    ## -- Attaching packages ----------------- tidyverse 1.3.0 --

    ## v ggplot2 3.3.2     v purrr   0.3.4
    ## v tibble  3.0.4     v dplyr   1.0.2
    ## v tidyr   1.1.2     v stringr 1.4.0
    ## v readr   1.4.0     v forcats 0.5.0

    ## -- Conflicts -------------------- tidyverse_conflicts() --
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
    ## [1] ""

``` r
get_cpu()
```

    ## $vendor_id
    ## [1] "AuthenticAMD"
    ## 
    ## $model_name
    ## [1] "AMD Ryzen 9 3900X 12-Core Processor"
    ## 
    ## $no_of_cores
    ## [1] 24

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
    ## 1 matrix_cal 1.45  0.0012   1.45 
    ## 2 matrix_fun 1.66  0        1.66 
    ## 3 prog       0.630 0.0172   0.646

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

    ## Warning in system(paste(CXX, ARGS), ignore.stdout = TRUE,
    ## ignore.stderr = TRUE): '-E' not found

    ##    user  system elapsed 
    ##    1.76    0.09   38.42

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
    ##   10.00    0.00   10.02
