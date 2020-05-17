library(tidyverse)
example_df <- data.table::fread("   Item     Money_In    total_bought  Money_Out  total_sold  Net_Spend
  unit1    £192.60m    15            £64.78m    13          £-127.82m")

unmoney_mi <- function(x){
  x %>%
    str_remove("£") %>%
    str_remove("m") %>%
    as.numeric() * 10 ^ 6
}

unmoney <- function(x){
  if (x %>% str_detect("m")) {
    unmoney_mi(x)
  } else {
    x
  }
}

example_df %>% mutate_all(unmoney)
