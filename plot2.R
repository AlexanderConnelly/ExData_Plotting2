##This plot/script is designed to answer the SECOND question regarding pollution data for the Exploratory Data Analysis Course:

##Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
##Use the base plotting system to make a plot answering this question.

##To do this we will first load the PM2.5 Data, then filter by fips == "24510
##then find the sum of PM2.5 emmissions collected using the data,
##Then we will construct a plot that shows over time the result we find in our analysis.

library(dplyr)

##Loading the data, RDS file, saved in the working directory:
NEI <- readRDS("summarySCC_PM25.rds")
#dplyr dataframe:
NEI<-tbl_df(NEI)

##Open PNG Device
png(filename='plot2.png')

##Use dplyr to find the sum emmisions for each year
Emissions.Year<-NEI %>% group_by(year) %>% filter(fips=="24510") %>% summarise(Sum_Emissions=sum(Emissions))
#Create plot with BASE R system:
plot(Emissions.Year$year,Emissions.Year$Sum_Emissions, main='Baltimore City Maryland: Total Emmissions From PM2.5 Vs. Time', ylab='Total PM2.5 Emissions (in Tons)',xlab='Year', type='l')

##Here we can see that PM2.5 Emissions have been decreasing steadily from 1999 - 2008 in Baltimore City, Maryland
##There was however a rise in emissions in 2005, but overall, emissions are down.

##Turn off PNG Device:
dev.off()
message('done')