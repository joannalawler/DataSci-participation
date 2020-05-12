---
title: "Inputting/Outputting Files"
author: "Joanna Lawler"
output: 
  html_document:
    keep_md: TRUE
    theme: cerulean
    toc: TRUE
---


```r
library(gapminder)
library(ggthemes)
library(googlesheets4)
library(haven)
library(here)
library(readr)
library(rio)
library(readxl)
library(svglite)
library(tidyverse)

knitr::opts_chunk$set(fig.width=4, fig.height=3, warning = FALSE, fig.align = "center")
```

<!-- The following chunk allows errors when knitting -->



# 8.3 Writing Data to Disk


```r
(gap_asia_2007 <- gapminder %>% filter(year == 2007, continent == "Asia"))
```

```
## # A tibble: 33 x 6
##    country          continent  year lifeExp        pop gdpPercap
##    <fct>            <fct>     <int>   <dbl>      <int>     <dbl>
##  1 Afghanistan      Asia       2007    43.8   31889923      975.
##  2 Bahrain          Asia       2007    75.6     708573    29796.
##  3 Bangladesh       Asia       2007    64.1  150448339     1391.
##  4 Cambodia         Asia       2007    59.7   14131858     1714.
##  5 China            Asia       2007    73.0 1318683096     4959.
##  6 Hong Kong, China Asia       2007    82.2    6980412    39725.
##  7 India            Asia       2007    64.7 1110396331     2452.
##  8 Indonesia        Asia       2007    70.6  223547000     3541.
##  9 Iran             Asia       2007    71.0   69453570    11606.
## 10 Iraq             Asia       2007    59.5   27499638     4471.
## # ... with 23 more rows
```

```r
write_csv(gap_asia_2007, "exported_file.csv")
```

# 8.5 here::here()


```r
# After first creating a subfolder called "s008_data" within a folder called "data", the code below will ensure that gap_asia_2007 will be saved in that subfolder

write_csv(gap_asia_2007, here::here("data", "s008_data", "exported_file.csv"))
```

```
## Error in open.connection(path, "wb"): cannot open the connection
```

# 8.6 Reading Data From Disk


```r
read_csv(here::here("data", "s008_data", "exported_file.csv"))
```

```
## Error: 'C:/Users/joann/Documents/GitHub/DataSci-participation/data/s008_data/exported_file.csv' does not exist.
```

# 8.7.1 Import a CSV File From the Internet


```r
# Two steps better than one
url <- "http://gattonweb.uky.edu/sheather/book/docs/datasets/magazines.csv"
read_csv(url)
```

```
## Parsed with column specification:
## cols(
##   Magazine = col_character(),
##   AdRevenue = col_double(),
##   AdPages = col_double(),
##   SubRevenue = col_double(),
##   NewsRevenue = col_double()
## )
```

```
## # A tibble: 204 x 5
##    Magazine                             AdRevenue AdPages SubRevenue NewsRevenue
##    <chr>                                    <dbl>   <dbl>      <dbl>       <dbl>
##  1 Weekly World News                         2280    300         854       16568
##  2 National Examiner                         3382    380         968       27215
##  3 J-14                                      4218    250        2206       12453
##  4 Soap Opera Weekly                         4622    439        5555       24282
##  5 Easyriders                                5121    524.       4155        9929
##  6 Mary Engelbreit's Home Companion          5259    189        9048        4363
##  7 Official Xbox Magazine                    5838    542.       4311       10320
##  8 Weight Watchers                           6986    287.       9202        4048
##  9 Globe                                     7634    380        2180       63771
## 10 PSM: 100% Independent PlayStation 2~      8034    720.       6846        5271
## # ... with 194 more rows
```

# 8.7.2 Import an Excel File (.xls or .xlsx) From the Internet


```r
dir.create(here::here("data", "s008_data"), recursive = TRUE)

# mode = "wb" is very important on Windows

xls_url <- "http://gattonweb.uky.edu/sheather/book/docs/datasets/GreatestGivers.xls"
download.file(xls_url, here::here("data", "s008_data", "some_file.xls"), mode = "wb")

# Extract and import

file_name <- basename(xls_url)
download.file(xls_url, here::here("data", "s008_data", file_name), mode = "wb")
read_excel(here::here("data", "s008_data", file_name))
```

```
## # A tibble: 50 x 8
##    Rank  Name  Background `2003-07 Given ~ Causes `Estimated lift~ `Net Worth`
##    <chr> <chr> <chr>      <chr>            <chr>             <dbl> <chr>      
##  1 1     Warr~ Berkshire~  40,650          Healt~            40780 52000      
##  2 2     Bill~ Microsoft~  3,519           Globa~            28144 59000      
##  3 3     Geor~ Oil and g~  2,271           Pover~             2522 11000      
##  4 4     Geor~ Investor    2,109           Open ~             6401 8800       
##  5 5     Gord~ Intel co-~  2,067           Envir~             7404 4500       
##  6 6     Walt~ Family of~  1,475           Educa~             2015 82500      
##  7 7     Herb~ Golden We~  1,368           Medic~             1389 2400       
##  8 8     Eli ~ SunAmeric~  1,216           Publi~             2286 7000       
##  9 9     Dona~ Real esta~  915             Educa~             1326 13000      
## 10 10    Jon ~ Huntsman ~  800             Cance~             1233 1900       
## # ... with 40 more rows, and 1 more variable: `Giving%` <chr>
```

# 8.8 Read in a Sample SPSS File


```r
(clevel <- haven::read_spss(here::here("inputoutput", "clevel.sav")))
```

```
## Error: 'C:/Users/joann/Documents/GitHub/DataSci-participation/inputoutput/clevel.sav' does not exist.
```

```r
clevel_cleaned <-
  clevel %>% 
  mutate(language = as_factor(language),
         gender = as_factor(gender),
         isClevel = factor(isClevel, 
                           levels = c(0, 1), 
                           labels = c("No", "Yes"))
  ) %>% 
  print()
```

```
## Error in eval(lhs, parent, parent): object 'clevel' not found
```

# 8.8.1 Saving Data Frames


```r
write_csv(clevel_cleaned, here::here("inputoutput", "clevel_cleaned.csv"))
```

```
## Error in is.data.frame(x): object 'clevel_cleaned' not found
```

# 8.8.2 Saving Plots


```
## Error in eval(lhs, parent, parent): object 'clevel_cleaned' not found
```

```
## Error in print(clevel_plot): object 'clevel_plot' not found
```

```
## Saving 7.5 x 5 in image
```

```
## Error in svglite_(file, bg, width, height, pointsize, standalone, aliases): cannot open stream C:/Users/joann/Documents/GitHub/DataSci-participation/inputoutput/figures/clevel_extraversion.svg
```

```
## Saving 7.5 x 5 in image
```

```
## Error in grDevices::postscript(file = filename, ..., onefile = FALSE, : cannot open file 'C:/Users/joann/Documents/GitHub/DataSci-participation/inputoutput/figures/clevel_extraversion.eps'
```

```
## Saving 7.5 x 5 in image
```

```
## Error in grDevices::pdf(file = filename, ..., version = version): cannot open file 'C:/Users/joann/Documents/GitHub/DataSci-participation/inputoutput/figures/clevel_extraversion.pdf'
```

```
## Saving 7.5 x 5 in image
```

```
## Error in grid.draw(plot): object 'clevel_plot' not found
```

```
## Saving 7.5 x 5 in image
```

```
## Error in grDevices::png(..., res = dpi, units = "in"): unable to start png() device
```

