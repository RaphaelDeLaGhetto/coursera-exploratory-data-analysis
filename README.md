coursera-exploratory-data-analysis
==================================

This is the second project in Coursera's Exploratory Data Analysis course. Its purpose is to 
visualize the data provided in an attempt to answer questions about fine particulate matter
emitted from various sources across US counties. These questions are outlined in the _plots_ 
sections below along with the plots produced.

# The data set

The data was compiled for this course from that available at the
[EPA National Emissions Inventory web site](http://www.epa.gov/ttn/chief/eiinformation.html). The years of
interest are 1999, 2002, 2005. It was originally obtained on 2014-9-16.


# Clone this repository

```
git clone https://github.com/RaphaelDeLaGhetto/coursera-exploratory-data-analysis.git
```

# Dependencies

Be sure to install the following in your `R` environment:

```
install.packages('ggplot2')
```

# Execute the scripts

For each of the scripts below, ensure you are in the project's working directory. From there you may either run

```
Rscript plotN.R
```

or source the script from within the R interpreter

```
R
> source('plotN.R')
```

Be sure to replace N with the desired plot number.

## plot1

_Have total emissions from PM<sub>2.5</sub> decreased in the United States from 1999 to 2008? Using the base plotting
system, make a plot showing the total PM<sub>2.5</sub> emission from all sources for each of the years 1999, 2002,
 2005, and 2008._

![plot1.png](https://raw.githubusercontent.com/RaphaelDeLaGhetto/coursera-exploratory-data-analysis/master/plot1.png)

## plot2

_Have total emissions from PM<sub>2.5</sub> decreased in the Baltimore City, Maryland (`fips == "24510"`) from 1999 to 2008? Use
the base plotting system to make a plot answering this question._

![plot2.png](https://raw.githubusercontent.com/RaphaelDeLaGhetto/coursera-exploratory-data-analysis/master/plot2.png)

## plot3

_Of the four types of sources indicated by the `type` (point, nonpoint, onroad, nonroad) variable, which of these four
sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from
1999–2008? Use the ggplot2 plotting system to make a plot answer this question._

![plot3.png](https://raw.githubusercontent.com/RaphaelDeLaGhetto/coursera-exploratory-data-analysis/master/plot3.png)

## plot4

_Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?_

![plot4.png](https://raw.githubusercontent.com/RaphaelDeLaGhetto/coursera-exploratory-data-analysis/master/plot4.png)

## plot5

_How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?_

![plot5.png](https://raw.githubusercontent.com/RaphaelDeLaGhetto/coursera-exploratory-data-analysis/master/plot5.png)

## plot6

_Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles
County, California (`fips == "06037"`). Which city has seen greater changes over time in motor vehicle emissions?_



