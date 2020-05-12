---
title: "Introducing dplyr"
author: "Joanna Lawler"
output: 
  html_document:
    keep_md: TRUE
    theme: cerulean
    toc: TRUE
---

# 5.4 Participation

<!---The following chunk allows errors when knitting--->



**When you make an Rmd file for participation or homework, be sure to do this**:

1. Change the file output to both html and md _documents_ (not notebook).
  - See the `keep_md: TRUE` argument above.

2. `knit` the document. 

3. Stage and commit the Rmd and knitted documents.

# 5.5 Intro to `dplyr` Syntax

Load the `gapminder` and `tidyverse` packages.
    - This loads `dplyr`, too.

Hint: You can add the `suppressPackageStartupMessages()` function around the 
      `library()` command to keep your output looking nice!
    

```r
# load your packages here:
library(gapminder)
library(tidyverse)
```
    
## `select()`

1. Make a data frame containing the columns `year`, `lifeExp`, `country` from 
the `gapminder` data, in that order.


```r
select(gapminder, year, lifeExp, country)
```

```
## # A tibble: 1,704 x 3
##     year lifeExp country    
##    <int>   <dbl> <fct>      
##  1  1952    28.8 Afghanistan
##  2  1957    30.3 Afghanistan
##  3  1962    32.0 Afghanistan
##  4  1967    34.0 Afghanistan
##  5  1972    36.1 Afghanistan
##  6  1977    38.4 Afghanistan
##  7  1982    39.9 Afghanistan
##  8  1987    40.8 Afghanistan
##  9  1992    41.7 Afghanistan
## 10  1997    41.8 Afghanistan
## # ... with 1,694 more rows
```

2. Select all variables, from `country` to `lifeExp`.


```r
# this will work:
select(gapminder, country, continent, year, lifeExp)
```

```
## # A tibble: 1,704 x 4
##    country     continent  year lifeExp
##    <fct>       <fct>     <int>   <dbl>
##  1 Afghanistan Asia       1952    28.8
##  2 Afghanistan Asia       1957    30.3
##  3 Afghanistan Asia       1962    32.0
##  4 Afghanistan Asia       1967    34.0
##  5 Afghanistan Asia       1972    36.1
##  6 Afghanistan Asia       1977    38.4
##  7 Afghanistan Asia       1982    39.9
##  8 Afghanistan Asia       1987    40.8
##  9 Afghanistan Asia       1992    41.7
## 10 Afghanistan Asia       1997    41.8
## # ... with 1,694 more rows
```

```r
# better way:
select(gapminder, country:lifeExp)
```

```
## # A tibble: 1,704 x 4
##    country     continent  year lifeExp
##    <fct>       <fct>     <int>   <dbl>
##  1 Afghanistan Asia       1952    28.8
##  2 Afghanistan Asia       1957    30.3
##  3 Afghanistan Asia       1962    32.0
##  4 Afghanistan Asia       1967    34.0
##  5 Afghanistan Asia       1972    36.1
##  6 Afghanistan Asia       1977    38.4
##  7 Afghanistan Asia       1982    39.9
##  8 Afghanistan Asia       1987    40.8
##  9 Afghanistan Asia       1992    41.7
## 10 Afghanistan Asia       1997    41.8
## # ... with 1,694 more rows
```

3. Select all variables, except `lifeExp`.


```r
select(gapminder, -lifeExp)
```

```
## # A tibble: 1,704 x 5
##    country     continent  year      pop gdpPercap
##    <fct>       <fct>     <int>    <int>     <dbl>
##  1 Afghanistan Asia       1952  8425333      779.
##  2 Afghanistan Asia       1957  9240934      821.
##  3 Afghanistan Asia       1962 10267083      853.
##  4 Afghanistan Asia       1967 11537966      836.
##  5 Afghanistan Asia       1972 13079460      740.
##  6 Afghanistan Asia       1977 14880372      786.
##  7 Afghanistan Asia       1982 12881816      978.
##  8 Afghanistan Asia       1987 13867957      852.
##  9 Afghanistan Asia       1992 16317921      649.
## 10 Afghanistan Asia       1997 22227415      635.
## # ... with 1,694 more rows
```

4. Put `continent` first. Hint: use the `everything()` function.


```r
select(gapminder, continent, everything())
```

```
## # A tibble: 1,704 x 6
##    continent country      year lifeExp      pop gdpPercap
##    <fct>     <fct>       <int>   <dbl>    <int>     <dbl>
##  1 Asia      Afghanistan  1952    28.8  8425333      779.
##  2 Asia      Afghanistan  1957    30.3  9240934      821.
##  3 Asia      Afghanistan  1962    32.0 10267083      853.
##  4 Asia      Afghanistan  1967    34.0 11537966      836.
##  5 Asia      Afghanistan  1972    36.1 13079460      740.
##  6 Asia      Afghanistan  1977    38.4 14880372      786.
##  7 Asia      Afghanistan  1982    39.9 12881816      978.
##  8 Asia      Afghanistan  1987    40.8 13867957      852.
##  9 Asia      Afghanistan  1992    41.7 16317921      649.
## 10 Asia      Afghanistan  1997    41.8 22227415      635.
## # ... with 1,694 more rows
```

