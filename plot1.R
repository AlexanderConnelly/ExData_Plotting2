##This plot is designed to answer the first question regarding pollution data for the Exploratory Data Analysis Course:

##Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
##make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

##To do this we will first load the PM2.5 Data, then find the sum of PM2.5 emmissions collected using the data,
##Then we will construct a plot that shows over time the result we find in our analysis.
library(dplyr)

##Loading the data, RDS file, saved in the working directory:
NEI <- readRDS("summarySCC_PM25.rds")
#dplyr dataframe:
NEI<-tbl_df(NEI)

##Open PNG Device
png(filename='plot1.png')

##Use dplyr to find the sum emmisions for each year
Emissions.Year<-NEI %>% group_by(year) %>% summarise(Sum_Emissions=sum(Emissions))
#Create plot with BASE R system:
plot(Emissions.Year$year,Emissions.Year$Sum_Emissions, main='Total Emmissions From PM2.5 Vs. Time', ylab='Total PM2.5 Emissions (in Tons)',xlab='Year', type='l')

##Here we can clearly see that PM2.5 Emissions have been decreasing steadily from 1999 - 2008.

##Turn off PNG Device:
dev.off()
message('done')