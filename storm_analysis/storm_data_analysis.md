---
title: "Storm Data Analysis"
author: Xia Cui
output:
    html_document:
        keep_md: true
---



### Synopsis 

Storms and other severe weather events can cause both public health and economic problems for communities and municipalities. Many severe events can result in fatalities, injuries, and property damage, and preventing such outcomes to the extent possible is a key concern.

The dataset in this project is obtained from the U.S. National Oceanic and Atmospheric Administration's (NOAA) storm database. The events in the database start in the year 1950 and end in November 2011. 

The original dataset contains 902297 rows and 37 columns. The preprocessing of the data reduced the dataset to contain only columns that are key to addressing the central questions in this report: 

1. Which types of events are the most harmful to public health? 

2. Which types of events are the most damaging to the economy.  


From the exploratory analysis of the reduced dataset, we found out that tornado is the most harmful event to public health, as measured by fatalities and injuries, and it affects certain states more severely than others. 


In terms of economic damage, flood caused the most property damange, whereas drought caused the most crop damage. Below shows the process of arriving at such conclusions. 


### 1. Downloading the packages needed


```r
library(downloader)
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(readr)
library(tidyr)
library(ggplot2)
```


### 2. Loading and preprocessing the raw data

**Downloading the data**



```r
url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"

setwd("./Documents")

download(url, "./Rprogramming/storm_data/storm_data.csv.bz2", mode = "wb")
```


**Loading data into R and checking the first 6 columns**


```r
storm_data <- read.csv('./Documents/Rprogramming/storm_data/storm_data.csv.bz2')
head(storm_data)
```

```
##   STATE__           BGN_DATE BGN_TIME TIME_ZONE COUNTY COUNTYNAME STATE  EVTYPE
## 1       1  4/18/1950 0:00:00     0130       CST     97     MOBILE    AL TORNADO
## 2       1  4/18/1950 0:00:00     0145       CST      3    BALDWIN    AL TORNADO
## 3       1  2/20/1951 0:00:00     1600       CST     57    FAYETTE    AL TORNADO
## 4       1   6/8/1951 0:00:00     0900       CST     89    MADISON    AL TORNADO
## 5       1 11/15/1951 0:00:00     1500       CST     43    CULLMAN    AL TORNADO
## 6       1 11/15/1951 0:00:00     2000       CST     77 LAUDERDALE    AL TORNADO
##   BGN_RANGE BGN_AZI BGN_LOCATI END_DATE END_TIME COUNTY_END COUNTYENDN
## 1         0                                               0         NA
## 2         0                                               0         NA
## 3         0                                               0         NA
## 4         0                                               0         NA
## 5         0                                               0         NA
## 6         0                                               0         NA
##   END_RANGE END_AZI END_LOCATI LENGTH WIDTH F MAG FATALITIES INJURIES PROPDMG
## 1         0                      14.0   100 3   0          0       15    25.0
## 2         0                       2.0   150 2   0          0        0     2.5
## 3         0                       0.1   123 2   0          0        2    25.0
## 4         0                       0.0   100 2   0          0        2     2.5
## 5         0                       0.0   150 2   0          0        2     2.5
## 6         0                       1.5   177 2   0          0        6     2.5
##   PROPDMGEXP CROPDMG CROPDMGEXP WFO STATEOFFIC ZONENAMES LATITUDE LONGITUDE
## 1          K       0                                         3040      8812
## 2          K       0                                         3042      8755
## 3          K       0                                         3340      8742
## 4          K       0                                         3458      8626
## 5          K       0                                         3412      8642
## 6          K       0                                         3450      8748
##   LATITUDE_E LONGITUDE_ REMARKS REFNUM
## 1       3051       8806              1
## 2          0          0              2
## 3          0          0              3
## 4          0          0              4
## 5          0          0              5
## 6          0          0              6
```

**Check the dimensions of the dataset.** 


```r
dim(storm_data)
```

```
## [1] 902297     37
```


**Reducing the dataset**

Given the goal of this report is to find out which types of events are the most harmful to population health, as well as to the economy, we will reduce the dataset to include only those that are relevant to the tasks at hand. 