5. Rename `continent` to `cont`.


```r
# Compare
select(gapminder, cont = continent, everything())
```

```
## # A tibble: 1,704 x 6
##    cont  country      year lifeExp      pop gdpPercap
##    <fct> <fct>       <int>   <dbl>    <int>     <dbl>
##  1 Asia  Afghanistan  1952    28.8  8425333      779.
##  2 Asia  Afghanistan  1957    30.3  9240934      821.
##  3 Asia  Afghanistan  1962    32.0 10267083      853.
##  4 Asia  Afghanistan  1967    34.0 11537966      836.
##  5 Asia  Afghanistan  1972    36.1 13079460      740.
##  6 Asia  Afghanistan  1977    38.4 14880372      786.
##  7 Asia  Afghanistan  1982    39.9 12881816      978.
##  8 Asia  Afghanistan  1987    40.8 13867957      852.
##  9 Asia  Afghanistan  1992    41.7 16317921      649.
## 10 Asia  Afghanistan  1997    41.8 22227415      635.
## # ... with 1,694 more rows
```

```r
rename(gapminder, cont = continent)
```

```
## # A tibble: 1,704 x 6
##    country     cont   year lifeExp      pop gdpPercap
##    <fct>       <fct> <int>   <dbl>    <int>     <dbl>
##  1 Afghanistan Asia   1952    28.8  8425333      779.
##  2 Afghanistan Asia   1957    30.3  9240934      821.
##  3 Afghanistan Asia   1962    32.0 10267083      853.
##  4 Afghanistan Asia   1967    34.0 11537966      836.
##  5 Afghanistan Asia   1972    36.1 13079460      740.
##  6 Afghanistan Asia   1977    38.4 14880372      786.
##  7 Afghanistan Asia   1982    39.9 12881816      978.
##  8 Afghanistan Asia   1987    40.8 13867957      852.
##  9 Afghanistan Asia   1992    41.7 16317921      649.
## 10 Afghanistan Asia   1997    41.8 22227415      635.
## # ... with 1,694 more rows
```

```r
rename_all(gapminder, ~ toupper(.x.))
```

```
## Error in toupper(.x.): object '.x.' not found
```


```r
# trying out select with mtcars
select(mtcars, mpg, cyl, disp)
```

```
##                      mpg cyl  disp
## Mazda RX4           21.0   6 160.0
## Mazda RX4 Wag       21.0   6 160.0
## Datsun 710          22.8   4 108.0
## Hornet 4 Drive      21.4   6 258.0
## Hornet Sportabout   18.7   8 360.0
## Valiant             18.1   6 225.0
## Duster 360          14.3   8 360.0
## Merc 240D           24.4   4 146.7
## Merc 230            22.8   4 140.8
## Merc 280            19.2   6 167.6
## Merc 280C           17.8   6 167.6
## Merc 450SE          16.4   8 275.8
## Merc 450SL          17.3   8 275.8
## Merc 450SLC         15.2   8 275.8
## Cadillac Fleetwood  10.4   8 472.0
## Lincoln Continental 10.4   8 460.0
## Chrysler Imperial   14.7   8 440.0
## Fiat 128            32.4   4  78.7
## Honda Civic         30.4   4  75.7
## Toyota Corolla      33.9   4  71.1
## Toyota Corona       21.5   4 120.1
## Dodge Challenger    15.5   8 318.0
## AMC Javelin         15.2   8 304.0
## Camaro Z28          13.3   8 350.0
## Pontiac Firebird    19.2   8 400.0
## Fiat X1-9           27.3   4  79.0
## Porsche 914-2       26.0   4 120.3
## Lotus Europa        30.4   4  95.1
## Ford Pantera L      15.8   8 351.0
## Ferrari Dino        19.7   6 145.0
## Maserati Bora       15.0   8 301.0
## Volvo 142E          21.4   4 121.0
```

```r
select(mtcars, mpg:carb)
```

```
##                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
## Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
## Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
## Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
## Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
## Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
## Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
## Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
## Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
## Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
## Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
## AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
## Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
## Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
## Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
## Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
## Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
## Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
## Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
## Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
## Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```

```r
select(mtcars, -am)
```

