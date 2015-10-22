source("load_data_set.R")

library(dplyr)

plot1data <- NEI %>% group_by(year) %>% summarise(Emissions = sum(Emissions))
# Plots the emissions in thousands of 1000 tones
barplot(
    plot1data$Emissions/1000, 
    names.arg = plot1data$year,
    xlab = "Year",
    ylab = "Emissions of PM2.5 (in thousand tons)",
    main = "Change in PM2.5 emissions"
    )
