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
    ##  [1] LC_CTYPE=C.UTF-8       LC_NUMERIC=C           LC_TIME=C.UTF-8        LC_COLLATE=C.UTF-8    
    ##  [5] LC_MONETARY=C.UTF-8    LC_MESSAGES=C.UTF-8    LC_PAPER=C.UTF-8       LC_NAME=C             
    ##  [9] LC_ADDRESS=C           LC_TELEPHONE=C         LC_MEASUREMENT=C.UTF-8 LC_IDENTIFICATION=C   
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ##  [1] rmarkdown_2.5.2   forcats_0.5.0     stringr_1.4.0     dplyr_1.0.2       purrr_0.3.4      
    ##  [6] readr_1.4.0       tidyr_1.1.2       tibble_3.0.4      ggplot2_3.3.2     tidyverse_1.3.0  
    ## [11] benchmarkme_1.0.4 brms_2.14.0       Rcpp_1.0.5        lme4_1.1-25       Matrix_1.2-18    
    ## 
    ## loaded via a namespace (and not attached):
    ##   [1] minqa_1.2.4           colorspace_1.4-1      ellipsis_0.3.1        ggridges_0.5.2       
    ##   [5] rsconnect_0.8.16      estimability_1.3      markdown_1.1          fs_1.5.0             
    ##   [9] base64enc_0.1-3       rstudioapi_0.11       rstan_2.21.3          DT_0.16              
    ##  [13] lubridate_1.7.9       fansi_0.4.1           mvtnorm_1.1-1         xml2_1.3.2           
    ##  [17] bridgesampling_1.0-0  codetools_0.2-18      splines_4.0.3         doParallel_1.0.16    
    ##  [21] knitr_1.30            shinythemes_1.1.2     bayesplot_1.7.2       jsonlite_1.7.1       
    ##  [25] nloptr_1.2.2.2        broom_0.7.2           dbplyr_1.4.4          shiny_1.5.0          
    ##  [29] httr_1.4.2            compiler_4.0.3        emmeans_1.5.2-1       backports_1.1.10     
    ##  [33] assertthat_0.2.1      fastmap_1.0.1         cli_2.1.0             later_1.1.0.1        
    ##  [37] htmltools_0.5.0       prettyunits_1.1.1     tools_4.0.3           igraph_1.2.6         
    ##  [41] coda_0.19-4           gtable_0.3.0          glue_1.4.2            reshape2_1.4.4       
    ##  [45] tinytex_0.27          V8_3.3.1              cellranger_1.1.0      vctrs_0.3.4          
    ##  [49] nlme_3.1-150          iterators_1.0.13      crosstalk_1.1.0.1     xfun_0.19            
    ##  [53] ps_1.4.0              rvest_0.3.6           mime_0.9              miniUI_0.1.1.1       
    ##  [57] lifecycle_0.2.0       gtools_3.8.2          statmod_1.4.35        MASS_7.3-53          
    ##  [61] zoo_1.8-8             scales_1.1.1          colourpicker_1.1.0    hms_0.5.3            
    ##  [65] promises_1.1.1        Brobdingnag_1.2-6     parallel_4.0.3        inline_0.3.16        
    ##  [69] shinystan_2.5.0       yaml_2.2.1            curl_4.3              gridExtra_2.3        
    ##  [73] loo_2.3.1             StanHeaders_2.21.0-6  stringi_1.5.3         dygraphs_1.1.1.6     
    ##  [77] foreach_1.5.1         boot_1.3-25           pkgbuild_1.1.0        benchmarkmeData_1.0.4
    ##  [81] rlang_0.4.8           pkgconfig_2.0.3       matrixStats_0.57.0    evaluate_0.14        
    ##  [85] lattice_0.20-41       rstantools_2.1.1      htmlwidgets_1.5.2     processx_3.4.4       
    ##  [89] tidyselect_1.1.0      plyr_1.8.6            magrittr_1.5          R6_2.5.0             
    ##  [93] generics_0.1.0        DBI_1.1.0             haven_2.3.1           pillar_1.4.6         
    ##  [97] withr_2.3.0           xts_0.12.1            abind_1.4-5           modelr_0.1.8         
    ## [101] crayon_1.3.4          utf8_1.1.4            readxl_1.3.1          grid_4.0.3           
    ## [105] blob_1.2.1            callr_3.5.1           threejs_0.3.3         reprex_0.3.0         
    ## [109] digest_0.6.27         xtable_1.8-4          httpuv_1.5.4          RcppParallel_5.0.2   
    ## [113] stats4_4.0.3          munsell_0.5.0         rsthemes_0.1.0        shinyjs_2.0.0

``` r
knitr::opts_chunk$set(error = TRUE)
```

``` r
library(lme4)  # For example data
library(brms)
options(mc.cores = parallel::detectCores(logical = FALSE))
library(benchmarkme)
library(tidyverse)
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
res %>% 
  group_by(test_group) %>% 
  summarise(across(user:elapsed, mean))
```

    ## # A tibble: 3 x 4
    ##   test_group  user   system elapsed
    ##   <chr>      <dbl>    <dbl>   <dbl>
    ## 1 matrix_cal 0.423 0.103      0.243
    ## 2 matrix_fun 1.39  2.95       0.222
    ## 3 prog       0.491 0.000200   0.493

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

    ## Warning in system(paste(CPP, ARGS), ignore.stdout = TRUE, ignore.stderr = TRUE): error in
    ## running command

    ##    user  system elapsed 
    ##  38.140   3.408  39.081

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
    ##   7.491   0.000   7.490