```
##                      mpg cyl  disp  hp drat    wt  qsec vs gear carb
## Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0    4    4
## Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0    4    4
## Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1    4    1
## Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1    3    1
## Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0    3    2
## Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1    3    1
## Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0    3    4
## Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1    4    2
## Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1    4    2
## Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1    4    4
## Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1    4    4
## Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0    3    3
## Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0    3    3
## Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0    3    3
## Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0    3    4
## Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0    3    4
## Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0    3    4
## Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1    4    1
## Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1    4    2
## Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1    4    1
## Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1    3    1
## Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0    3    2
## AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0    3    2
## Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0    3    4
## Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0    3    2
## Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1    4    1
## Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0    5    2
## Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1    5    2
## Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0    5    4
## Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0    5    6
## Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0    5    8
## Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1    4    2
```

```r
select(mtcars, qsec, everything())
```

```
##                      qsec  mpg cyl  disp  hp drat    wt vs am gear carb
## Mazda RX4           16.46 21.0   6 160.0 110 3.90 2.620  0  1    4    4
## Mazda RX4 Wag       17.02 21.0   6 160.0 110 3.90 2.875  0  1    4    4
## Datsun 710          18.61 22.8   4 108.0  93 3.85 2.320  1  1    4    1
## Hornet 4 Drive      19.44 21.4   6 258.0 110 3.08 3.215  1  0    3    1
## Hornet Sportabout   17.02 18.7   8 360.0 175 3.15 3.440  0  0    3    2
## Valiant             20.22 18.1   6 225.0 105 2.76 3.460  1  0    3    1
## Duster 360          15.84 14.3   8 360.0 245 3.21 3.570  0  0    3    4
## Merc 240D           20.00 24.4   4 146.7  62 3.69 3.190  1  0    4    2
## Merc 230            22.90 22.8   4 140.8  95 3.92 3.150  1  0    4    2
## Merc 280            18.30 19.2   6 167.6 123 3.92 3.440  1  0    4    4
## Merc 280C           18.90 17.8   6 167.6 123 3.92 3.440  1  0    4    4
## Merc 450SE          17.40 16.4   8 275.8 180 3.07 4.070  0  0    3    3
## Merc 450SL          17.60 17.3   8 275.8 180 3.07 3.730  0  0    3    3
## Merc 450SLC         18.00 15.2   8 275.8 180 3.07 3.780  0  0    3    3
## Cadillac Fleetwood  17.98 10.4   8 472.0 205 2.93 5.250  0  0    3    4
## Lincoln Continental 17.82 10.4   8 460.0 215 3.00 5.424  0  0    3    4
## Chrysler Imperial   17.42 14.7   8 440.0 230 3.23 5.345  0  0    3    4
## Fiat 128            19.47 32.4   4  78.7  66 4.08 2.200  1  1    4    1
## Honda Civic         18.52 30.4   4  75.7  52 4.93 1.615  1  1    4    2
## Toyota Corolla      19.90 33.9   4  71.1  65 4.22 1.835  1  1    4    1
## Toyota Corona       20.01 21.5   4 120.1  97 3.70 2.465  1  0    3    1
## Dodge Challenger    16.87 15.5   8 318.0 150 2.76 3.520  0  0    3    2
## AMC Javelin         17.30 15.2   8 304.0 150 3.15 3.435  0  0    3    2
## Camaro Z28          15.41 13.3   8 350.0 245 3.73 3.840  0  0    3    4
## Pontiac Firebird    17.05 19.2   8 400.0 175 3.08 3.845  0  0    3    2
## Fiat X1-9           18.90 27.3   4  79.0  66 4.08 1.935  1  1    4    1
## Porsche 914-2       16.70 26.0   4 120.3  91 4.43 2.140  0  1    5    2
## Lotus Europa        16.90 30.4   4  95.1 113 3.77 1.513  1  1    5    2
## Ford Pantera L      14.50 15.8   8 351.0 264 4.22 3.170  0  1    5    4
## Ferrari Dino        15.50 19.7   6 145.0 175 3.62 2.770  0  1    5    6
## Maserati Bora       14.60 15.0   8 301.0 335 3.54 3.570  0  1    5    8
## Volvo 142E          18.60 21.4   4 121.0 109 4.11 2.780  1  1    4    2
```

```r
select(mtcars, cylinders = cyl, everything())
```

