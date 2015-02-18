# The Most Harmful Storm Events in US
Boris Shminke  
18.02.2015  

## Synopsis

In this report we use Strom Events data from National Weather Service to find events most harmful with respect to population health and events which have the greatest economic consequences.

## Data Acquisition

We download data if needed and read it from *bzip2*-file.
This operation is cached because it is quite time-consuming.


```r
bzfilename <- "repdata-data-StormData.csv.bz2"
if(!file.exists(bzfilename)) {
  download.file(
    "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2",
    bzfilename, "curl")
}

data <- read.csv(bzfile(bzfilename))
```

## Data Processing

Here we use `dplyr` package for simple data analysis.
We define harm to population health as total number of fatalities and injuries.
We define economic consequences as total damage to property and crops.


```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
## 
## The following object is masked from 'package:stats':
## 
##     filter
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
worst_h <- group_by(data, EVTYPE) %>% summarise(health=sum(FATALITIES)+sum(INJURIES)) %>% arrange(desc(health))
worst_h_str <- paste(head(worst_h)$EVTYPE, collapse = ", ")
worst_h_str
```

```
## [1] "TORNADO, EXCESSIVE HEAT, TSTM WIND, FLOOD, LIGHTNING, HEAT"
```

```r
worst_e <- group_by(data, EVTYPE) %>% summarise(economy=sum(PROPDMG)+sum(CROPDMG)) %>% arrange(desc(economy))
worst_e_str <- paste(head(worst_e)$EVTYPE, collapse = ", ")
worst_e_str
```

```
## [1] "TORNADO, FLASH FLOOD, TSTM WIND, HAIL, FLOOD, THUNDERSTORM WIND"
```

## Results

As we can see from data processing section, most harmful events with respect to population health are (from the most harmful to less): TORNADO, EXCESSIVE HEAT, TSTM WIND, FLOOD, LIGHTNING, HEAT.
And the following events have the greatest economic consequences  (from the most harmful to less): TORNADO, FLASH FLOOD, TSTM WIND, HAIL, FLOOD, THUNDERSTORM WIND.

We also provide two plots for better illustration of the results.


```r
  par(mar = c(10,4,4,2) + 0.1)
  barplot(head(worst_h)$health, names.arg = head(worst_h)$EVTYPE, las=3,
          main="Fatalities and injuries by event type")
```

![](ReproducibleResearch_files/figure-html/unnamed-chunk-3-1.png) 


```r
  par(mar = c(10,4,4,2) + 0.1)
  barplot(head(worst_e)$economy/1000000, names.arg = head(worst_e)$EVTYPE,
          las=3,
          main="Property and crop damage in millions of USD by event type")
```

![](ReproducibleResearch_files/figure-html/unnamed-chunk-4-1.png) 
