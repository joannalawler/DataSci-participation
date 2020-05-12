---
title: "Tidying Data"
author: "Joanna Lawler"
output: 
  html_document:
    keep_md: TRUE
    theme: cerulean
    toc: TRUE
---

# 6.7 Activity


```r
library(tidyverse)
lotr  <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/lotr_tidy.csv")
guest <- read_csv("https://raw.githubusercontent.com/USF-Psych-DataSci/Classroom/master/data/wedding/attend.csv")
email <- read_csv("https://raw.githubusercontent.com/USF-Psych-DataSci/Classroom/master/data/wedding/emails.csv")
```

<!---The following chunk allows errors when knitting--->



# Exercise 1: Univariate Pivoting

Consider the Lord of the Rings data:


```r
lotr
```

```
## # A tibble: 18 x 4
##    Film                       Race   Gender Words
##    <chr>                      <chr>  <chr>  <dbl>
##  1 The Fellowship Of The Ring Elf    Female  1229
##  2 The Fellowship Of The Ring Hobbit Female    14
##  3 The Fellowship Of The Ring Man    Female     0
##  4 The Two Towers             Elf    Female   331
##  5 The Two Towers             Hobbit Female     0
##  6 The Two Towers             Man    Female   401
##  7 The Return Of The King     Elf    Female   183
##  8 The Return Of The King     Hobbit Female     2
##  9 The Return Of The King     Man    Female   268
## 10 The Fellowship Of The Ring Elf    Male     971
## 11 The Fellowship Of The Ring Hobbit Male    3644
## 12 The Fellowship Of The Ring Man    Male    1995
## 13 The Two Towers             Elf    Male     513
## 14 The Two Towers             Hobbit Male    2463
## 15 The Two Towers             Man    Male    3589
## 16 The Return Of The King     Elf    Male     510
## 17 The Return Of The King     Hobbit Male    2673
## 18 The Return Of The King     Man    Male    2459
```

1. Would you say this data is in tidy format?

These data are in tidy format - each row is an observation, each column is a variable, and each cell is a value.

2. Widen the data so that we see the words spoken by each race, by putting race as its own column.


```r
lotr_wide <- lotr %>%
  pivot_wider(id_cols = c(-Race, -Words), 
              names_from = Race, 
              values_from = Words)
```

3. Re-lengthen the wide LOTR data from Question 2 above.


```r
lotr_long <- lotr_wide %>% 
  pivot_longer(cols = c(Elf, Hobbit, Man), 
               names_to  = "Race", 
               values_to = "Words")
```

# Exercise 2: Multivariate Pivoting

Congratulations, you're getting married! In addition to the wedding, you've 
decided to hold two other events: a day-of brunch and a day-before round of 
golf. You've made a guestlist of attendance so far, along with food preference 
for the food events (wedding and brunch).


```r
guest %>%
  DT::datatable(rownames = FALSE)
```

<!--html_preserve--><div id="htmlwidget-2c0f62e02cea5f92ecda" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-2c0f62e02cea5f92ecda">{"x":{"filter":"none","data":[[1,1,1,1,2,2,3,4,5,5,5,6,6,7,7,8,9,10,11,12,12,12,12,12,13,13,14,14,15,15],["Sommer Medrano","Phillip Medrano","Blanka Medrano","Emaan Medrano","Blair Park","Nigel Webb","Sinead English","Ayra Marks","Atlanta Connolly","Denzel Connolly","Chanelle Shah","Jolene Welsh","Hayley Booker","Amayah Sanford","Erika Foley","Ciaron Acosta","Diana Stuart","Cosmo Dunkley","Cai Mcdaniel","Daisy-May Caldwell","Martin Caldwell","Violet Caldwell","Nazifa Caldwell","Eric Caldwell","Rosanna Bird","Kurtis Frost","Huma Stokes","Samuel Rutledge","Eddison Collier","Stewart Nicholls"],["PENDING","vegetarian","chicken","PENDING","chicken",null,"PENDING","vegetarian","PENDING","fish","chicken",null,"vegetarian",null,"PENDING","PENDING","vegetarian","PENDING","fish","chicken","PENDING","PENDING","chicken","chicken","vegetarian","PENDING",null,"chicken","PENDING","chicken"],["PENDING","Menu C","Menu A","PENDING","Menu C",null,"PENDING","Menu B","PENDING","Menu B","Menu C",null,"Menu C","PENDING","PENDING","Menu A","Menu C","PENDING","Menu C","Menu B","PENDING","PENDING","PENDING","Menu B","Menu C","PENDING",null,"Menu C","PENDING","Menu B"],["PENDING","CONFIRMED","CONFIRMED","PENDING","CONFIRMED","CANCELLED","PENDING","PENDING","PENDING","CONFIRMED","CONFIRMED","CANCELLED","CONFIRMED","CANCELLED","PENDING","PENDING","CONFIRMED","PENDING","CONFIRMED","CONFIRMED","PENDING","PENDING","PENDING","CONFIRMED","CONFIRMED","PENDING","CANCELLED","CONFIRMED","PENDING","CONFIRMED"],["PENDING","CONFIRMED","CONFIRMED","PENDING","CONFIRMED","CANCELLED","PENDING","PENDING","PENDING","CONFIRMED","CONFIRMED","CANCELLED","CONFIRMED","PENDING","PENDING","PENDING","CONFIRMED","PENDING","CONFIRMED","CONFIRMED","PENDING","PENDING","PENDING","CONFIRMED","CONFIRMED","PENDING","CANCELLED","CONFIRMED","PENDING","CONFIRMED"],["PENDING","CONFIRMED","CONFIRMED","PENDING","CONFIRMED","CANCELLED","PENDING","PENDING","PENDING","CONFIRMED","CONFIRMED","CANCELLED","CONFIRMED","PENDING","PENDING","PENDING","CONFIRMED","PENDING","CONFIRMED","CONFIRMED","PENDING","PENDING","PENDING","CONFIRMED","CONFIRMED","PENDING","CANCELLED","CONFIRMED","PENDING","CONFIRMED"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>party<\/th>\n      <th>name<\/th>\n      <th>meal_wedding<\/th>\n      <th>meal_brunch<\/th>\n      <th>attendance_wedding<\/th>\n      <th>attendance_brunch<\/th>\n      <th>attendance_golf<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