```
##                     cylinders  mpg  disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4                   6 21.0 160.0 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag               6 21.0 160.0 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710                  4 22.8 108.0  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive              6 21.4 258.0 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout           8 18.7 360.0 175 3.15 3.440 17.02  0  0    3    2
## Valiant                     6 18.1 225.0 105 2.76 3.460 20.22  1  0    3    1
## Duster 360                  8 14.3 360.0 245 3.21 3.570 15.84  0  0    3    4
## Merc 240D                   4 24.4 146.7  62 3.69 3.190 20.00  1  0    4    2
## Merc 230                    4 22.8 140.8  95 3.92 3.150 22.90  1  0    4    2
## Merc 280                    6 19.2 167.6 123 3.92 3.440 18.30  1  0    4    4
## Merc 280C                   6 17.8 167.6 123 3.92 3.440 18.90  1  0    4    4
## Merc 450SE                  8 16.4 275.8 180 3.07 4.070 17.40  0  0    3    3
## Merc 450SL                  8 17.3 275.8 180 3.07 3.730 17.60  0  0    3    3
## Merc 450SLC                 8 15.2 275.8 180 3.07 3.780 18.00  0  0    3    3
## Cadillac Fleetwood          8 10.4 472.0 205 2.93 5.250 17.98  0  0    3    4
## Lincoln Continental         8 10.4 460.0 215 3.00 5.424 17.82  0  0    3    4
## Chrysler Imperial           8 14.7 440.0 230 3.23 5.345 17.42  0  0    3    4
## Fiat 128                    4 32.4  78.7  66 4.08 2.200 19.47  1  1    4    1
## Honda Civic                 4 30.4  75.7  52 4.93 1.615 18.52  1  1    4    2
## Toyota Corolla              4 33.9  71.1  65 4.22 1.835 19.90  1  1    4    1
## Toyota Corona               4 21.5 120.1  97 3.70 2.465 20.01  1  0    3    1
## Dodge Challenger            8 15.5 318.0 150 2.76 3.520 16.87  0  0    3    2
## AMC Javelin                 8 15.2 304.0 150 3.15 3.435 17.30  0  0    3    2
## Camaro Z28                  8 13.3 350.0 245 3.73 3.840 15.41  0  0    3    4
## Pontiac Firebird            8 19.2 400.0 175 3.08 3.845 17.05  0  0    3    2
## Fiat X1-9                   4 27.3  79.0  66 4.08 1.935 18.90  1  1    4    1
## Porsche 914-2               4 26.0 120.3  91 4.43 2.140 16.70  0  1    5    2
## Lotus Europa                4 30.4  95.1 113 3.77 1.513 16.90  1  1    5    2
## Ford Pantera L              8 15.8 351.0 264 4.22 3.170 14.50  0  1    5    4
## Ferrari Dino                6 19.7 145.0 175 3.62 2.770 15.50  0  1    5    6
## Maserati Bora               8 15.0 301.0 335 3.54 3.570 14.60  0  1    5    8
## Volvo 142E                  4 21.4 121.0 109 4.11 2.780 18.60  1  1    4    2
```

## `arrange()`

1. Order by year.


```r
arrange(gapminder, year)
```

```
## # A tibble: 1,704 x 6
##    country     continent  year lifeExp      pop gdpPercap
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
##  1 Afghanistan Asia       1952    28.8  8425333      779.
##  2 Albania     Europe     1952    55.2  1282697     1601.
##  3 Algeria     Africa     1952    43.1  9279525     2449.
##  4 Angola      Africa     1952    30.0  4232095     3521.
##  5 Argentina   Americas   1952    62.5 17876956     5911.
##  6 Australia   Oceania    1952    69.1  8691212    10040.
##  7 Austria     Europe     1952    66.8  6927772     6137.
##  8 Bahrain     Asia       1952    50.9   120447     9867.
##  9 Bangladesh  Asia       1952    37.5 46886859      684.
## 10 Belgium     Europe     1952    68    8730405     8343.
## # ... with 1,694 more rows
```

2. Order by year, in descending order.


```r
arrange(gapminder, desc(year))
```

```
## # A tibble: 1,704 x 6
##    country     continent  year lifeExp       pop gdpPercap
##    <fct>       <fct>     <int>   <dbl>     <int>     <dbl>
##  1 Afghanistan Asia       2007    43.8  31889923      975.
##  2 Albania     Europe     2007    76.4   3600523     5937.
##  3 Algeria     Africa     2007    72.3  33333216     6223.
##  4 Angola      Africa     2007    42.7  12420476     4797.
##  5 Argentina   Americas   2007    75.3  40301927    12779.
##  6 Australia   Oceania    2007    81.2  20434176    34435.
##  7 Austria     Europe     2007    79.8   8199783    36126.
##  8 Bahrain     Asia       2007    75.6    708573    29796.
##  9 Bangladesh  Asia       2007    64.1 150448339     1391.
## 10 Belgium     Europe     2007    79.4  10392226    33693.
## # ... with 1,694 more rows
```

3. Order by year, then by life expectancy.


```r
arrange(gapminder, year, lifeExp)
```

