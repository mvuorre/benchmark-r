Results
================
Matti
26/11/2021

``` r
d %>% 
  ggplot(aes(mean, paste(os, cpu, blas, sep = "\n"))) +
  scale_x_continuous("Mean execution time", expand = expansion(c(0, .1))) +
  geom_col() +
  facet_wrap("expr", ncol = 1) +
  theme(axis.title.y = element_blank())
```

<img src="README_files/figure-gfm/results-columns-1.png" width="672" />
