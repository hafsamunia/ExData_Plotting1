Setting working directory
setwd("~/R/Coursera/household_power_consumption")
#Reading, naming and subsetting power consumption data
power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subsetpower <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")
# transforming date and time
subsetpower$Date <- as.Date(subsetpower$Date, format="%d/%m/%Y")
subsetpower$Time <- strptime(subsetpower$Time, format="%H:%M:%S")
subsetpower[1:1440,"Time"] <- format(subsetpower[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subsetpower[1441:2880,"Time"] <- format(subsetpower[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

#plot with many graphs
par(mfrow=c(2,2))
# calling the basic plot functions
with(subsetpower,{
  plot(subsetpower$Time,as.numeric(as.character(subsetpower$Global_active_power)),type="l",xlab="",ylab="Global Active Power(kilowatts)")
  plot(subsetpower$Time,as.numeric(as.character(subsetpower$Voltage)),type="l",xlab="datetime",ylab="Voltage")
  plot(subsetpower$Time,subsetpower$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(subsetpower,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(subsetpower,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(subsetpower,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.6)
  plot(subsetpower$Time,as.numeric(as.character(subsetpower$Global_reactive_power)),type="l",xlab="datetime",ylab="Global Reactive Power")
         
})




#copying to png
dev.copy(png, filename="plot4.png")
dev.off()