```
## # A tibble: 1,704 x 6
##    country       continent  year lifeExp     pop gdpPercap
##    <fct>         <fct>     <int>   <dbl>   <int>     <dbl>
##  1 Afghanistan   Asia       1952    28.8 8425333      779.
##  2 Gambia        Africa     1952    30    284320      485.
##  3 Angola        Africa     1952    30.0 4232095     3521.
##  4 Sierra Leone  Africa     1952    30.3 2143249      880.
##  5 Mozambique    Africa     1952    31.3 6446316      469.
##  6 Burkina Faso  Africa     1952    32.0 4469979      543.
##  7 Guinea-Bissau Africa     1952    32.5  580653      300.
##  8 Yemen, Rep.   Asia       1952    32.5 4963829      782.
##  9 Somalia       Africa     1952    33.0 2526994     1136.
## 10 Guinea        Africa     1952    33.6 2664249      510.
## # ... with 1,694 more rows
```

## Piping, `%>%`

Note: think of `%>%` as the word "then"!

Demonstration:

Here I want to combine `select()` Task 1 with `arrange()` Task 3.

### Base R Method

This is how I could do it by *nesting* the two function calls:


```r
# nesting function calls can be hard to read
arrange(select(gapminder, year, lifeExp, country), year, lifeExp)
```


```r
gap_sel <- select(gapminder, year, lifeExp, country)
arrange(gap_sel, year, lifeExp)
```

### tidyverse Method

Now using with pipes:


```r
# alter the below to include 2 "pipes"
arrange(select(gapminder, year, lifeExp, country), year, lifeExp)
```

```
## # A tibble: 1,704 x 3
##     year lifeExp country      
##    <int>   <dbl> <fct>        
##  1  1952    28.8 Afghanistan  
##  2  1952    30   Gambia       
##  3  1952    30.0 Angola       
##  4  1952    30.3 Sierra Leone 
##  5  1952    31.3 Mozambique   
##  6  1952    32.0 Burkina Faso 
##  7  1952    32.5 Guinea-Bissau
##  8  1952    32.5 Yemen, Rep.  
##  9  1952    33.0 Somalia      
## 10  1952    33.6 Guinea       
## # ... with 1,694 more rows
```

```r
gapminder %>%
  select(year, lifeExp, country) %>%
  arrange(year, lifeExp)
```

```
## # A tibble: 1,704 x 3
##     year lifeExp country      
##    <int>   <dbl> <fct>        
##  1  1952    28.8 Afghanistan  
##  2  1952    30   Gambia       
##  3  1952    30.0 Angola       
##  4  1952    30.3 Sierra Leone 
##  5  1952    31.3 Mozambique   
##  6  1952    32.0 Burkina Faso 
##  7  1952    32.5 Guinea-Bissau
##  8  1952    32.5 Yemen, Rep.  
##  9  1952    33.0 Somalia      
## 10  1952    33.6 Guinea       
## # ... with 1,694 more rows
```

# Back to Guide 

Return to guide at the section on *Relational/Comparison and Logical Operators in R*.

# Transforming Datasets
## `filter()`

1. Only take data with population greater than 100 million.


```r
gapminder %>%
  filter(pop > 100000000)
```

```
## # A tibble: 77 x 6
##    country    continent  year lifeExp       pop gdpPercap
##    <fct>      <fct>     <int>   <dbl>     <int>     <dbl>
##  1 Bangladesh Asia       1987    52.8 103764241      752.
##  2 Bangladesh Asia       1992    56.0 113704579      838.
##  3 Bangladesh Asia       1997    59.4 123315288      973.
##  4 Bangladesh Asia       2002    62.0 135656790     1136.
##  5 Bangladesh Asia       2007    64.1 150448339     1391.
##  6 Brazil     Americas   1972    59.5 100840058     4986.
##  7 Brazil     Americas   1977    61.5 114313951     6660.
##  8 Brazil     Americas   1982    63.3 128962939     7031.
##  9 Brazil     Americas   1987    65.2 142938076     7807.
## 10 Brazil     Americas   1992    67.1 155975974     6950.
## # ... with 67 more rows
```

2. Your turn: of those rows filtered from step 1., only take data from Asia.


```r
gapminder %>%
  filter(pop > 100000000, continent == "Asia")
```

```
## # A tibble: 52 x 6
##    country    continent  year lifeExp       pop gdpPercap
##    <fct>      <fct>     <int>   <dbl>     <int>     <dbl>
##  1 Bangladesh Asia       1987    52.8 103764241      752.
##  2 Bangladesh Asia       1992    56.0 113704579      838.
##  3 Bangladesh Asia       1997    59.4 123315288      973.
##  4 Bangladesh Asia       2002    62.0 135656790     1136.
##  5 Bangladesh Asia       2007    64.1 150448339     1391.
##  6 China      Asia       1952    44   556263527      400.
##  7 China      Asia       1957    50.5 637408000      576.
##  8 China      Asia       1962    44.5 665770000      488.
##  9 China      Asia       1967    58.4 754550000      613.
## 10 China      Asia       1972    63.1 862030000      677.
## # ... with 42 more rows
```

3. Repeat 2, but take data from countries Brazil, and China. 


```r
gapminder %>%
  filter(pop > 100000000, country == "Brazil" | country == "China")
```

