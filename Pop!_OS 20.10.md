Test
================

``` r
sessionInfo()
```

    ## R version 4.0.2 (2020-06-22)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Pop!_OS 20.10
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3
    ## LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.10.so
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_GB.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=en_GB.UTF-8        LC_COLLATE=en_GB.UTF-8    
    ##  [5] LC_MONETARY=en_GB.UTF-8    LC_MESSAGES=en_GB.UTF-8   
    ##  [7] LC_PAPER=en_GB.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=en_GB.UTF-8 LC_IDENTIFICATION=C       
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods  
    ## [7] base     
    ## 
    ## other attached packages:
    ## [1] benchmarkme_1.0.4 rmarkdown_2.5    
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] benchmarkmeData_1.0.4 rstudioapi_0.11      
    ##  [3] knitr_1.30            magrittr_1.5         
    ##  [5] tidyselect_1.1.0      doParallel_1.0.16    
    ##  [7] lattice_0.20-41       R6_2.4.1             
    ##  [9] rlang_0.4.8           foreach_1.5.1        
    ## [11] stringr_1.4.0         httr_1.4.2           
    ## [13] dplyr_1.0.2           tools_4.0.2          
    ## [15] parallel_4.0.2        grid_4.0.2           
    ## [17] xfun_0.18             htmltools_0.5.0      
    ## [19] iterators_1.0.13      ellipsis_0.3.1       
    ## [21] yaml_2.2.1            digest_0.6.27        
    ## [23] tibble_3.0.4          lifecycle_0.2.0      
    ## [25] crayon_1.3.4          Matrix_1.2-18        
    ## [27] purrr_0.3.4           vctrs_0.3.4          
    ## [29] codetools_0.2-17      glue_1.4.2           
    ## [31] evaluate_0.14         stringi_1.5.3        
    ## [33] compiler_4.0.2        pillar_1.4.6         
    ## [35] generics_0.0.2        pkgconfig_2.0.3

``` r
library(lme4)  # For example data
```

    ## Loading required package: Matrix

``` r
library(brms)
```

    ## Loading required package: Rcpp

    ## Loading 'brms' package (version 2.14.0). Useful instructions
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
```

``` r
get_linear_algebra()
```

    ## $blas
    ## [1] "/usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3"
    ## 
    ## $lapack
    ## [1] "/usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.10.so"

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
plot(res, log = "")
```

![](Pop!_OS%2020.10_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->![](Pop!_OS%2020.10_files/figure-gfm/unnamed-chunk-4-2.png)<!-- -->![](Pop!_OS%2020.10_files/figure-gfm/unnamed-chunk-4-3.png)<!-- -->

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
    ##  32.617   4.357  33.240

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
    ##   8.008   0.037   8.047
