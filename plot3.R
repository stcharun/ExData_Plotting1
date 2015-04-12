#####################################LOAD LIBRARIES###########################################################

library(data.table)
library(dplyr)
library(lubridate)

#####################################READ DATA FILE###########################################################

# set working directory - This will get the folder where the R script is located.
setwd(dirname(parent.frame(2)$ofile))

data <- fread("household_power_consumption.txt", 
              sep=";", 
              header=TRUE,
              na.strings=c("NA","?"))

#####################################DATA SCRUBBING###########################################################

# get a subset of data with required dates
temp <- data %>% filter(Date %in% c("1/2/2007","2/2/2007"))

# Add date time column
temp$DateTime <- dmy_hms(paste(temp$Date, temp$Time))

#####################################PLOT####################################################################

# create a png file
png(filename="plot3.png",width = 480, height = 480)
# Sub meterings over Time
plot(temp$DateTime, 
     as.numeric(temp$Sub_metering_1), 
     type="l",
     xlab="",
     ylab="Energy sub metering") 
lines(temp$DateTime, 
      as.numeric(temp$Sub_metering_2),
      col="red")
lines(temp$DateTime, 
      as.numeric(temp$Sub_metering_3),
      col="blue")
legend("topright", # places a legend at the appropriate place 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), # puts text in the legend 
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5,2.5),col=c("black","red","blue"),# gives the legend lines
       cex=0.75) 
# close file
dev.off()

###########################CLEAR MEMORY##################################################################

# Clear everything from memory.
rm(list=ls(all=TRUE)) 