```
## # A tibble: 20 x 6
##    country continent  year lifeExp        pop gdpPercap
##    <fct>   <fct>     <int>   <dbl>      <int>     <dbl>
##  1 Brazil  Americas   1972    59.5  100840058     4986.
##  2 Brazil  Americas   1977    61.5  114313951     6660.
##  3 Brazil  Americas   1982    63.3  128962939     7031.
##  4 Brazil  Americas   1987    65.2  142938076     7807.
##  5 Brazil  Americas   1992    67.1  155975974     6950.
##  6 Brazil  Americas   1997    69.4  168546719     7958.
##  7 Brazil  Americas   2002    71.0  179914212     8131.
##  8 Brazil  Americas   2007    72.4  190010647     9066.
##  9 China   Asia       1952    44    556263527      400.
## 10 China   Asia       1957    50.5  637408000      576.
## 11 China   Asia       1962    44.5  665770000      488.
## 12 China   Asia       1967    58.4  754550000      613.
## 13 China   Asia       1972    63.1  862030000      677.
## 14 China   Asia       1977    64.0  943455000      741.
## 15 China   Asia       1982    65.5 1000281000      962.
## 16 China   Asia       1987    67.3 1084035000     1379.
## 17 China   Asia       1992    68.7 1164970000     1656.
## 18 China   Asia       1997    70.4 1230075000     2289.
## 19 China   Asia       2002    72.0 1280400000     3119.
## 20 China   Asia       2007    73.0 1318683096     4959.
```

```r
gapminder %>% 
  filter(pop > 100000000, country %in% c("Brazil", "China"))
```

```
## # A tibble: 20 x 6
##    country continent  year lifeExp        pop gdpPercap
##    <fct>   <fct>     <int>   <dbl>      <int>     <dbl>
##  1 Brazil  Americas   1972    59.5  100840058     4986.
##  2 Brazil  Americas   1977    61.5  114313951     6660.
##  3 Brazil  Americas   1982    63.3  128962939     7031.
##  4 Brazil  Americas   1987    65.2  142938076     7807.
##  5 Brazil  Americas   1992    67.1  155975974     6950.
##  6 Brazil  Americas   1997    69.4  168546719     7958.
##  7 Brazil  Americas   2002    71.0  179914212     8131.
##  8 Brazil  Americas   2007    72.4  190010647     9066.
##  9 China   Asia       1952    44    556263527      400.
## 10 China   Asia       1957    50.5  637408000      576.
## 11 China   Asia       1962    44.5  665770000      488.
## 12 China   Asia       1967    58.4  754550000      613.
## 13 China   Asia       1972    63.1  862030000      677.
## 14 China   Asia       1977    64.0  943455000      741.
## 15 China   Asia       1982    65.5 1000281000      962.
## 16 China   Asia       1987    67.3 1084035000     1379.
## 17 China   Asia       1992    68.7 1164970000     1656.
## 18 China   Asia       1997    70.4 1230075000     2289.
## 19 China   Asia       2002    72.0 1280400000     3119.
## 20 China   Asia       2007    73.0 1318683096     4959.
```

## `mutate()` (10 min)

The `mutate()` function _creates_ new columns in the tibble by transforming other variables. Like `select()`, `filter()`, and `arrange()`, the `mutate()` function also takes a tibble as its first argument, and returns a tibble. 

The general syntax is:

```
mutate(tibble, NEW_COLUMN_NAME = CALCULATION)
```

Let's get: 

- GDP by multiplying GPD per capita with population, and
- GDP in billions, named (`gdpBill`), rounded to two decimals.


```r
gapminder %>%
  mutate(grossGDP = gdpPercap * pop,
         gdpBill = (grossGDP / 1000000000) %>% round(2))
```

```
## # A tibble: 1,704 x 8
##    country     continent  year lifeExp      pop gdpPercap     grossGDP gdpBill
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>        <dbl>   <dbl>
##  1 Afghanistan Asia       1952    28.8  8425333      779.  6567086330.    6.57
##  2 Afghanistan Asia       1957    30.3  9240934      821.  7585448670.    7.59
##  3 Afghanistan Asia       1962    32.0 10267083      853.  8758855797.    8.76
##  4 Afghanistan Asia       1967    34.0 11537966      836.  9648014150.    9.65
##  5 Afghanistan Asia       1972    36.1 13079460      740.  9678553274.    9.68
##  6 Afghanistan Asia       1977    38.4 14880372      786. 11697659231.   11.7 
##  7 Afghanistan Asia       1982    39.9 12881816      978. 12598563401.   12.6 
##  8 Afghanistan Asia       1987    40.8 13867957      852. 11820990309.   11.8 
##  9 Afghanistan Asia       1992    41.7 16317921      649. 10595901589.   10.6 
## 10 Afghanistan Asia       1997    41.8 22227415      635. 14121995875.   14.1 
## # ... with 1,694 more rows
```

