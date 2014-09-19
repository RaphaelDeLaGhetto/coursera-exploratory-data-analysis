#
# Using the dataset provided, this script produces a plot that attempts to address the following question:
# 
# _Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles
# County, California (`fips == "06037"`). Which city has seen greater changes over time in motor vehicle emissions?_
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
motorVehicles <- NEI[NEI$SCC %in% sccCodes & (NEI$fips=='24510' | NEI$fips=='06037'), ]
# Change the fips codes to the names of their coresponding jurisdictions
motorVehicles$fips <- factor(motorVehicles$fips, levels=c('06037', '24510'), labels=c('Los Angeles County, CA', 'Baltimore City, MD'))
vehicleEmissions <-tapply(motorVehicles$Emissions, list(motorVehicles$fips, motorVehicles$year), sum)
vehicleEmissions <- as.data.frame(as.table(vehicleEmissions))

# Create the basic plot
g <- ggplot(vehicleEmissions, aes(Var2, Freq)) + geom_bar(stat='identity') + facet_wrap(~Var1) + geom_smooth(aes(group=1), method='lm', se=FALSE)

# Add some descriptive features
g <- g + ggtitle(expression('Motorized vehicle PM'[2.5]*' emissions: Baltimore and LA County (99-08)'))
g <- g + ylab(expression('Tons of PM'[2.5]))
g <- g + xlab('Years')
g <- g + annotate('text', x=3.8, y=15000, col='blue', label='Overall trend', size=4)

# Plot
png('plot6.png')
print(g)
dev.off()
