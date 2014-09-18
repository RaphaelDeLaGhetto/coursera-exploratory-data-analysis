#
# Using the dataset provided, this script produces a plot that attempts to address the following question:
# 
# _Have total emissions from PM<sub>2.5</sub> decreased in the United States from 1999 to 2008? Using the base plotting
# system, make a plot showing the total PM<sub>2.5</sub> emission from all sources for each of the years 1999, 2002,
# 2005, and 2008._
#

# Unzip the dataset, if it hasn't already been unzipped 
if (!is.element('summarySCC_PM25.rds', dir()) | !is.element('summarySCC_PM25.rds', dir())) {
    unzip('exdata-data-NEI_data.zip')
}

# Load the data, as suggested in the assignment description
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# This inquiry concerns total emissions over the four years for which data has been provided.
# Find the total emissions for each of these years
totalEmissions <- tapply(NEI$Emissions, NEI$year, sum)


# Plot the totalEmissions data (barplot)
png('plot1.png')
barplot(totalEmissions/1000, main=expression('Total emissions of PM'[2.5]*' in the United States from 1999 to 2008'), xlab='Years', ylab=expression('Kilotons of PM'[2.5]))
dev.off()