Notice the backwards compatibility! No need for loops!

Try the same thing, but with `transmute` (drops all other variables). 


```r
gapminder %>%
  transmute(grossGDP = gdpPercap * pop,
         gdpBill = (grossGDP / 1000000000) %>% round(2))
```

```
## # A tibble: 1,704 x 2
##        grossGDP gdpBill
##           <dbl>   <dbl>
##  1  6567086330.    6.57
##  2  7585448670.    7.59
##  3  8758855797.    8.76
##  4  9648014150.    9.65
##  5  9678553274.    9.68
##  6 11697659231.   11.7 
##  7 12598563401.   12.6 
##  8 11820990309.   11.8 
##  9 10595901589.   10.6 
## 10 14121995875.   14.1 
## # ... with 1,694 more rows
```

The `if_else` function is useful for changing certain elements in a data frame.

Example: Suppose Canada's 1952 life expectancy was mistakenly entered as 68.8 in the data frame, but is actually 70. Fix it using `if_else` and `mutate`. 


```r
gapminder %>%
  mutate(lifeExp = if_else(country == "Canada" & year ==1952,
         70,
         lifeExp)) %>% filter(country == "Canada")
```

```
## # A tibble: 12 x 6
##    country continent  year lifeExp      pop gdpPercap
##    <fct>   <fct>     <int>   <dbl>    <int>     <dbl>
##  1 Canada  Americas   1952    70   14785584    11367.
##  2 Canada  Americas   1957    70.0 17010154    12490.
##  3 Canada  Americas   1962    71.3 18985849    13462.
##  4 Canada  Americas   1967    72.1 20819767    16077.
##  5 Canada  Americas   1972    72.9 22284500    18971.
##  6 Canada  Americas   1977    74.2 23796400    22091.
##  7 Canada  Americas   1982    75.8 25201900    22899.
##  8 Canada  Americas   1987    76.9 26549700    26627.
##  9 Canada  Americas   1992    78.0 28523502    26343.
## 10 Canada  Americas   1997    78.6 30305843    28955.
## 11 Canada  Americas   2002    79.8 31902268    33329.
## 12 Canada  Americas   2007    80.7 33390141    36319.
```

```r
gapminder %>%
  mutate(lifeExp = if_else(country == "Bangladesh",
         NA_real_,
         lifeExp)) %>% filter(country == "Bangladesh")
```

```
## # A tibble: 12 x 6
##    country    continent  year lifeExp       pop gdpPercap
##    <fct>      <fct>     <int>   <dbl>     <int>     <dbl>
##  1 Bangladesh Asia       1952      NA  46886859      684.
##  2 Bangladesh Asia       1957      NA  51365468      662.
##  3 Bangladesh Asia       1962      NA  56839289      686.
##  4 Bangladesh Asia       1967      NA  62821884      721.
##  5 Bangladesh Asia       1972      NA  70759295      630.
##  6 Bangladesh Asia       1977      NA  80428306      660.
##  7 Bangladesh Asia       1982      NA  93074406      677.
##  8 Bangladesh Asia       1987      NA 103764241      752.
##  9 Bangladesh Asia       1992      NA 113704579      838.
## 10 Bangladesh Asia       1997      NA 123315288      973.
## 11 Bangladesh Asia       2002      NA 135656790     1136.
## 12 Bangladesh Asia       2007      NA 150448339     1391.
```

Your turn: Make a new column called `cc` that pastes the country name followed by the continent, separated by a comma. (Hint: use the `paste` function with the `sep=", "` argument).



These functions we've seen are called __vectorized functions__—they are designed 
to work with vectors and do their computation on each element of the vector(s).

## Git Stuff

Now is a good time to knit, commit, push!

# Back to Guide Again

Let's head back to the guide at the section on `summarize()`.

# Exercises for Grouped Data Frames

Let's do some practice with grouping (and ungrouping) and summarizing data frames!

1. (a) What's the minimum life expectancy for each continent and each year? (b) Add the corresponding country to the tibble, too. (c) Arrange by min life expectancy.


```r
gapminder %>% 
  group_by(FILL_THIS_IN) %>% 
  FILL_THIS_IN(min_life = min(lifeExp))
```

```
## Error: Column `FILL_THIS_IN` is unknown
```

2. Let's compute the mean Agreeableness score across items for each participant 
in the `psych::bfi` dataset. Be sure to handle `NA`!


```r
psych::bfi %>%
  as_tibble() %>% 
  select(A1:A5) %>% 
  rowwise() %>% 
  mutate(A_mean = mean(c(A1, A2, A3, A4, A5), na.rm = TRUE)) %>% 
  ungroup()
```

