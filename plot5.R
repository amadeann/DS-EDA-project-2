
source("load_data_set.R")

library(dplyr)

# Select only the sectors which contain a string 'Mobile - On-Road' and relate to 'Vehicles'

selectedSectors <- as.vector(sapply(SCC$EI.Sector,function(x) (length(grep("Mobile\\s\\-\\sOn\\-Road.*Vehicles",x))>0)))

plot1data <- NEI %>% 
    filter(SCC %in% SCC$SCC[selectedSectors], fips == "24510") %>% 
    group_by(year) %>% 
    summarise(Emissions = sum(Emissions))

png(filename = "plot5.png")

# Plots the emissions in thousands of 1000 tones
barplot(
    plot1data$Emissions/1000, 
    names.arg = plot1data$year,
    xlab = "Year",
    ylab = "Emissions of PM2.5 (in thousand tons)",
    main = "Change in PM2.5 emissions in Baltimore, MD from motor vehicles",
    cex.main=1.0
)

dev.off()