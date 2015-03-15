## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
png("plot1.png")
totals <- group_by(NEI, year) %>% summarise("Total PM2.5 emission"=sum(Emissions))
plot(totals, type = "l", main = "US Totals")
dev.off()