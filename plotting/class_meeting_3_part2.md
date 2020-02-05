---
title: "cm008 Exercises: Fix the Plots"
author: "Joanna Lawler"
date: Last updated 04 February, 2020
output: 
  html_document:
    keep_md: TRUE
    theme: cerulean
    toc: TRUE
---

In this worksheet, we'll be looking at some erroneous plots and fixing them. 

I think you might not have these two packages installed:


```r
# install.packages("ggridges")
# install.packages("scales")
```

The exercsies below include some data wrangling function. It's okay if you
aren't familiar with them all yet! We will get into a lot of them over the
next few weeks, but see if you can figure out what they are doing as you go.


```r
library(tidyverse)
library(gapminder)
library(ggridges)
library(scales)
```

<!-- The following chunk allows errors when knitting -->



## Exercise 1: Overlapping Points

Fix the overlapping data points problem in the following plot by adding an `alpha`
or `size` argument (attribution: ["R for data science"](https://r4ds.had.co.nz/data-visualisation.html)).


```r
mpg %>%  
  ggplot(aes(cty, hwy)) + 
  geom_point(alpha = 0.2) +
  xlab("City MPG") +
  ylab("Highway MPG")
```

![](class_meeting_3_part2_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

## Exercise 2: Line for each Country

Fix this plot so that it shows life expectancy over time with a separate line
_for each country_. 

Notice that we tried to use `group_by()`. We will cover that next week. But 
also notice that `ggplot2` ignores the grouping of a tibble!


```r
gapminder %>%
  ggplot(aes(year, lifeExp)) +
  geom_line(aes(group = country), alpha = 0.2) +
  xlab("Year") +
  ylab("Life Expectancy")
```

![](class_meeting_3_part2_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

## Exercise 3: More gdpPercap vs lifeExp

### 3(a) Facets

- Change the x-axis text to be in "comma format" with `scales::comma_format()`.
- Separate each continent into sub-panels.


```r
gapminder %>% 
  ggplot(aes(gdpPercap, lifeExp)) +
  geom_point(alpha = 0.2) +
  scale_x_log10("GDP Per Capita", labels = scales::comma_format()) +
  facet_wrap(vars(continent)) +
  ylab("Life Expectancy")
```

![](class_meeting_3_part2_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

### 3(b) Bubble Plot

- Put the plots in one row, and free up the axes (let them have different scales).
- Make a bubble plot by making the size of the points proportional to population.
  - Try adding a `scale_size_area()` layer too (could also try `scale_radius()` 
    but that is not optimal for perception).
- Use `shape=21` to distinguish between `fill` (interior) and `color` (exterior).


```r
gapminder %>% 
  filter(continent != "Oceania") %>% 
  ggplot(aes(gdpPercap, lifeExp, size = pop, fill = continent, options(scipen = 999))) +
  facet_wrap(vars(continent), nrow = 1, scales = "free") +
  geom_point(alpha = 0.2, shape = 21) +
  scale_x_log10("GDP Per Capita", labels = scales::comma_format()) +
  scale_size_area("Population", labels = scales::comma_format()) +
  ylab("Life Expectancy") +
  guides(fill = FALSE)
```

![](class_meeting_3_part2_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

A list of shapes can be found [at the bottom of the `scale_shape` documentation](https://ggplot2.tidyverse.org/reference/scale_shape.html).

### 3(c) Size "not working"

Instead of alpha transparency, suppose you're wanting to fix the overplotting issue by plotting small points. Why is this not working? Fix it.

It was not working because a parenthesis needed to follow the specification of the x and y variables.


```r
gapminder %>%
  ggplot() +
  geom_point(aes(gdpPercap, lifeExp), size = 0.1) +
  scale_x_log10("GDP Per Capita", labels = scales::dollar_format()) +
  ylab("Life Expectancy")
```

![](class_meeting_3_part2_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

## Exercise 4: Walking caribou

The following mock data set marks the (x,y) position of a caribou at four time points. 

- Fix the plot below so that it shows the path of the caribou. 
- Add an arrow with `arrow = arrow()`.
- Add the `time` label with `geom_text()`.


```r
tribble(
  ~time, ~x, ~y,
  1, 0.3, 0.3,
  2, 0.8, 0.7,
  3, 0.5, 0.9,
  4, 0.4, 0.5
) %>%
  ggplot(aes(x, y)) + 
  geom_path(arrow = arrow()) +
  geom_text(aes(label = time))
```

![](class_meeting_3_part2_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

```r
# This page helped me troubleshoot: https://stackoverflow.com/questions/22458970/how-to-reverse-legend-labels-and-color-so-high-value-starts-downstairs
```

## Exercise 5: Life expectancies in Africa

### 5(a) Unhiding the data

Fix the plot so that you can actually see the data points. 

There is also the problem of overlapping text in the x-axis labels. How could we solve that?

I solved it by placing the labels at a 45 degree angle. This could have also been solved by switching the x and y variables.


```r
gapminder %>% 
  filter(continent == "Americas") %>% 
  ggplot(aes(country, lifeExp)) +
  geom_boxplot() +
  geom_point(alpha = 0.2) +
  scale_x_discrete("Country") +
  theme(axis.text.x  = element_text(angle = 45, hjust = 1)) +
  ylab("Life Expectancy")
```

![](class_meeting_3_part2_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

```r
# This page helped me troubleshoot: https://www.datanovia.com/en/blog/ggplot-axis-ticks-set-and-rotate-text-labels/
```

### 5(b) Ridgeplots

We're starting with the same plot as above, but instead of the points + boxplot, try a ridge plot instead using `ggridges::geom_density_ridges()`, and adjust the `bandwidth`.


```r
gapminder %>% 
  filter(continent == "Americas") %>% 
  ggplot(aes(lifeExp, country)) + 
  ggridges::geom_density_ridges(bandwidth = 2.5) +
  xlab("Life Expectancy") +
  ylab("Country")
```

![](class_meeting_3_part2_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

## Exercise 6: Bar plot madness

### 6(a) Colour and stacking madness

- Change the following plot so that it shows _proportion_ on the y-axis, not count.
- Change the x-axis so that it doesn't appear to be continuous.
  - Hint: Transform the variable!
- Also change the colors of the bar fills, as well as the lines.
- Put the bars for transmission side-by-side with their own colour.
- Capitalize the legend title.


```r
mtcars %>% 
  mutate(transmission = if_else(am == 0, "automatic", "manual")) %>%
  mutate(cyl = recode(mtcars$cyl, `4` = "Four", `6` = "Six", `8` = "Eight")) %>%
  ggplot(aes(cyl, ..prop.., group = transmission, fill = transmission)) +
  geom_bar(position = "dodge") +
  scale_x_discrete("Cylinders", limits = c("Four","Six","Eight")) +
  ylab("Transmission Proportion") +
  labs(fill = "Transmission Type")
```

![](class_meeting_3_part2_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

### 6(b) Bar heights already calculated

Here's the number of people having a certain hair colour from a sample of 592 people:


```r
(hair <- as_tibble(HairEyeColor) %>% 
  count(Hair, wt = n))
```

```
## # A tibble: 4 x 2
##   Hair      n
##   <chr> <dbl>
## 1 Black   108
## 2 Blond   127
## 3 Brown   286
## 4 Red      71
```

Fix the following bar plot so that it shows these counts.


```r
ggplot(hair, aes(Hair, n, fill = Hair)) +
  geom_bar(stat = "identity") +
  guides(fill = FALSE) +
  xlab("Hair Color") +
  ylab("Number of People")
```

![](class_meeting_3_part2_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

## Exercise 7: Tiling

Here's the number of people having a certain hair and eye colour from a sample of 592 people:


```r
(hair_eye <- as_tibble(HairEyeColor) %>% 
  count(Hair, Eye, wt = n))
```

```
## # A tibble: 16 x 3
##    Hair  Eye       n
##    <chr> <chr> <dbl>
##  1 Black Blue     20
##  2 Black Brown    68
##  3 Black Green     5
##  4 Black Hazel    15
##  5 Blond Blue     94
##  6 Blond Brown     7
##  7 Blond Green    16
##  8 Blond Hazel    10
##  9 Brown Blue     84
## 10 Brown Brown   119
## 11 Brown Green    29
## 12 Brown Hazel    54
## 13 Red   Blue     17
## 14 Red   Brown    26
## 15 Red   Green    14
## 16 Red   Hazel    14
```

Fix the following plot so that it shows a filled-in square for each combination. 
_Hint:_ What's the title of this exercise?


```r
ggplot(hair_eye, aes(Hair, Eye)) +
  geom_tile(aes(fill = n)) +
  guides(fill = guide_colorbar(reverse = TRUE)) +
  xlab("Hair Color") +
  ylab("Eye Color") +
  labs(fill = "Number of People")
```

![](class_meeting_3_part2_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

By the way, `geom_count()` is like `geom_bar()`: it counts the number of overlapping points.

## Additional take-home practice

If you'd like some practice, give these exercises a try

__Exercise 1__: Make a plot of `year` (x) vs `lifeExp` (y), with points coloured by continent. Then, to that same plot, fit a straight regression line to each continent, without the error bars. If you can, try piping the data frame into the `ggplot()` function.


```r
gapminder %>%
  ggplot(aes(year, lifeExp, color = continent)) +
  geom_point(alpha = 0.2) +
  geom_smooth(method = "lm", se = FALSE) +
  xlab("Year") +
  ylab("Life Expectancy") +
  labs(color = "Continent")
```

![](class_meeting_3_part2_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

__Exercise 2__: Repeat Exercise 1, but switch the _regression line_ and _geom\_point_ layers. How is this plot different from that of Exercise 1?

Now, the points are on top of the regression line.


```r
gapminder %>%
  ggplot(aes(year, lifeExp, color = continent)) +
  geom_smooth(method = "lm", se = FALSE) +
  geom_point(alpha = 0.2) +
  xlab("Year") +
  ylab("Life Expectancy") +
  labs(color = "Continent")
```

![](class_meeting_3_part2_files/figure-html/unnamed-chunk-17-1.png)<!-- -->

__Exercise 3__: Omit the `geom_point()` layer from either of the above two plots (it doesn't matter which). Does the line still show up, even though the data aren't shown? Why or why not?

The regression lines are still visible - their presence is depedent on the aesthetic mappings and on geom_smooth, not on the points.


```r
gapminder %>%
  ggplot(aes(year, lifeExp, color = continent)) +
  geom_smooth(method = "lm", se = FALSE) +
  xlab("Year") +
  ylab("Life Expectancy") +
  labs(color = "Continent")
```

![](class_meeting_3_part2_files/figure-html/unnamed-chunk-18-1.png)<!-- -->

__Exercise 4__: Make a plot of `year` (x) vs `lifeExp` (y), facetted by continent. Then, fit a smoother through the data for each continent, without the error bars. Choose a span that you feel is appropriate.


```r
gapminder %>%
  ggplot(aes(year, lifeExp)) +
  geom_line(aes(group = country), alpha = 0.2) +
  geom_smooth(se = FALSE) +
  facet_wrap(vars(continent)) +
  scale_x_continuous("Year", breaks = seq(1952, 2007, by = 10)) +
  ylab("Life Expectancy")
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](class_meeting_3_part2_files/figure-html/unnamed-chunk-19-1.png)<!-- -->

__Exercise 5__: Plot the population over time (year) using lines, so that each country has its own line. Colour by `gdpPercap`. Add alpha transparency to your liking.


```r
gapminder %>%
  ggplot(aes(year, pop)) +
  geom_line(aes(group = country, color = gdpPercap), alpha = 0.2) +
  scale_y_log10("Population", labels = scales::comma_format()) +
  scale_color_continuous("GDP Per Capita", labels = scales::comma_format()) +
  xlab("Year") +
  guides(color = guide_colorbar(reverse = TRUE))
```

![](class_meeting_3_part2_files/figure-html/unnamed-chunk-20-1.png)<!-- -->

__Exercise 6__: Add points to the plot in Exercise 5.


```r
gapminder %>%
  ggplot(aes(year, pop)) +
  geom_point(alpha = 0.2) +
  geom_line(aes(group = country, color = gdpPercap), alpha = 0.2) +
  scale_y_log10("Population", labels = scales::comma_format()) +
  scale_color_continuous("GDP Per Capita", labels = scales::comma_format()) +
  xlab("Year") +
  guides(color = guide_colorbar(reverse = TRUE))
```

![](class_meeting_3_part2_files/figure-html/unnamed-chunk-21-1.png)<!-- -->