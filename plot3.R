plot3 <- function(){
        # Load required libararies
        library(dplyr)
        library(ggplot2)
        
        # Read data into environment
        NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
        SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
        
        # Group data and summarize into new new data frame
        newNEI <- select(NEI, year, fips, type, Emissions)
        newNEI <- filter(newNEI, fips == 24510)
        newNEI <- transform(newNEI, type = factor(type))
        newNEI <- group_by(newNEI, year, type)
        newNEI <- summarise(newNEI, Emissions = sum(Emissions))
        qplot(year, Emissions, data = newNEI, color = type)
        dev.copy(png, 'plot3.png')
        dev.off()    
}