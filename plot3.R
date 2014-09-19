#
# Using the dataset provided, this script produces a plot that attempts to address the following question:
# 
# _Of the four types of sources indicated by the `type` (point, nonpoint, onroad, nonroad) variable, which of these four
# sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from
# 1999–2008? Use the ggplot2 plotting system to make a plot answer this question._
#

# This, of course, assumes that the ggplot2 package has already been installed
library('ggplot2')

# Unzip the dataset, if it hasn't already been unzipped 
if (!is.element('summarySCC_PM25.rds', dir()) | !is.element('summarySCC_PM25.rds', dir())) {
    unzip('exdata-data-NEI_data.zip')
}

# Load the data, as suggested in the assignment description
NEI <- readRDS("summarySCC_PM25.rds")

# This inquiry concerns emissions from various sources in Baltimore City, Maryland over the four years for which data has been provided.
# Subset the Baltimore data
baltimore <- NEI[NEI$fips=='24510',]

# Summarize the total emissions for each source and convert to a data frame
summary <-tapply(baltimore$Emissions, list(baltimore$type, baltimore$year), sum)
summary <- as.data.frame(as.table(summary))

# Create the basic plot
g <- ggplot(summary, aes(Var2, Freq)) + geom_bar(stat='identity') + facet_wrap(~Var1) + geom_smooth(aes(group=1), method='lm', se=FALSE)

# Add some descriptive features
g <- g + ggtitle(expression('PM'[2.5]*' Emissions from various sources in Baltimore, MD (1999-2008)'))
g <- g + ylab(expression('Tons of PM'[2.5]))
g <- g + xlab('Years')
g <- g + annotate('text', x=3.8, y=1750, col='blue', label='Overall trend', size=4)

# Plot
png('plot3.png')
print(g)
dev.off()
