## read the two files in R
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

#Locate sources that are coal combustion related
library(dplyr)
scc_sub <- SCC%>%filter(grepl("Coal", EI.Sector) & grepl("Comb", EI.Sector))

#subseting NEI data to contain only coal combustion related sources
NEI_sub <- subset(NEI, SCC %in% scc_sub$SCC)

#creating a table showing the total by year
total_emissions <- NEI_sub%>%group_by(year)%>%
    summarize(total = sum(Emissions))

#creating a PNG file
png(filename = "plot4.png", width = 480, height = 480)

#plot the total emissions by year
plot(total_emissions$year, total_emissions$total,
     xaxt = "n", main = "Total coal combustion related emissions",
     xlab = "Years", ylab = "Total Emissions (in tons)",
     pch = 19, col = "blue", ylim = c(300000, 600000))

axis(1, at = total_emissions$year, labels = TRUE)
abline(lm(total ~ year, data = total_emissions), col = "red")

#plot shows an overall downward trend, 
#despite a slight increase in 2005 from 2002

#close off device
dev.off()