```r
storm_data_new <- storm_data %>% 
    select(STATE, BGN_DATE, EVTYPE, FATALITIES,INJURIES, PROPDMG, 
           PROPDMGEXP, CROPDMG, CROPDMGEXP)
```


**Using the summary function to check the data**



```r
summary(storm_data_new)
```

```
##     STATE             BGN_DATE            EVTYPE            FATALITIES      
##  Length:902297      Length:902297      Length:902297      Min.   :  0.0000  
##  Class :character   Class :character   Class :character   1st Qu.:  0.0000  
##  Mode  :character   Mode  :character   Mode  :character   Median :  0.0000  
##                                                           Mean   :  0.0168  
##                                                           3rd Qu.:  0.0000  
##                                                           Max.   :583.0000  
##     INJURIES            PROPDMG         PROPDMGEXP           CROPDMG       
##  Min.   :   0.0000   Min.   :   0.00   Length:902297      Min.   :  0.000  
##  1st Qu.:   0.0000   1st Qu.:   0.00   Class :character   1st Qu.:  0.000  
##  Median :   0.0000   Median :   0.00   Mode  :character   Median :  0.000  
##  Mean   :   0.1557   Mean   :  12.06                      Mean   :  1.527  
##  3rd Qu.:   0.0000   3rd Qu.:   0.50                      3rd Qu.:  0.000  
##  Max.   :1700.0000   Max.   :5000.00                      Max.   :990.000  
##   CROPDMGEXP       
##  Length:902297     
##  Class :character  
##  Mode  :character  
##                    
##                    
## 
```



**First, let's change the date column to *date* type**



```r
library(lubridate)
```

```
## 
## Attaching package: 'lubridate'
```

```
## The following objects are masked from 'package:base':
## 
##     date, intersect, setdiff, union
```

```r
storm_data_new$BGN_DATE <- mdy_hms(storm_data_new$BGN_DATE)
```



**rename the columns to make them more readable**



```r
storm_data_new <- storm_data_new %>% 
    rename(state = STATE, begin_date = BGN_DATE, event_type = EVTYPE,
           fatalities = FATALITIES, injuries = INJURIES, prop_damage = PROPDMG, 
           prop_damage_unit = PROPDMGEXP, crop_damage = CROPDMG, 
           crop_damage_unit = CROPDMGEXP)
colnames(storm_data_new)
```

```
## [1] "state"            "begin_date"       "event_type"       "fatalities"      
## [5] "injuries"         "prop_damage"      "prop_damage_unit" "crop_damage"     
## [9] "crop_damage_unit"
```


**Check NA values**



```r
sum(is.na(storm_data_new))
```

```
## [1] 0
```



```r
head(storm_data_new)
```

```
##   state begin_date event_type fatalities injuries prop_damage prop_damage_unit
## 1    AL 1950-04-18    TORNADO          0       15        25.0                K
## 2    AL 1950-04-18    TORNADO          0        0         2.5                K
## 3    AL 1951-02-20    TORNADO          0        2        25.0                K
## 4    AL 1951-06-08    TORNADO          0        2         2.5                K
## 5    AL 1951-11-15    TORNADO          0        2         2.5                K
## 6    AL 1951-11-15    TORNADO          0        6         2.5                K
##   crop_damage crop_damage_unit
## 1           0                 
## 2           0                 
## 3           0                 
## 4           0                 
## 5           0                 
## 6           0
```



### 3. Which types of event are the most harmful to population health? 


**Fatalities by events**


```r
total_fatalities <-  storm_data_new %>% 
    group_by(event_type) %>% 
    summarise(total_fatalities = sum(fatalities))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```



```r
total_fatalities_ranking <- total_fatalities[
    order(-total_fatalities$total_fatalities),]
```



**The top 10 types of event that have caused the most fatalities**




```r
total_fatalities_ranking[1:10,]
```

