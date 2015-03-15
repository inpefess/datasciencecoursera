## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)
totals <- filter(NEI, fips == "24510") %>%
  group_by(type,year) %>% summarise(Emission=sum(Emissions))
gg <- ggplot(totals, aes(year, Emission)) +
  geom_line(aes(group=type, color=type)) +
  labs(title = "Baltimore City yearly PM2.5 emission by type")
png("plot3.png", width = 480, height = 480)
print(gg)
dev.off()