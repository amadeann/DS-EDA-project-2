source("load_data_set.R")

library(dplyr)

plot1data <- NEI %>% filter(fips == "24510", year %in% c(1999,2008)) %>% group_by(year) %>% summarise(Emissions = sum(Emissions))

png(filename = "plot2.png")

# Plots the emissions in thousands of 1000 tones
barplot(
    plot1data$Emissions/1000, 
    names.arg = plot1data$year,
    xlab = "Year",
    ylab = "Emissions of PM2.5 (in thousand tons)",
    main = "Change in PM2.5 emissions in Baltimore, MD"
)

dev.off()