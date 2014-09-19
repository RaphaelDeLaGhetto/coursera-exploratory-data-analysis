#
# Using the dataset provided, this script produces a plot that attempts to address the following question:
# 
# _Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?_
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

# Get all the SCC codes that contain some combination of the words 'coal' and 'comb' (for 'combustion').
# It was determined, through trial and error, that the Short.Name, EI.Sector, and SCC.Level.Four columns
# meet the specified regex criteria.
regex <- '([Cc]oal.*[Cc]omb)|([Cc]omb.*[Cc]oal)'
relevant <- grepl(regex, SCC$Short.Name) || grepl(regex, SCC$EI.Sector) || grepl(regex, SCC$SCC.Level.Four)
sccCodes <- SCC[relevant, 'SCC']

# This inquiry concerns coal-fired emissions from across the United States for the four years for which data has been provided.
coalCombustion <- NEI[NEI$SCC %in% sccCodes, ]
coalEmissions <- tapply(coalCombustion$Emissions, coalCombustion$year, sum)

# This will help clarify the overall trend in emissions levels
# Note: the division by 1000 is to bring the trend in line with the expectation of 'kilotonage' in the barplot
trend <- lm(coalEmissions/1000 ~ c(1:4))

# Plot
png('plot4.png')
barplot(coalEmissions/1000, main=expression('Total coal-combustion emissions of PM'[2.5]*' in the US (1999 to 2008)'),
        xlab='Years', ylab=expression('Kilotons of PM'[2.5]), ylim=c(0,8000))
abline(trend, lwd=2, col='blue')
text(4.1, 6000, labels='Overall trend', col='blue')
dev.off()
