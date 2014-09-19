#
# Using the dataset provided, this script produces a plot that attempts to address the following question:
# 
# _How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?_
#

# This, of course, assumes that the ggplot2 package has already been installed
library('ggplot2')

# Unzip the dataset, if it hasn't already been unzipped 
if (!is.element('summarySCC_PM25.rds', dir()) | !is.element('summarySCC_PM25.rds', dir())) {
    unzip('exdata-data-NEI_data.zip')
}

# Load the data, as suggested in the assignment description
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get all the SCC codes that contain the words 'Mobile Sources'. These are taken exclusively from 
# the SCC.Level.One column and include all vehicles (e.g., planes, trains, boats, and automobiles. I.e.,
# anything with a motor).
regex <- 'Mobile Sources'
relevant <- grepl(regex, SCC$SCC.Level.One)
sccCodes <- SCC[relevant, 'SCC']

# This inquiry concerns motor vehicle emissions originating in Baltimore City, MD for the four years for which data has been provided.
motorVehicles <- NEI[NEI$SCC %in% sccCodes & NEI$fips=='24510', ]
vehicleEmissions <- tapply(motorVehicles$Emissions, motorVehicles$year, sum)

# This will help clarify the overall trend in emissions levels
trend <- lm(vehicleEmissions ~ c(1:4))

# Plot
png('plot5.png')
barplot(vehicleEmissions, main=expression('Total motorized vehicle PM'[2.5]*' emissions in Baltimore, MD (1999-2008)'),
        xlab='Years', ylab=expression('Tons of PM'[2.5]), ylim=c(0,2000))
abline(trend, lwd=2, col='blue')
text(4.1, 1000, labels='Overall trend', col='blue')
dev.off()
