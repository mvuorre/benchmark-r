Results
================
Matti
26/11/2021

``` r
d %>% 
  ggplot(aes(mean, paste(cpu, os, sep = "\n"))) +
  scale_x_continuous("Mean execution time") +
  geom_col() +
  facet_wrap("expr", nrow = 3) +
  theme(axis.title.y = element_blank())
```

<img src="index_files/figure-gfm/results-columns-1.png" width="672" />
