#
# Using the dataset provided, this script produces a plot that attempts to address the following question:
# 
# _Have total emissions from PM<sub>2.5</sub> decreased in the Baltimore City, Maryland (`fips == "24510"`) from 1999 to 2008? Use
# the base plotting system to make a plot answering this question._
#

# Unzip the dataset, if it hasn't already been unzipped 
if (!is.element('summarySCC_PM25.rds', dir()) | !is.element('summarySCC_PM25.rds', dir())) {
    unzip('exdata-data-NEI_data.zip')
}

# Load the data, as suggested in the assignment description
NEI <- readRDS("summarySCC_PM25.rds")

# This inquiry concerns total emissions in Baltimore City, Maryland over the four years for which data has been provided.
# Find the total emissions for each of these years
totalEmissions <- tapply(NEI$Emissions[NEI$fips=='24510'], NEI$year[NEI$fips=='24510'], sum)

# This will help clarify the overall trend in emissions levels
trend <- lm(totalEmissions~c(1:4))

# Plot the totalEmissions data (barplot)
png('plot2.png')
barplot(totalEmissions, main=expression('Total emissions of PM'[2.5]*' in Baltimore City, Maryland (1999 to 2008)'),
        xlab='Years', ylab=expression('Tons of PM'[2.5]), ylim=c(0,4000))
abline(trend, lwd=2, col='blue')
text(1.8,3150, labels='Overall trend', col='blue')
dev.off()
