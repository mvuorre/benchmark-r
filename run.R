library(rmarkdown)
library(benchmarkme)
os <- sessionInfo()[[4]]

render("Benchmark.Rmd", output_file = paste0(os, ".md"))
