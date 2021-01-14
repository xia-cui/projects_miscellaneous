## read the two files in R
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

#Locate sources that are motor vehicle related
library(dplyr)
scc_sub <- SCC%>%filter(grepl("On-Road", EI.Sector) & grepl("Mobile", EI.Sector))

#subseting NEI data to contain only motor vehicl related sources for Baltimore
NEI_sub <- subset(NEI, SCC %in% scc_sub$SCC)
baltimore <- subset(NEI_sub, fips =="24510")

#creating a table showing the total by year
total_emissions <- baltimore%>%group_by(year)%>%
    summarize(total = sum(Emissions))

#creating a PNG file
png(filename = "plot5.png", width = 480, height = 480)

#plot the total emissions by year
plot(total_emissions$year, total_emissions$total,
     xaxt = "n", main = "Total motor vehicle emissions in Baltimore",
     xlab = "Years", ylab = "Total Emissions (in tons)",
     pch = 19, col = "blue")

axis(1, at = total_emissions$year, labels = TRUE)
abline(lm(total ~ year, data = total_emissions), col = "red")

#plot shows an overall downward trend, with a sharp drop in 2008 from 2005

#close off device
dev.off()
