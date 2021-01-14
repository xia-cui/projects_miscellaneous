## read the two files in R
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

#Locate sources that are motor vehicle related
library(dplyr)
scc_sub <- SCC%>%filter(grepl("On-Road", EI.Sector) & grepl("Mobile", EI.Sector))

#subseting NEI data to contain only motor vehicle related sources 
#for Baltimore and LA. 
NEI_sub <- subset(NEI, SCC %in% scc_sub$SCC)
baltimore_la <- subset(NEI_sub, fips == "24510" | fips == "06037")

#creating a table showing the total by year for both regions
total_emissions <- baltimore_la%>%group_by(fips, year)%>%
    summarise(total = sum(Emissions))

#creating a PNG file
png(filename = "plot6.png", width = 480, height = 480)

#plot the total emissions by year

total_emissions$fips<- factor(total_emissions$fips, levels = c("06037", 24510), 
                              labels = c("Baltimore City", "Los Angeles County"))

plot <- ggplot(total_emissions, aes(factor(year), total, fill = fips))

plot + geom_bar(stat = "identity", position = "dodge") + 
    labs(title = "Total motor vehicle related emissions", 
         x = "Year", y = "Total emissions (in tons)") + 
    theme(plot.title = element_text(face = "bold", hjust = 0.5), 
          legend.title = element_blank(), legend.position = "bottom")

#plot shows an overall downward trend for the Baltimore City, 
#an an overall upward trend for LA. 

#close off device
dev.off()
