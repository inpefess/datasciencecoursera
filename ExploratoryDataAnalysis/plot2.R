## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
png("plot2.png")
totals <- filter(NEI, fips == "24510") %>%
  group_by(year) %>% summarise("PM2.5 emission"=sum(Emissions))
plot(totals, type = "l", main = "Baltimore City Totals")
dev.off()