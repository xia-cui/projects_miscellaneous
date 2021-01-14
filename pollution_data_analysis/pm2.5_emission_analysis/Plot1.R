## read the two files in R
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")

#Create a table showing the total emissions by year
library(dplyr)
total_by_year <- NEI%>%group_by(year)%>%summarise(total = sum(Emissions))

#creating a PNG file
png(filename = "plot1.png", width = 480, height = 480)

#plot the total emissions by year
plot(total_by_year$year, total_by_year$total, 
     xaxt = "n", main = "Total emissions by year", 
     xlab = "Years", ylab = "Total Emissions (in tons)", 
     pch = 19, col = "blue", ylim = c(1000000,8000000))
axis(1, at = total_by_year$year, labels = TRUE)

#fit a line to the four points showing a downward trend.
abline(lm(total ~ year, data = total_by_year), col = "red")
#close off device
dev.off()
