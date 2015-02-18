plot1 <- function(){
        # Load required libararies
        library(dplyr)
        
        # Read data into environment
        NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
        SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
        
        # Group data and summarize into new new data frame
        byYear <- group_by(NEI, year)
        annualData <- summarise(byYear, sum(Emissions))
        colnames(annualData) <- c("year", "Emissions")
        annualData <- arrange(annualData, year)
        # Create the plot
        barplot(annualData$Emissions, names.arg = annualData$year,
                col = "red", main = "Pollutant Levels")
        dev.copy(png, 'plot1.png')
        dev.off() 
}