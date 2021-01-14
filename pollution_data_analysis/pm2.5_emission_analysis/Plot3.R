## read the two files in R
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")

#Create a subset containing data from Baltimore City
library(dplyr)
baltimore <- subset(NEI, fips == "24510")
total_type_year <- baltimore%>%group_by(type, year)%>%summarise(total = sum(Emissions))

#creating a PNG file
png(filename = "plot3.png", width = 480, height = 480)

#plot the total emissions by year
p <- ggplot(total_type_year, aes(factor(year), total)) + geom_point()
p + facet_grid(rows = vars(type)) + 
    labs(title = "Total emissions in Baltimore by type", 
         x = "Year", y = "Total emission (in tons)") + 
    theme_bw()+
    theme(plot.title = element_text(face = "bold", hjust = 0.5))

#close off device
dev.off()
