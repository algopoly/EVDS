# EVDS
R package as a wrapper to Electronic Data Distribution System API of Central Bank of Turkey

## Some Starter Code

Remember to replace "YOURAPIKEY" with your API key.

```r
devtools::install_github("algopoly/EVDS")
library(EVDS)
set_evds_key("YOURAPIKEY")
# Get data on some series
get_series()
# See all Categories
show_categories()
# See all Data Groups
dglist <- show_datagroups()
head(dglist)
# See all series from a data group
show_serie_lists(ccode="bie_abanlbil")
# See all series on the website
all_series()
```
