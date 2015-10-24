source("load_data_set.R")

library(dplyr)

plot1data <- NEI %>%
                filter(fips == "24510") %>% 
                mutate(type = replace(type,type == "NONPOINT", "nonpoint")) %>%
                mutate(type = replace(type,type == "POINT", "point")) %>%
                mutate(type = replace(type,type == "ON-ROAD", "onroad")) %>%
                mutate(type = replace(type,type == "NON-ROAD", "nonroad")) %>%
                mutate(year = as.character(year)) %>%
                group_by(year, type) %>%
                summarise(Emissions = sum(Emissions))

# Plots the emissions in thousands of 1000 tones

library(ggplot2)

png(filename = "plot3.png")

p <- ggplot(data = plot1data, aes(x = year, y = Emissions/1000))
p <- p + geom_bar(stat='identity')
p <- p + ggtitle("Change in PM2.5 emissions in Baltimore, MD by emission type")
p <- p + ylab("Emissions of PM2.5 (in thousand tons)")
p <- p + xlab("Year")
p <- p + facet_grid(type ~ ., scale='free_y')
p

dev.off()