```
## # A tibble: 10 x 2
##    event_type     total_fatalities
##    <chr>                     <dbl>
##  1 TORNADO                    5633
##  2 EXCESSIVE HEAT             1903
##  3 FLASH FLOOD                 978
##  4 HEAT                        937
##  5 LIGHTNING                   816
##  6 TSTM WIND                   504
##  7 FLOOD                       470
##  8 RIP CURRENT                 368
##  9 HIGH WIND                   248
## 10 AVALANCHE                   224
```


As shown above, tornado is the worst offender causing the most fatalities, followed by excessive heat, flash flood, and heat. 

Now let's also have a look at which states are impacted by tornado related fatalities most. 




```r
tornado_by_state <- storm_data_new %>% filter (event_type == 'TORNADO') %>% 
    group_by(state) %>% summarise(total_fatalities = sum (fatalities))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```


```r
ggplot(tornado_by_state, aes(state, total_fatalities)) + 
    geom_point(color = 'blue') + theme_bw() +
    labs(title = 'Total fatalities by state') +
    theme(plot.title = element_text(hjust = 0.5)) +
    labs(y = 'Total fatalities') +
    labs(x = 'State') +
    theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) + 
    geom_text(aes(label = ifelse(total_fatalities > 300, state, '')), 
              hjust = 0, vjust = -0.3, color = 'red')
```

![](storm_data_analysis_files/figure-html/unnamed-chunk-10-1.png)<!-- -->



As shown in the plot above, while for majority of the states, the tornado related fatalities are 0, some states have experienced high fatalities, among which AL has experienced the worst, followed by TX and MS.  This could be the result of a particular severe tornado event, or these states are geographically prone to being affected by tornados. Out of curiosity, Let's have a look at the state AL and how it has been affected by tornado over the duration documented in the dataset. 


**Injuries by events**



```r
tornado_al <- storm_data_new %>% 
    filter(event_type == 'TORNADO', state == 'AL') %>% 
    group_by(begin_date) %>%
    summarise(total_fatalities = sum(fatalities))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```r
tornado_al[order(-tornado_al$total_fatalities), ][1:10,]
```

```
## # A tibble: 10 x 2
##    begin_date          total_fatalities
##    <dttm>                         <dbl>
##  1 2011-04-27 00:00:00              235
##  2 1974-04-03 00:00:00               77
##  3 1998-04-08 00:00:00               34
##  4 1956-04-15 00:00:00               25
##  5 1977-04-04 00:00:00               23
##  6 1994-03-27 00:00:00               22
##  7 1989-11-15 00:00:00               21
##  8 2000-12-16 00:00:00               12
##  9 2002-11-10 00:00:00               12
## 10 1964-01-24 00:00:00               10
```


The above table shows that Alabama was hit most severely by tornado in 2011, causing 235 total fatalities. 


**Top 10 events that have caused the most injuries**



```r
total_injuries <- storm_data_new%>%
    group_by(event_type)%>%
    summarise(total_injuries = sum(injuries))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```



```r
total_injuries_ranking <- total_injuries[order(-total_injuries$total_injuries),]
```


```r
total_injuries_ranking[1:10,]
```

```
## # A tibble: 10 x 2
##    event_type        total_injuries
##    <chr>                      <dbl>
##  1 TORNADO                    91346
##  2 TSTM WIND                   6957
##  3 FLOOD                       6789
##  4 EXCESSIVE HEAT              6525
##  5 LIGHTNING                   5230
##  6 HEAT                        2100
##  7 ICE STORM                   1975
##  8 FLASH FLOOD                 1777
##  9 THUNDERSTORM WIND           1488
## 10 HAIL                        1361
```


```r
tornado_injuries_by_state <- storm_data_new %>% filter (event_type == 'TORNADO') %>% 
    group_by(state) %>% summarise(total_injuries = sum (injuries))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```



```r
tornado_injuries_by_state[order(-tornado_injuries_by_state$total_injuries),][1:5,]
```

```
## # A tibble: 5 x 2
##   state total_injuries
##   <chr>          <dbl>
## 1 TX              8207
## 2 AL              7929
## 3 MS              6244
## 4 AR              5116
## 5 OK              4829
```



As shown in the summary table above, tornado is again the worse offender when it comes to causing injuries. Texas is impacted the most by tornado caused injuries, followed by Alabama and Mississippi. 



### 4. Which types of events have the greatest economic consequences?

For this question, let's look at the prop_damage (property damage) and crop_damage variables. Both variables are measured in k (thousand), m (million), and b (billion). We therefore need to unify the values first before doing any grouping and calculation. 

Let's first change the mixed cases column to all lower cases. 


```r
storm_data_new$prop_damage_unit <- tolower(storm_data_new$prop_damage_unit)
storm_data_new$crop_damage_unit <- tolower(storm_data_new$crop_damage_unit)
```


Now let's add two new columns showing the prop_damage and crop_damage values all in thousands (k).



```r
storm_data_new <- storm_data_new %>%
    mutate(prop_damage_new = 
               ifelse(prop_damage_unit == 'm', prop_damage * 1000,
                      ifelse(prop_damage_unit == 'b', prop_damage * 1000000,
                             ifelse(prop_damage_unit == '', prop_damage/1000, 
                                    prop_damage))))
