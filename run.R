# This script conducts a set of standard-ish benchmarks and
# saves results to a csv, including data on the system

library(brms)
library(cmdstanr)
library(benchmarkme)
library(microbenchmark)
library(tidyverse)

options(brms.backend = "cmdstanr")

# Compile a model to sample from in benchmarks
# from ?brm()
brms_sampler <- brm(
  rating ~ period + carry + cs(treat),
  data = inhaler, 
  family = sratio("logit"),
  chains = 0
)

# Run benchmarks
results <- microbenchmark(
  `Matrix calculation` = benchmark_matrix_cal(runs = 1), 
  `Matrix functions` = benchmark_matrix_fun(runs = 1),
  `Programming` = benchmark_prog(runs = 1),
  `Stan compile` = brm(
    rating ~ period + carry + cs(treat),
    data = inhaler, 
    family = sratio("logit"),
    chains = 0
  ),
  `Stan sample` = update(
    brms_sampler, 
    iter = 10000, 
    chains = 1, 
    refresh = 0,
    recompile = FALSE
  ),
  times = 3
)

cpu <- get_cpu()$model_name
os <- sessionInfo()[[4]]
date <- Sys.Date()
blas <- get_linear_algebra()$blas
lapack <- get_linear_algebra()$lapack

summary(results) %>% 
  as_tibble() %>% 
  mutate(
    cpu, os, date, blas, lapack
  ) %>% 
  write_csv(
    "results.csv", append = TRUE
  )
  

