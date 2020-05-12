---
title: "Joining Tibbles"
author: "Joanna Lawler"
output: 
  html_document:
    keep_md: TRUE
    theme: cerulean
    toc: TRUE
---

# 7.4 Activity
# Requirements

You will need data from Joey Bernhardt's `singer` R package for this exercise. 

You can download the singer data from the `USF-Psych-DataSci/Classroom` repo:


```r
library(tidyverse)
songs <- read_csv("https://raw.githubusercontent.com/USF-Psych-DataSci/Classroom/master/data/singer/songs.csv")
locations <- read_csv("https://raw.githubusercontent.com/USF-Psych-DataSci/Classroom/master/data/singer/loc.csv")
```

If you want, you could instead install the `singer` package itself. To do that, you'll need to install `devtools`. Running this code in your console should do the trick:


```r
# install.packages("devtools")
# devtools::install_github("JoeyBernhardt/singer")
```

Load required packages:



<!-- The following chunk allows errors when knitting -->



## Exercise 1: `singer`

The package `singer` comes with two smallish data frames about songs. 
Let's take a look at them (after minor modifications by renaming and shuffling):


```r
time <- as_tibble(songs) %>% 
   rename(song = title)
```


```r
album <- as_tibble(locations) %>% 
   select(title, everything()) %>% 
   rename(album = release,
          song  = title)
```

1. We really care about the songs in `time`. But, for which of those songs do we know its corresponding album?


```r
time %>% 
  inner_join(album, by = "song") %>%
  select(song, album, everything())
```

```
## # A tibble: 13 x 6
##    song               album          artist_name.x   year artist_name.y city    
##    <chr>              <chr>          <chr>          <dbl> <chr>         <chr>   
##  1 "Grievance"        Binaural       Pearl Jam       2000 Pearl Jam     Seattle~
##  2 "Stupidmop"        Vitalogy       Pearl Jam       1994 Pearl Jam     Seattle~
##  3 "Present Tense"    No Code        Pearl Jam       1996 Pearl Jam     Seattle~
##  4 "MFC"              Live On Two L~ Pearl Jam       1998 Pearl Jam     Seattle~
##  5 "Lukin"            Seattle Washi~ Pearl Jam       1996 Pearl Jam     Seattle~
##  6 "It's Lulu"        Best Of        The Boo Radle~  1995 The Boo Radl~ Liverpo~
##  7 "Sparrow"          Everything's ~ The Boo Radle~  1992 The Boo Radl~ Liverpo~
##  8 "High as Monkeys"  Kingsize       The Boo Radle~  1998 The Boo Radl~ Liverpo~
##  9 "Butterfly McQuee~ Giant Steps    The Boo Radle~  1993 The Boo Radl~ Liverpo~
## 10 "My One and Only ~ Moonlight Ser~ Carly Simon     2005 Carly Simon   New Yor~
## 11 "It Was So Easy  ~ No Secrets     Carly Simon     1972 Carly Simon   New Yor~
## 12 "I've Got A Crush~ Clouds In My ~ Carly Simon     1994 Carly Simon   New Yor~
## 13 "Manha De Carnava~ Into White     Carly Simon     2007 Carly Simon   New Yor~
```

2. Go ahead and add the corresponding albums to the `time` tibble, being sure to preserve rows even if album info is not readily available.


```r
time %>% 
  left_join(album, by = "song") %>%
  select(song, album, everything())
```

