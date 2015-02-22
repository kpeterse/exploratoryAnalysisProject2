plot4 <- function(){
        # Load required libararies
        library(dplyr)
        library(ggplot2)
        
        # Read data into environment
        NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
        SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
        
        # Group data and summarize into new new data frame
        newSCC <- select(SCC, SCC, EI.Sector)
        newNEI <- select(NEI, year, Emissions, SCC)
        newSet <- left_join(newNEI, newSCC, by = "SCC")
        newSet <- group_by(newSet, year, EI.Sector)
        newSet <- summarise(newSet, Emissions = sum(Emissions))
        coalGrep <- c(grep("Coal", newSet$EI.Sector))
        newSet <- newSet[coalGrep, ]
        newSet <- summarise(newSet, Emissions = sum(Emissions))
        barplot(newSet$Emissions, names.arg = newSet$year,
                col = "red", main = "Coal Emissions")
        dev.copy(png, 'plot4.png')
        dev.off()             
}