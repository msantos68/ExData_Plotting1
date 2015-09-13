###############################################################
#
# Michelle Santos
# 9/13/2015
#
# Exploratory Data Analysis Coursera Course
# Course Project # 1
#
# Input Data: household_power_consumption - from UC Irvine Machine Learning Respository
#
# Purpose: 
# 1. Read in the data - perform some data manipulation on Date and Time variables
# 2. subset data to only Feb 1 - 2, 2007
# 3. Run some exploratory data plots
###############################################################

#Read in the dataset
temp <- read.table(file="household_power_consumption.txt",header=TRUE,sep=";",na.strings="?",colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

#Subset to only Feb 1 - 2, 2007
temp2 <- temp[temp$Date == "1/2/2007" | temp$Date == "2/2/2007",]
#Create Date/Time variable from the character variables
Date_Time <- paste(temp2$Date,temp2$Time)
Date_Time <- strptime(Date_Time,"%d/%m/%Y %H:%M:%S")
#Cbind back onto the original dataset and create Weekday variable for plot
temp2 <- cbind(temp2, Date_Time)               

#Plot 3 - Line Chart of the 3 SUb_Metering Reports by Date/Time
par(mfrow=c(1,1))
png("plot3.png")
with(temp2, plot(Date_Time, Sub_metering_1, type="l", xlab="",ylab="Energey Sub Metering"))
with(temp2, lines(Date_Time, Sub_metering_2, type="l", col="red"))
with(temp2, lines(Date_Time, Sub_metering_3, type="l", col="blue"))
legend("topright",lwd=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()