```



```r
storm_data_new <- storm_data_new %>%
    mutate(crop_damage_new = 
               ifelse(crop_damage_unit == 'm', crop_damage * 1000,
                      ifelse(crop_damage_unit == 'b', crop_damage * 1000000,
                             ifelse(crop_damage_unit == '', crop_damage/1000, 
                                    crop_damage))))
```



Now let's calculate the property damage values by event_type. 


**Types of events that caused the most property damage**



```r
total_prop_damage <- storm_data_new%>%
    group_by(event_type)%>%
    summarise(total_prop_damage = sum(prop_damage_new))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```


```r
total_prop_damage_ranking <- total_prop_damage[order(-total_prop_damage$total_prop_damage),]
```


Let's generate a table summarizing the ten types of event that have caused the most property damage. 



```r
total_prop_damage_ranking[1:10,]
```

```
## # A tibble: 10 x 2
##    event_type        total_prop_damage
##    <chr>                         <dbl>
##  1 FLOOD                    144657710.
##  2 HURRICANE/TYPHOON         69305840 
##  3 TORNADO                   56937456.
##  4 STORM SURGE               43323536 
##  5 FLASH FLOOD               16141162.
##  6 HAIL                      15732537.
##  7 HURRICANE                 11868319.
##  8 TROPICAL STORM             7703891.
##  9 WINTER STORM               6688498.
## 10 HIGH WIND                  5270081.
```

As shown above, flood has caused the most property damage, followed by hurricane/typhoon and tornado. 


**Types of events that caused most crop damage**


```r
total_crop_damage <- storm_data_new%>%
    group_by(event_type)%>%
    summarise(total_crop_damage = sum(crop_damage_new))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```


Let's find out which 10 types of events that have caused the most crop damage. 



```r
total_crop_damage_ranking <- total_crop_damage[order(-total_crop_damage$total_crop_damage),]

total_crop_damage_ranking[1:10,]
```

```
## # A tibble: 10 x 2
##    event_type        total_crop_damage
##    <chr>                         <dbl>
##  1 DROUGHT                   13972566 
##  2 FLOOD                      5661968.
##  3 RIVER FLOOD                5029459 
##  4 ICE STORM                  5022114.
##  5 HAIL                       3025974.
##  6 HURRICANE                  2741910 
##  7 HURRICANE/TYPHOON          2607873.
##  8 FLASH FLOOD                1421317.
##  9 EXTREME COLD               1292973 
## 10 FROST/FREEZE               1094086
```

As shown above, drought has the most impact on crops, followed by flood, river flood, and ice storm. 

### 5. Results 

The above analysis shows the tornado is the most harmful event to public health, causing the most number of fatalities and injuries overall. However, the situation varies by state and by year. Further investigation is needed if the readers are intereted in finding out what particular tornado is the most harmful and its characteristics. 

As far as the economy is concerned, flood and drought are the most harmful, causing the most property damage and crop damage respectively. Further investigation is needed is the readers is interested in finding out how this might vary from state and time. 



