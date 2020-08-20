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

png ("plot4.png", width =480, height=480)

# To format the four plots into 2 rows and 2 columns

par(mfrow = c(2,2))

# plot 1

plot(powerDT[,DateTime], powerDT[,Global_active_power], 
     type = "l", xlab = "", ylab = "Global Active Power")

# plot 2

plot (powerDT[,DateTime], powerDT [, Voltage],
      type = "l", xlab = "datetime", ylab = "Voltage")

#plot 3

plot(powerDT[, DateTime], powerDT[, Sub_metering_1], 
     type = "l", xlab = "", ylab = "Energy sub metering")
lines (powerDT[, DateTime], powerDT[,Sub_metering_2], col = "red")
lines (powerDT[,DateTime], powerDT[,Sub_metering_3], col = "blue")

# and to include the legend
legend ("topright", col = c("black", "red", "blue"),
        c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lty = c(1,1), 
        bty = "n",
        cex = .5)

# plot 4

plot (powerDT[,DateTime], powerDT[,Global_reactive_power],
      type = "l", xlab = "datetime", ylab = "Global_reactive_power")

#To save the graph in the directory as a png file and "plot.4" name
dev.off()

