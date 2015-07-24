##This plot/script is designed to answer the THIRD question regarding pollution data for the Exploratory Data Analysis Course:

##Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
##Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

##To do this we will first load the PM2.5 Data, then filter by fips == "24510"
##group by year and type,
##then find the sum of PM2.5 emmissions collected using the data,
##Then we will construct a plot that shows over time the result we find in our analysis.

library(dplyr)
library(ggplot2)
##Loading the data, RDS file, saved in the working directory:
NEI <- readRDS("summarySCC_PM25.rds")
#dplyr dataframe:
NEI<-tbl_df(NEI)


##Use dplyr to find the sum emmisions for each year
Emissions.Year<-NEI %>% group_by(type,year) %>% filter(fips=="24510") %>% summarise(Sum_Emissions=sum(Emissions))
#Create plot with ggplot2 system:
qplot(year,Sum_Emissions,data=Emissions.Year,geom=("line"),fill=type,xlab="Year",ylab="Total PM2.5 Emissions (in Tons)",color=factor(type),main="Total PM2.5 Emmissions Vs. Time, Seperated by Pollutant Type")

##The output plot shows that the NONPOINT, ONROAD, and NON-ROAD lines have seen DECREASED PM2.5 emissions over time in Baltimore, however,
##During the year of 2005, the POINT type of pollution emissions INCREASED sharply, then dropped a bunch in 2008.
##NONROAD also increased very slightly in 2005, but an increase it was!

#Save qplot as a PNG file:
ggsave(file="plot3.png")
message('done')