library ("data.table")

setwd("C:/Users/Aline Ferreira/Documents/AprendendoR/Course4/W1")

# To read in data from file subsets data for specified dates

powerDT <- data.table::fread(input = "household_power_consumption.txt",
                             na.strings = "?")

# To avoid graph from printing in scientific notation

powerDT[,Global_active_power := lapply(.SD, as.numeric), .SDcols= c("Global_active_power")]

# To obtain a data format that allows being filtered and graphed by time of day

powerDT[, DateTime := as.POSIXct(paste (Date, Time), format ="%d/%m/%Y %H:%M:%S")] 


# To filter dates 2007-02-01 for 2007-02-02. adjusting by week day

powerDT <- powerDT[(DateTime >= "2007-02-01") & (DateTime < "2007-02-03")]

# To set the format and size of the plot

png ("plot3.png", width =480, height=480)

# To plot 3
plot(powerDT[, DateTime], powerDT[, Sub_metering_1], 
     type = "l", xlab = "", ylab = "Energy sub metering")
     lines (powerDT[, DateTime], powerDT[,Sub_metering_2], col = "red")
     lines (powerDT[,DateTime], powerDT[,Sub_metering_3], col = "blue")

# and to include the legend
legend ("topright", col = c("black", "red", "blue"),
        c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lty = c(1,1), lwd = c(1,1))
    
 #To save the graph in the directory as a png file and "plot.3" name
dev.off()

