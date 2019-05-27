####################################
# Extracting SNAP Expenditure Data #
####################################


# libraries ---------------------------------------------------------------

library(tidyverse)
library(viridis)
library(tabulizer)
library(janitor)

# data --------------------------------------------------------------------

# website: https://www.fns.usda.gov/snap/foods-typically-purchased-supplemental-nutrition-assistance-program-snap-households

snap_summary <-
  extract_tables("https://fns-prod.azureedge.net/sites/default/files/ops/SNAPFoodsTypicallyPurchased-Summary.pdf",
                 pages = 2,
                 method = "stream")

snap_appendices <-
  extract_tables("https://fns-prod.azureedge.net/sites/default/files/ops/SNAPFoodsTypicallyPurchased-Appendices.pdf")

# summary -----------------------------------------------------------------

snap_summary_tab <- 
  snap_summary[[1]] %>% 
  as_tibble() %>% 
  slice(-1:-3) %>% 
  rename(summary_category = V1) %>% 
  separate(V2, "\\s+", into = c("snap_rank", "snap_dollars_in_millions", "snap_pct_total_expenditures")) %>%
  separate(V3, "\\s+", into = c("nonsnap_rank", "nonsnap_dollars_in_millions", "nonsnap_pct_total_expenditures")) %>% 
  mutate_at(vars(snap_rank:nonsnap_pct_total_expenditures), funs(as.numeric(gsub(",|%|\\$", "", .)))) %>%
  mutate_at(vars(contains("pct")), list(~ ./100)) %>% 
  slice(-31)

# appendix 1 --------------------------------------------------------------

# appendix a-1

snap_appendix_a1 <- 
  snap_appendices %>%
  map(as_tibble) %>%
  map_df(~ slice(., -2)) %>% # create a dataframe
  mutate(col_dat = case_when(grepl("[0-9]", V2) ~ V2,
                             grepl("[0-9]", V3) ~ V3,
                             TRUE ~ "")) %>% 
  filter(col_dat != "") %>% 
  select(V1, col_dat) %>%
  slice(1:238) %>%  # only Appendix A1
  separate(col_dat, "\\s+", into = c("snap_rank", "snap_dollars_in_millions", "snap_pct_total_expenditures", "nonsnap_rank", "nonsnap_dollars_in_millions", "nonsnap_pct_total_expenditures")) %>% 
  rename(commodity = V1) %>%
  mutate_at(vars(snap_rank:nonsnap_pct_total_expenditures), funs(as.numeric(gsub(",|%|\\$", "", .)))) %>%
  mutate_at(vars(contains("pct")), list(~ ./100))

# appendix a-2 

snap_appendix_a2 <- 
  snap_appendices %>%
  map(as_tibble) %>%
  map_df(~ slice(., -2)) %>% # create a dataframe
  select(V1:V4) %>% 
  slice(247:1277) %>%  # only Appendix A2 
  rename(commodity = V1,
         subcommodity = V2) %>% 
  mutate(subcommodity = case_when(subcommodity == "" ~ V3,
                                  TRUE ~ subcommodity),
         col_dat = case_when(grepl("[0-9]", V3) ~ V3,
                             grepl("[0-9]", V4) ~ V4,
                             TRUE ~ "")) %>% 
  select(-V3:-V4) %>% 
  filter(col_dat != "") %>% 
  separate(col_dat, "\\s+", into = c("snap_rank", "snap_dollars_in_millions", "snap_pct_total_expenditures", "nonsnap_rank", "nonsnap_dollars_in_millions", "nonsnap_pct_total_expenditures")) %>%  # different number of spaces
  mutate_at(vars(snap_rank:nonsnap_pct_total_expenditures), funs(as.numeric(gsub(",|%|\\$", "", .)))) %>%
  mutate_at(vars(contains("pct")), list(~ ./100))


# appendix b --------------------------------------------------------------

snap_appendix_b <- 
  snap_appendices %>%
  map(as_tibble) %>%
  map_df(~ slice(., -2)) %>% # create a dataframe
  select(V1:V3) %>% 
  slice(1280:2304) %>% 
  rename(commodity = V1,
         subcommodity = V2,
         summary_category = V3)

  # write data --------------------------------------------------------------

snap_summary_tab <-
  write_csv(snap_summary_tab, here::here("output", "snap_summary_tab.csv"))

snap_appendix_a1 <- 
  write_csv(snap_appendix_a1, here::here("output", "snap_appendix_a1.csv"))

snap_appendix_a2 <- 
  write_csv(snap_appendix_a2, here::here("output", "snap_appendix_a2.csv"))

snap_appendix_b <- 
  write_csv(snap_appendix_b, here::here("output", "snap_appendix_b.csv"))
