Test
================

``` r
sessionInfo()
```

    ## R version 4.0.3 (2020-10-10)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Ubuntu 20.04.1 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3
    ## LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/liblapack.so.3
    ## 
    ## locale:
    ##  [1] LC_CTYPE=C.UTF-8       LC_NUMERIC=C           LC_TIME=C.UTF-8       
    ##  [4] LC_COLLATE=C.UTF-8     LC_MONETARY=C.UTF-8    LC_MESSAGES=C.UTF-8   
    ##  [7] LC_PAPER=C.UTF-8       LC_NAME=C              LC_ADDRESS=C          
    ## [10] LC_TELEPHONE=C         LC_MEASUREMENT=C.UTF-8 LC_IDENTIFICATION=C   
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] benchmarkme_1.0.4 rmarkdown_2.4.6  
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] benchmarkmeData_1.0.4 rstudioapi_0.11       knitr_1.30           
    ##  [4] magrittr_1.5          tidyselect_1.1.0      doParallel_1.0.16    
    ##  [7] lattice_0.20-41       R6_2.4.1              rlang_0.4.8          
    ## [10] foreach_1.5.1         stringr_1.4.0         httr_1.4.2           
    ## [13] dplyr_1.0.2           tools_4.0.3           parallel_4.0.3       
    ## [16] grid_4.0.3            xfun_0.18             htmltools_0.5.0      
    ## [19] iterators_1.0.13      ellipsis_0.3.1        yaml_2.2.1           
    ## [22] digest_0.6.26         tibble_3.0.4          lifecycle_0.2.0      
    ## [25] crayon_1.3.4          Matrix_1.2-18         purrr_0.3.4          
    ## [28] vctrs_0.3.4           codetools_0.2-17      glue_1.4.2           
    ## [31] evaluate_0.14         stringi_1.5.3         compiler_4.0.3       
    ## [34] pillar_1.4.6          generics_0.0.2        pkgconfig_2.0.3

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
    ## [1] "/usr/lib/x86_64-linux-gnu/openblas-pthread/liblapack.so.3"

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

![](Ubuntu%2020.04.1%20LTS_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->![](Ubuntu%2020.04.1%20LTS_files/figure-gfm/unnamed-chunk-4-2.png)<!-- -->![](Ubuntu%2020.04.1%20LTS_files/figure-gfm/unnamed-chunk-4-3.png)<!-- -->

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

    ## Warning in system(paste(CPP, ARGS), ignore.stdout = TRUE, ignore.stderr = TRUE):
    ## error in running command

    ##    user  system elapsed 
    ##  36.636   4.803  37.440

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
    ##   7.511   0.000   7.509
