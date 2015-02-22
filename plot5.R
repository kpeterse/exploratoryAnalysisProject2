plot5 <- function(){
        # Load required libararies
        library(dplyr)
        library(ggplot2)
        
        # Read data into environment
        NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
        SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
        
        # Group data and summarize into new new data frame
        newSCC <- select(SCC, SCC, EI.Sector)
        newNEI <- select(NEI, year, fips, Emissions, SCC)
        newNEI <- filter(newNEI, fips == 24510)
        newSet <- left_join(newNEI, newSCC, by = "SCC")
        mobileGrep <- grep("Mobile -", newSet$EI.Sector)
        newSet <- newSet[mobileGrep, ]
        newSet <- group_by(newSet, year)
        newSet <- summarise(newSet, Emissions = sum(Emissions))
        barplot(newSet$Emissions, names.arg = newSet$year,
                col = "red", main = "Baltimore City: Mobile Emissions")
        dev.copy(png, 'plot5.png')
        dev.off()                
}