library(tidyverse)
library(viridis)
library(tabulizer)
library(janitor)

# website: https://www.fns.usda.gov/snap/foods-typically-purchased-supplemental-nutrition-assistance-program-snap-households

snap_pdf <-
  extract_tables("https://fns-prod.azureedge.net/sites/default/files/ops/SNAPFoodsTypicallyPurchased-Appendices.pdf")

snap_appendix1 <- 
  snap_pdf %>%
  map(as_tibble) %>%
  map_df(~ slice(., -2)) %>% # create a dataframe
  mutate(col_dat = case_when(grepl("[0-9]", V2) ~ V2,
                           grepl("[0-9]", V3) ~ V3,
                           TRUE ~ "")) %>% 
  filter(col_dat != "") %>% 
  select(V1, col_dat) %>%
  slice(1:238) %>%  # only Appendix A
  separate(col_dat, " ", into = c("snap_rank", "snap_dollars_in_millions", "snap_pct_total_expenditures", "nonsnap_rank", "nonsnap_dollars_in_millions", "nonsnap_pct_total_expenditures")) %>% 
  rename(commodity = V1) %>%
  mutate_at(vars(snap_rank:nonsnap_pct_total_expenditures), funs(as.numeric(gsub(",|%|\\$", "", .)))) %>%
  mutate_at(vars(contains("pct")), funs(./100))

snap_appendix1 <- write_csv(snap_appendix1, "snap_appendix1.csv")

snap_appendix1_tidy <-
  snap_appendix1 %>% 
  gather(category, value, -1) %>% 
  mutate(household =
           case_when(grepl("nonsnap", category) ~ "nonsnap",
                               TRUE ~ "snap"),
         column =
           case_when(grepl("dollars_in_millions", category) ~ "dollars_in_millions",
                                         grepl("pct_total_expenditures", category) ~ "pct_total_expenditures",
                                         grepl("rank", category) ~ "rank")) %>% 
  select(-category)

snap_appendix1_household <-
  snap_appendix1_tidy %>%  
  spread(column, value)

# snap_appendix1_tidy %>% 
#   filter(column == "rank") %>% 
#   group_by(commodity) %>% 
#   mutate(slope = (value[household == "snap"] - value[household == "nonsnap"])/(2-1)) %>% 
#   ggplot(aes(x = household, y = value, group = commodity, colour = slope > 0)) +
#   geom_line()
