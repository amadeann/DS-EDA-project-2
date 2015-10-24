source("load_data_set.R")

library(dplyr)

# Select only the sectors which contain a string 'Mobile - On-Road' and relate to 'Vehicles'

selectedSectors <- as.vector(sapply(SCC$EI.Sector,function(x) (length(grep("Mobile\\s\\-\\sOn\\-Road.*Vehicles",x))>0)))

plot1data <- NEI %>% 
    filter(SCC %in% SCC$SCC[selectedSectors],fips %in% c("24510","06037")) %>% 
    group_by(year, fips) %>% 
    summarise(Emissions = sum(Emissions)) 

plot1data <- as.data.frame(plot1data)

# Store values of emission from 1999 to variables
# Those values are base levels for the chart

baltimoreBase <- plot1data$Emissions[plot1data$year == 1999 & plot1data$fips == "24510"]
LABase <- plot1data$Emissions[plot1data$year == 1999 & plot1data$fips == "06037"]

# Change the emission values with indexes (base year: 1999)

plot1data$Emissions[plot1data$fips == "24510"] <- (plot1data$Emissions[plot1data$fips == "24510"]/baltimoreBase)*100
plot1data$Emissions[plot1data$fips == "06037"] <- (plot1data$Emissions[plot1data$fips == "06037"]/LABase)*100

plot1data <- xtabs(Emissions ~ fips + year, data = plot1data)

png(filename = "plot6.png")

# Plots the emissions relative to base year of 1999
barplot(
    plot1data,
    beside = TRUE,
    xlab = "Year",
    ylab = "Emissions of PM2.5 (Year 1999 = 100) ",
    ylim = c(0,140),
    main = "Relative changes in PM2.5 emissions from motor vehicles (base year 1999)",
    col = c("orangered3","green4"),
    cex.main=1.0
)

# add legend

legend("topright", pch = 15, col = c("orangered3","green4"), legend = c("LA County, CA", "Baltimore City, MD"))

dev.off()