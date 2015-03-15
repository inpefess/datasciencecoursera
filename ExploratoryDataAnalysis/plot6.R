## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)
sccs <- filter(SCC, regexpr('(MOTOR)|(VEHICLE)', toupper(SCC$Short.Name)) != -1) %>%
  select(SCC)
totals <- mutate(NEI, s=as.numeric(SCC)) %>%
  filter(s %in% sccs$SCC & fips %in% c("24510", "06037")) %>%
  mutate(county = ifelse(fips==24510,"Baltimore City, Mariland","Los Angeles County, California")) %>%
  group_by(year, county) %>% summarise(Emission=sum(Emissions))
  
gg <- ggplot(totals, aes(year, Emission)) +
  geom_line(aes(group=county, color=county)) +
  labs(title = "Comparative yearly PM2.5 emission from motor vehicle")
png("plot6.png", width = 480, height = 480)
print(gg)
dev.off()