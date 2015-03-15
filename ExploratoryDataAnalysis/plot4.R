## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)
sccs <- filter(SCC, regexpr('(COAL.*COMB)|(COMB.*COAL)', toupper(SCC$Short.Name)) != -1) %>%
  select(SCC)
totals <- mutate(NEI, s=as.numeric(SCC)) %>%
  filter(s %in% sccs$SCC) %>%
  group_by(year) %>% summarise(Emission=sum(Emissions))
gg <- ggplot(totals, aes(year, Emission)) + geom_line() +
  labs(title = "US yearly PM2.5 emission from coal combustion")
png("plot4.png", width = 480, height = 480)
print(gg)
dev.off()