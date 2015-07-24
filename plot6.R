##This plot/script is designed to answer the FOURTH question regarding pollution data for the Exploratory Data Analysis Course:

##Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in 
##Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

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
SCC.Onroad<-SCC$SCC[grep("On-Road", SCC$EI.Sector)]
##Filter by codes in the Vector SCC.Coal
NEI.Filter<-subset(NEI, SCC %in% SCC.Onroad)
#dplyr dataframe:
NEI.Filter<-tbl_df(NEI.Filter)

##Use dplyr to find the sum emmisions for each year
Emissions.Year<-NEI.Filter %>% group_by(year,fips)  %>% filter(fips=="24510" | fips=="06037") %>% summarise(Sum_Emissions=sum(Emissions))

#Create plot with ggplot2 system:
qplot(year,Sum_Emissions,data=Emissions.Year,geom=("line"),fill=fips,xlab="Year",ylab="Total PM2.5 Emissions (In Tons)",color=factor(fips),main="Total PM2.5 Emmissions From Motor Vehicles In Baltimore(24510) and Los Angeles(06037) Vs. Time")

#Save qplot as a PNG file:
ggsave(file="plot6.png")

##From This plot we can see that the PM2.5 Emissions from motor vehicles in Los Angeles are nearly 100 times greater than the same source of emissions in Baltimore.
message('done')