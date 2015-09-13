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

#Plot 1 - histogram of Global Active Power
# Use col to adjust color, xlab to add x-axis label, and main for the title
par(mfrow=c(1,1))
hist(temp2$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.copy(png, file="plot1.png")
dev.off()


#Plot 2 - line chart of Global Active Power by Date/Time
plot(temp2$Date_Time, temp2$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png")
dev.off()

#Plot 3 - Line Chart of the 3 SUb_Metering Reports by Date/Time
png("plot3.png")
with(temp2, plot(Date_Time, Sub_metering_1, type="l", xlab="",ylab="Energey Sub Metering"))
with(temp2, lines(Date_Time, Sub_metering_2, type="l", col="red"))
with(temp2, lines(Date_Time, Sub_metering_3, type="l", col="blue"))
legend("topright",lwd=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

#Plot 4 - this includes 4 plots on one image
png("plot4.png")
par(mfrow=c(2,2)) #Making plot 2 x 2
with(temp2, plot(Date_Time,Global_active_power, type="l",xlab="",ylab="Global Active Power"))
with(temp2, plot(Date_Time,Voltage,type="l",xlab="",ylab="Voltage"))
with(temp2, plot(Date_Time, Sub_metering_1, type="l",xlab="",ylab="Energy Sub Metering"))
with(temp2, lines(Date_Time, Sub_metering_2, type="l", col="red"))
with(temp2, lines(Date_Time, Sub_metering_3, type="l", col="blue"))
legend("topright",lwd=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
with(temp2, plot(Date_Time,Global_reactive_power,type="l",xlab="",ylab="Global Reactive Power"))
dev.off()

