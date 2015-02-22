plot2 <- function(){
        # Load required libararies
        library(dplyr)
        
        # Read data into environment
        NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
        SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
        
        # Group data and summarize into new new data frame
        yearCity <- select(NEI, year, fips, Emissions)
        yearCity <- filter(yearCity, fips == 24510)
        byYear <- group_by(yearCity, year)
        annualData <- summarise(byYear, Emissions = sum(Emissions))
        annualData <- arrange(annualData, year)
        # Create the plot
        barplot(annualData$Emissions, names.arg = annualData$year,
                col = "red", main = "PM2.5: Baltimore City Maryland")
        dev.copy(png, 'plot2.png')
        dev.off()         
}