```
## # A tibble: 2,800 x 6
##       A1    A2    A3    A4    A5 A_mean
##    <int> <int> <int> <int> <int>  <dbl>
##  1     2     4     3     4     4    3.4
##  2     2     4     5     2     5    3.6
##  3     5     4     5     4     4    4.4
##  4     4     4     6     5     5    4.8
##  5     2     3     3     4     5    3.4
##  6     6     6     5     6     5    5.6
##  7     2     5     5     3     5    4  
##  8     4     3     1     5     1    2.8
##  9     4     3     6     3     3    3.8
## 10     2     5     6     6     5    4.8
## # ... with 2,790 more rows
```

Now compute mean scores for the other Big Five traits, as well as 
`sd` and `min` scores for reach person.



** There are a few other ways to do this sort of computation.**

`rowMeans()` computes the mean of each row of a data frame. We can use it by
putting `select()` inside of `mutate()`:


```r
psych::bfi %>% 
  as_tibble() %>% 
  select(A1:A5) %>% 
  mutate(A_mn = rowMeans(select(., A1:A5)),
         A_mn2 = rowMeans(select(., starts_with("A", ignore.case = FALSE))))
```

```
## # A tibble: 2,800 x 7
##       A1    A2    A3    A4    A5  A_mn A_mn2
##    <int> <int> <int> <int> <int> <dbl> <dbl>
##  1     2     4     3     4     4   3.4   3.4
##  2     2     4     5     2     5   3.6   3.6
##  3     5     4     5     4     4   4.4   4.4
##  4     4     4     6     5     5   4.8   4.8
##  5     2     3     3     4     5   3.4   3.4
##  6     6     6     5     6     5   5.6   5.6
##  7     2     5     5     3     5   4     4  
##  8     4     3     1     5     1   2.8   2.8
##  9     4     3     6     3     3   3.8   3.8
## 10     2     5     6     6     5   4.8   4.8
## # ... with 2,790 more rows
```

Some functions are **vectorized**, so you don't need `rowwise()`. 
For example, `pmin()` computes the "parallel min" across the vectors it receives:


```r
psych::bfi %>% 
  as_tibble() %>% 
  select(A1:A5) %>% 
  mutate(A_min = pmin(A1, A2, A3, A4, A5))
```

```
## # A tibble: 2,800 x 6
##       A1    A2    A3    A4    A5 A_min
##    <int> <int> <int> <int> <int> <int>
##  1     2     4     3     4     4     2
##  2     2     4     5     2     5     2
##  3     5     4     5     4     4     4
##  4     4     4     6     5     5     4
##  5     2     3     3     4     5     2
##  6     6     6     5     6     5     5
##  7     2     5     5     3     5     2
##  8     4     3     1     5     1     1
##  9     4     3     6     3     3     3
## 10     2     5     6     6     5     2
## # ... with 2,790 more rows
```


3. Calculate the growth in population since the first year on record 
_for each country_ by rearranging the following lines, and filling in the 
`FILL_THIS_IN`. Here's another convenience function for you: `dplyr::first()`. 

```
mutate(rel_growth = FILL_THIS_IN) %>% 
arrange(FILL_THIS_IN) %>% 
gapminder %>% 
knitr::kable()
group_by(country) %>% 
```



4. Determine the country, on each continent, that experienced the 
**sharpest 5-year drop in life expectancy**, sorted by the drop, by rearranging 
the following lines of code. Ensure there are no `NA`'s. A helpful function to 
compute changes in a variable across rows of data (e.g., for time-series data) 
is `tsibble::difference()`:

```
drop_na() %>% 
ungroup() %>% 
arrange(year) %>% 
filter(inc_life_exp == min(inc_life_exp)) %>% 
gapminder %>% 
mutate(inc_life_exp = FILL_THIS_IN) %>% # Compute the changes in life expectancy
arrange(inc_life_exp) %>% 
group_by(country) %>% 
group_by(continent) %>% 
knitr::kable()
```



# Bonus Exercises

If there's time remaining, we'll practice with these three exercises. 
I'll give you a minute for each, then we'll go over the answer.

1. In `gapminder`, take all countries in Europe that have a GDP per capita 
   greater than 10000, and select all variables except `gdpPercap`. 
   (Hint: use `-`).

2. Take the first three columns of `gapminder` and extract the names.

3. In `gapminder`, convert the population to a number in billions.

4. Take the `iris` data frame and extract all columns that start with 
   the word "Petal". 
    - Hint: take a look at the "Select helpers" documentation by running the 
      following code: `?tidyselect::select_helpers`.

5. Filter the rows of `iris` for Sepal.Length >= 4.6 and Petal.Width >= 0.5.

Exercises 4. and 5. are from 
[r-exercises](https://www.r-exercises.com/2017/10/19/dplyr-basic-functions-exercises/).