```
## # A tibble: 22 x 6
##    song            album            artist_name.x   year artist_name.y city     
##    <chr>           <chr>            <chr>          <dbl> <chr>         <chr>    
##  1 Corduroy        <NA>             Pearl Jam       1994 <NA>          <NA>     
##  2 Grievance       Binaural         Pearl Jam       2000 Pearl Jam     Seattle,~
##  3 Stupidmop       Vitalogy         Pearl Jam       1994 Pearl Jam     Seattle,~
##  4 Present Tense   No Code          Pearl Jam       1996 Pearl Jam     Seattle,~
##  5 MFC             Live On Two Legs Pearl Jam       1998 Pearl Jam     Seattle,~
##  6 Lukin           Seattle Washing~ Pearl Jam       1996 Pearl Jam     Seattle,~
##  7 It's Lulu       Best Of          The Boo Radle~  1995 The Boo Radl~ Liverpoo~
##  8 Sparrow         Everything's Al~ The Boo Radle~  1992 The Boo Radl~ Liverpoo~
##  9 Martin_ Doom! ~ <NA>             The Boo Radle~  1995 <NA>          <NA>     
## 10 Leaves And Sand <NA>             The Boo Radle~  1993 <NA>          <NA>     
## # ... with 12 more rows
```

3. Which songs do we have "year", but not album info?


```r
time %>% 
  anti_join(album, by = "song")
```

```
## # A tibble: 9 x 3
##   song                             artist_name      year
##   <chr>                            <chr>           <dbl>
## 1 Corduroy                         Pearl Jam        1994
## 2 Martin_ Doom! It's Seven O'Clock The Boo Radleys  1995
## 3 Leaves And Sand                  The Boo Radleys  1993
## 4 Comb Your Hair                   The Boo Radleys  1998
## 5 Mine Again                       Mariah Carey     2005
## 6 Don't Forget About Us            Mariah Carey     2005
## 7 Babydoll                         Mariah Carey     1997
## 8 Don't Forget About Us            Mariah Carey     2005
## 9 Vision Of Love                   Mariah Carey     1990
```

4. Which artists are in `time`, but not in `album`?


```r
time %>% 
  anti_join(album, by = "artist_name")
```

```
## # A tibble: 5 x 3
##   song                  artist_name   year
##   <chr>                 <chr>        <dbl>
## 1 Mine Again            Mariah Carey  2005
## 2 Don't Forget About Us Mariah Carey  2005
## 3 Babydoll              Mariah Carey  1997
## 4 Don't Forget About Us Mariah Carey  2005
## 5 Vision Of Love        Mariah Carey  1990
```

5. You've come across these two tibbles, and just wish all the info was available in one tibble. What would you do?


```r
time %>%
  full_join(album, by = c("song", "artist_name"))
```

```
## # A tibble: 23 x 5
##    song                  artist_name     year city         album                
##    <chr>                 <chr>          <dbl> <chr>        <chr>                
##  1 Corduroy              Pearl Jam       1994 <NA>         <NA>                 
##  2 Grievance             Pearl Jam       2000 Seattle, WA  Binaural             
##  3 Stupidmop             Pearl Jam       1994 Seattle, WA  Vitalogy             
##  4 Present Tense         Pearl Jam       1996 Seattle, WA  No Code              
##  5 MFC                   Pearl Jam       1998 Seattle, WA  Live On Two Legs     
##  6 Lukin                 Pearl Jam       1996 Seattle, WA  Seattle Washington N~
##  7 It's Lulu             The Boo Radle~  1995 Liverpool, ~ Best Of              
##  8 Sparrow               The Boo Radle~  1992 Liverpool, ~ Everything's Alright~
##  9 Martin_ Doom! It's S~ The Boo Radle~  1995 <NA>         <NA>                 
## 10 Leaves And Sand       The Boo Radle~  1993 <NA>         <NA>                 
## # ... with 13 more rows
```

```r
time %>% 
  full_join(album, by = intersect(names(time), names(album)))
```

```
## # A tibble: 23 x 5
##    song                  artist_name     year city         album                
##    <chr>                 <chr>          <dbl> <chr>        <chr>                
##  1 Corduroy              Pearl Jam       1994 <NA>         <NA>                 
##  2 Grievance             Pearl Jam       2000 Seattle, WA  Binaural             
##  3 Stupidmop             Pearl Jam       1994 Seattle, WA  Vitalogy             
##  4 Present Tense         Pearl Jam       1996 Seattle, WA  No Code              
##  5 MFC                   Pearl Jam       1998 Seattle, WA  Live On Two Legs     
##  6 Lukin                 Pearl Jam       1996 Seattle, WA  Seattle Washington N~
##  7 It's Lulu             The Boo Radle~  1995 Liverpool, ~ Best Of              
##  8 Sparrow               The Boo Radle~  1992 Liverpool, ~ Everything's Alright~
##  9 Martin_ Doom! It's S~ The Boo Radle~  1995 <NA>         <NA>                 
## 10 Leaves And Sand       The Boo Radle~  1993 <NA>         <NA>                 
## # ... with 13 more rows
```

