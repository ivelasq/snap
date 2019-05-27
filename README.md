# Extracting SNAP Expenditure Data

# Introduction

In 2016, the USDA released a study entitled “Foods Typically Purchased by Supplemental Nutrition Assistance Program (SNAP) Households,” including a summary, final report, and appendices.

These data are available on the [FNS website](https://www.fns.usda.gov/snap/foods-typically-purchased-supplemental-nutrition-assistance-program-snap-households) as PDF's and they do not provide the data in easily readable formats.

Using `tabulizer` and the tidyverse, I was able to extract these tables into CSVs.

I wrote a little bit more detail in my blog [article](https://ivelasq.rbind.io/blog/snap-expenditures/) - please take a look!

## Appendix A: Top Purchases by Expenditure for SNAP and Non‐SNAP Households
### Exhibit A‐1: All Commodities

| commodity                              | snap_rank | snap_dollars_in_millions | snap_pct_total_expenditures | nonsnap_rank | nonsnap_dollars_in_millions | nonsnap_pct_total_expenditures |
|----------------------------------------|-----------|--------------------------|-----------------------------|--------------|-----------------------------|--------------------------------|
| Soft drinks                            | 1         | 357.7                    | 0.054400000000000004        | 2            | 1263.3                      | 0.0401                         |
| Fluid milk products                    | 2         | 253.7                    | 0.0385                      | 1            | 1270.3                      | 0.0403                         |
| Beef:grinds                            | 3         | 201                      | 0.0305                      | 6            | 621.1                       | 0.0197                         |
| Bag snacks                             | 4         | 199.3                    | 0.030299999999999997        | 5            | 793.9                       | 0.0252                         |
| Cheese                                 | 5         | 186.4                    | 0.028300000000000002        | 3            | 948.9                       | 0.0301                         |


### Exhibit A‐2: Top 1000 Subcommodities by Expenditures of SNAP Households

| commodity                                                              | subcommodity                           | snap_rank | snap_dollars_in_millions | snap_pct_total_expenditures | nonsnap_rank | nonsnap_dollars_in_millions | nonsnap_pct_total_expenditures |
|------------------------------------------------------------------------|----------------------------------------|-----------|--------------------------|-----------------------------|--------------|-----------------------------|--------------------------------|
| Fluid Milk Products                                                    | ÄŠ å´ƒç€€æ“– Milk/White Only           | 1         | 191.1                    | 0.028999999999999998        | 1            | 853.8                       | 0.0271                         |
| Soft Drinks                                                            | Soft Drinks 12/18&15pk Can Car         | 2         | 164.6                    | 0.025                       | 2            | 601.2                       | 0.0191                         |
| Beef:Grinds                                                            | Lean [Beef]                            | 3         | 112.4                    | 0.0171                      | 7            | 257.9                       | 0.008199999999999999           |
| Cold Cereal                                                            | Kids Cereal                            | 4         | 78.1                     | 0.011899999999999999        | 20           | 186.4                       | 0.0059                         |
| Cheese                                                                 | Shredded Cheese                        | 5         | 74.7                     | 0.011399999999999999        | 3            | 342                         | 0.0109                         |
