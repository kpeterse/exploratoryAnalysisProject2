plot6 <- function(){
        # Load required libararies
        library(dplyr)
        library(ggplot2)
        
        # Read data into environment
        NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
        SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
        
        # Group data and summarize into new new data frame
        newSCC <- select(SCC, SCC, EI.Sector)
        newNEI <- select(NEI, year, fips, Emissions, SCC)
        newGrep <- c(grep("24510", newNEI$fips), grep("06037", newNEI$fips))
        newNEI <- newNEI[newGrep, ]
        newSet <- left_join(newNEI, newSCC, by = "SCC")
        mobileGrep <- grep("Mobile -", newSet$EI.Sector)
        newSet <- newSet[mobileGrep, ]
        newSet <- transform(newSet, fips = factor(fips))        
        newSet <- group_by(newSet, year, fips)
        newSet <- summarise(newSet, Emissions = sum(Emissions))
        qplot(year, Emissions, data = newSet, color = fips)
        dev.copy(png, 'plot6.png')
        dev.off()          

}