## Exercise 2: LOTR

Load in three tibbles of data on the Lord of the Rings:


```r
fell <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")
```

```
## Parsed with column specification:
## cols(
##   Film = col_character(),
##   Race = col_character(),
##   Female = col_double(),
##   Male = col_double()
## )
```

```r
ttow <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv")
```

```
## Parsed with column specification:
## cols(
##   Film = col_character(),
##   Race = col_character(),
##   Female = col_double(),
##   Male = col_double()
## )
```

```r
retk <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")
```

```
## Parsed with column specification:
## cols(
##   Film = col_character(),
##   Race = col_character(),
##   Female = col_double(),
##   Male = col_double()
## )
```

1. Combine these into a single tibble.


```r
bind_rows(fell, ttow, retk)
```

```
## # A tibble: 9 x 4
##   Film                       Race   Female  Male
##   <chr>                      <chr>   <dbl> <dbl>
## 1 The Fellowship Of The Ring Elf      1229   971
## 2 The Fellowship Of The Ring Hobbit     14  3644
## 3 The Fellowship Of The Ring Man         0  1995
## 4 The Two Towers             Elf       331   513
## 5 The Two Towers             Hobbit      0  2463
## 6 The Two Towers             Man       401  3589
## 7 The Return Of The King     Elf       183   510
## 8 The Return Of The King     Hobbit      2  2673
## 9 The Return Of The King     Man       268  2459
```

2. Which races are present in "The Fellowship of the Ring" (`fell`), but not in any of the other ones?


```r
fell %>% 
  anti_join(ttow, by = "Race") %>% 
  anti_join(retk, by = "Race")
```

```
## # A tibble: 0 x 4
## # ... with 4 variables: Film <chr>, Race <chr>, Female <dbl>, Male <dbl>
```

```r
unique(fell$Race)
```

```
## [1] "Elf"    "Hobbit" "Man"
```

## Exercise 3: Set Operations

Let's use three set functions: `intersect`, `union` and `setdiff`. We'll work with two toy tibbles named `y` and `z`, similar to Data Wrangling Cheatsheet


```r
(y <-  tibble(x1 = LETTERS[1:3], x2 = 1:3))
```

```
## # A tibble: 3 x 2
##   x1       x2
##   <chr> <int>
## 1 A         1
## 2 B         2
## 3 C         3
```


```r
(z <- tibble(x1 = c("B", "C", "D"), x2 = 2:4))
```

```
## # A tibble: 3 x 2
##   x1       x2
##   <chr> <int>
## 1 B         2
## 2 C         3
## 3 D         4
```

1. Rows that appear in both `y` and `z`


```r
intersect(y, z)
```

```
## # A tibble: 2 x 2
##   x1       x2
##   <chr> <int>
## 1 B         2
## 2 C         3
```

2. You collected the data in `y` on Day 1, and `z` in Day 2. Make a data set to reflect that.


```r
union(
  mutate(y, day = "Day 1"),
  mutate(z, day = "Day 2")
)
```

```
## # A tibble: 6 x 3
##   x1       x2 day  
##   <chr> <int> <chr>
## 1 A         1 Day 1
## 2 B         2 Day 1
## 3 C         3 Day 1
## 4 B         2 Day 2
## 5 C         3 Day 2
## 6 D         4 Day 2
```

3. The rows contained in `z` are bad! Remove those rows from `y`.


```r
setdiff(y, z)
```

```
## # A tibble: 1 x 2
##   x1       x2
##   <chr> <int>
## 1 A         1
```
