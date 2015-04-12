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
png(filename="plot1.png",width = 480, height = 480)
# historgram plot for global active power
hist(as.numeric(temp$Global_active_power), col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
# close file
dev.off()

###########################CLEAR MEMORY##################################################################

# Clear everything from memory.
rm(list=ls(all=TRUE)) 