1. Put "meal" and "attendance" as their own columns, with the events living in a new column.


```r
guest_long <- guest %>% 
  pivot_longer(cols = c(-party, -name), 
               names_to  = c(".value", "event"),
               names_sep = "_")
```

2. Use `tidyr::separate()` to split the name into two columns: "first" and 
"last". Then, re-unite them with `tidyr::unite()`.


```r
guest_long_sepnames <- guest_long %>% 
  separate(name,
           into = c("first", "last"),
           sep = " ")

guest_long_unitenames <- guest_long_sepnames %>%
  unite("name",
        first:last,
        sep = " ",
        remove = TRUE,
        na.rm = FALSE)
```

3. Which parties still have a "PENDING" status for all members and all events?


```r
guest_long_pendall <- guest_long %>% 
  group_by(party) %>% 
  summarize(all_pending = all(attendance == "PENDING"))
```

4. Which parties still have a "PENDING" status for all members for the wedding?


```r
guest_long_pendwed <- guest_long %>%
  filter(event == "wedding") %>%
  group_by(party) %>%
  summarize(pending_wedding = all(attendance == "PENDING"))
```

5. Put the data back to the way it was.


```r
guest_revert <- guest_long %>% 
  pivot_wider(id_cols = c(-event),
              names_from = event,
              names_sep = "_",
              values_from = c("meal", "attendance")) %>%
  subset(select = -c(meal_golf))
```

6. You also have a list of emails for each party, in this worksheet under the 
   object `email`. Change this so that each person gets their own row. 
   Use `tidyr::separate_rows()`


```r
guest_email <- email %>% 
  separate_rows(guest, sep = ", ")
```

# Exercise 3: Making Tibbles

1. Create a tibble that has the following columns:

- A `label` column with `"Sample A"` in its entries.
- 100 random observations drawn from the N(0,1) distribution in the column `x`
  - "N" means the normal distribution. "(0, 1)" means mean = 0, sd = 1.
  - Use `rnorm()`
- `y` calculated as the `x` values + N(0,1) error. 


```r
n <- 100
tibble(label = "Sample A",
             x = rnorm(n),
             y = x + sd(x))
```

```
## # A tibble: 100 x 3
##    label          x      y
##    <chr>      <dbl>  <dbl>
##  1 Sample A  0.628   1.48 
##  2 Sample A -1.09   -0.236
##  3 Sample A -2.39   -1.53 
##  4 Sample A -1.79   -0.939
##  5 Sample A -0.0203  0.832
##  6 Sample A  0.0891  0.941
##  7 Sample A  1.15    2.00 
##  8 Sample A -0.644   0.208
##  9 Sample A -0.146   0.706
## 10 Sample A -2.56   -1.71 
## # ... with 90 more rows
```

2. Generate a Normal sample of size 100 for each combination of the following 
means (`mu`) and standard deviations (`sd`).


```r
n <- 100
mu <- c(-5, 0, 5)
sd <- c(1, 3, 10)
tibble(mu = mu, sd = sd) %>% 
  group_by_all() %>% 
  mutate(z = list(rnorm(n, mu, sd))) %>%
  unnest(z)
```

```
## # A tibble: 300 x 3
## # Groups:   mu, sd [3]
##       mu    sd     z
##    <dbl> <dbl> <dbl>
##  1    -5     1 -5.89
##  2    -5     1 -6.01
##  3    -5     1 -4.02
##  4    -5     1 -4.78
##  5    -5     1 -6.65
##  6    -5     1 -4.94
##  7    -5     1 -4.65
##  8    -5     1 -5.34
##  9    -5     1 -3.59
## 10    -5     1 -3.65
## # ... with 290 more rows
```

3. Fix the `experiment` tibble below (originally defined in the documentation 
of the `tidyr::expand()` function) so that all three repeats are displayed for 
each person, and the measurements are kept. Some code is given, but it doesn't
quite work. It needs a few adjustments. What are they?


```r
experiment <- tibble(
  name = rep(c("Alex", "Robert", "Sam"), c(3, 2, 1)),
  trt  = rep(c("a", "b", "a"), c(3, 2, 1)),
  rep = c(1, 2, 3, 1, 2, 1),
  measurement_1 = runif(6),
  measurement_2 = runif(6)
)
experiment %>% complete(nesting(name, trt), rep)
```

```
## # A tibble: 9 x 5
##   name   trt     rep measurement_1 measurement_2
##   <chr>  <chr> <dbl>         <dbl>         <dbl>
## 1 Alex   a         1         0.813        0.525 
## 2 Alex   a         2         0.283        0.284 
## 3 Alex   a         3         0.214        0.712 
## 4 Robert b         1         0.533        0.0760
## 5 Robert b         2         0.161        0.801 
## 6 Robert b         3        NA           NA     
## 7 Sam    a         1         0.880        0.441 
## 8 Sam    a         2        NA           NA     
## 9 Sam    a         3        NA           NA
```
