Results
================
Matti
26/11/2021

Where possible these systems use optimised blas/lapack.

``` r
d %>% 
  ggplot(aes(paste(os, cpu, sep = "\n"), mean)) +
  scale_y_continuous(
    "Mean execution time", 
    expand = expansion(c(0, .02)),
    labels = ~str_glue("{.}s")
  ) +
  scale_x_discrete("System") +
  geom_col(fill = "gray80", col = "black") +
  geom_errorbar(aes(ymin = min, ymax = max), width = .1) +
  facet_wrap("expr", ncol = 1, scales = "free_y")
```

<img src="README_files/figure-gfm/results-columns-1.png" width="672" />
