##This plot/script is designed to answer the FOURTH question regarding pollution data for the Exploratory Data Analysis Course:

##Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?


##To do this we will first load the Source Emissions data, and PM25 emissions data,
##find which SCC code coresponds to coal related sources,
##then find the sum of PM2.5 emmissions collected using the data,
##Then we will construct a plot that shows over time the result we find in our analysis.

library(dplyr)
library(ggplot2)


##Loading the data, RDS file, saved in the working directory:
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Select Codes in SCC codes that contain the word "Coal"
SCC.Coal<-SCC$SCC[grep("Coal", SCC$EI.Sector)]
##Filter by codes in the Vector SCC.Coal
NEI.Filter<-subset(NEI, SCC %in% SCC.Coal)
#dplyr dataframe:
NEI.Filter<-tbl_df(NEI.Filter)


##Use dplyr to find the sum emmisions for each year
Emissions.Year<-NEI.Filter %>% group_by(year)  %>% summarise(Sum_Emissions=sum(Emissions))
#Create plot with ggplot2 system:
qplot(year,Sum_Emissions,data=Emissions.Year,geom=("line"),xlab="Year",ylab="Total PM2.5 Emissions (In Tons)",main="Total PM2.5 Emmissions From Coal Related Sources Vs. Time")

#Save qplot as a PNG file:
ggsave(file="plot4.png")

##From This plot we can see that the PM2.5 Emissions have decreased substantially since 2005, 
##when they increased slightly during that period (2005).

message('done')