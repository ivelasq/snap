# Extracting SNAP Expenditure Data

# Introduction

In 2016, the USDA released a study entitled “Foods Typically Purchased by Supplemental Nutrition Assistance Program (SNAP) Households,” including a summary, final report, and appendices.

These data are available on the [FNS website](https://www.fns.usda.gov/snap/foods-typically-purchased-supplemental-nutrition-assistance-program-snap-households) as PDF's and they do not provide the data in easily readable formats.

Using `tabulizer` and the tidyverse, I was able to extract these tables into CSVs and clean them up so they're actually useable.

I wrote a little bit more detail in my blog [article](http://bit.ly/snappdfs) - please take a look!

## Summary

The [summary document](https://fns-prod.azureedge.net/sites/default/files/ops/SNAPFoodsTypicallyPurchased-Summary.pdf) provides high level overview of methods and key findings. The summary table is below:

| summary_category                          | snap_rank | snap_dollars_in_millions | snap_pct_total_expenditures | nonsnap_rank | nonsnap_dollars_in_millions | nonsnap_pct_total_expenditures |
|-------------------------------------------|-----------|--------------------------|-----------------------------|--------------|-----------------------------|--------------------------------|
| Meat, Poultry and Seafood                 | 1         | 1262.9                   | 0.192                       | 1            | 5016.3                      | 0.159                          |
| Sweetened Beverages                       | 2         | 608.7                    | 0.09300000000000001         | 5            | 2238.8                      | 0.071                          |
| Vegetables                                | 3         | 473.4                    | 0.07200000000000001         | 2            | 2873.9                      | 0.091                          |
| Frozen Prepared Foods                     | 4         | 455.2                    | 0.069                       | 8            | 1592.3                      | 0.051                          |
| Prepared Desserts                         | 5         | 453.8                    | 0.069                       | 6            | 2021.2                      | 0.064                          |
| High Fat Dairy/Cheese                     | 6         | 427.8                    | 0.065                       | 3            | 2483.2                      | 0.079                          |
| Bread and Crackers                        | 7         | 354.9                    | 0.054000000000000006        | 7            | 1978.2                      | 0.063                          |
| Fruits                                    | 8         | 308.2                    | 0.047                       | 4            | 2271.2                      | 0.07200000000000001            |
| Milk                                      | 9         | 232.7                    | 0.035                       | 9            | 1211                        | 0.038                          |
| Salty Snacks                              | 10        | 225.6                    | 0.034                       | 10           | 969.7                       | 0.031                          |
| Prepared Foods                            | 11        | 202.2                    | 0.031                       | 14           | 707                         | 0.022000000000000002           |
| Cereal                                    | 12        | 186.9                    | 0.027999999999999997        | 11           | 933.9                       | 0.03                           |
| Condiments and Seasoning                  | 13        | 174.6                    | 0.027000000000000003        | 12           | 878.9                       | 0.027999999999999997           |
| Fats and Oils                             | 14        | 155.1                    | 0.024                       | 13           | 766.9                       | 0.024                          |
| Candy                                     | 15        | 138.2                    | 0.021                       | 15           | 701.4                       | 0.022000000000000002           |
| Baby Food                                 | 16        | 126.8                    | 0.019                       | 27           | 198.2                       | 0.006                          |
| Juices                                    | 17        | 110.4                    | 0.017                       | 16           | 605.4                       | 0.019                          |
| Coffee and Tea                            | 18        | 83.4                     | 0.013000000000000001        | 17           | 568.8                       | 0.018000000000000002           |
| Bottled Water                             | 19        | 78.1                     | 0.012                       | 22           | 377.4                       | 0.012                          |
| Eggs                                      | 20        | 73.8                     | 0.011000000000000001        | 21           | 388.2                       | 0.012                          |
| Other Dairy Products                      | 21        | 69.8                     | 0.011000000000000001        | 18           | 549.5                       | 0.017                          |
| Pasta, Cornmeal, Other Cereal Products    | 22        | 66.4                     | 0.01                        | 23           | 281.5                       | 0.009000000000000001           |
| Soups                                     | 23        | 62.7                     | 0.01                        | 20           | 414.1                       | 0.013000000000000001           |
| Sugars                                    | 24        | 60.9                     | 0.009000000000000001        | 24           | 260.3                       | 0.008                          |
| Nuts and Seeds                            | 25        | 53.2                     | 0.008                       | 19           | 445.9                       | 0.013999999999999999           |
| Beans                                     | 26        | 38.3                     | 0.006                       | 25           | 234.5                       | 0.006999999999999999           |
| Rice                                      | 27        | 30.1                     | 0.005                       | 28           | 131                         | 0.004                          |
| Jams, Jellies, Preserves and Other Sweets | 28        | 29.1                     | 0.004                       | 29           | 117.5                       | 0.004                          |
| Flour and Prepared Flour Mixes            | 29        | 18.7                     | 0.003                       | 30           | 94.9                        | 0.003                          |
| Miscellaneous                             | 30        | 18.6                     | 0.003                       | 26           | 202.6                       | 0.006                          |

## Appendix A: Top Purchases by Expenditure for SNAP and Non‐SNAP Households
### Exhibit A‐1: All Commodities

Preview:

| commodity                              | snap_rank | snap_dollars_in_millions | snap_pct_total_expenditures | nonsnap_rank | nonsnap_dollars_in_millions | nonsnap_pct_total_expenditures |
|----------------------------------------|-----------|--------------------------|-----------------------------|--------------|-----------------------------|--------------------------------|
| Soft drinks                            | 1         | 357.7                    | 0.054400000000000004        | 2            | 1263.3                      | 0.0401                         |
| Fluid milk products                    | 2         | 253.7                    | 0.0385                      | 1            | 1270.3                      | 0.0403                         |
| Beef:grinds                            | 3         | 201                      | 0.0305                      | 6            | 621.1                       | 0.0197                         |
| Bag snacks                             | 4         | 199.3                    | 0.030299999999999997        | 5            | 793.9                       | 0.0252                         |
| Cheese                                 | 5         | 186.4                    | 0.028300000000000002        | 3            | 948.9                       | 0.0301                         |


### Exhibit A‐2: Top 1000 Subcommodities by Expenditures of SNAP Households

Preview: 

| commodity                                                              | subcommodity                           | snap_rank | snap_dollars_in_millions | snap_pct_total_expenditures | nonsnap_rank | nonsnap_dollars_in_millions | nonsnap_pct_total_expenditures |
|------------------------------------------------------------------------|----------------------------------------|-----------|--------------------------|-----------------------------|--------------|-----------------------------|--------------------------------|
| Fluid Milk Products                                                    | ÄŠ å´ƒç€€æ“– Milk/White Only           | 1         | 191.1                    | 0.028999999999999998        | 1            | 853.8                       | 0.0271                         |
| Soft Drinks                                                            | Soft Drinks 12/18&15pk Can Car         | 2         | 164.6                    | 0.025                       | 2            | 601.2                       | 0.0191                         |
| Beef:Grinds                                                            | Lean [Beef]                            | 3         | 112.4                    | 0.0171                      | 7            | 257.9                       | 0.008199999999999999           |
| Cold Cereal                                                            | Kids Cereal                            | 4         | 78.1                     | 0.011899999999999999        | 20           | 186.4                       | 0.0059                         |
| Cheese                                                                 | Shredded Cheese                        | 5         | 74.7                     | 0.011399999999999999        | 3            | 342                         | 0.0109                         |
