library ("data.table")

setwd("C:/Users/Aline Ferreira/Documents/AprendendoR/Course4/W1")

# To read in data from file subsets data for specified dates

powerDT <- data.table::fread(input = "household_power_consumption.txt",
                             na.strings = "?")

# To avoid histogram from printing in scientific notation

powerDT[,Global_active_power := lapply(.SD, as.numeric), .SDcols= c("Global_active_power")]

# To change data column to date type

powerDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# To filter dates 2007-02-01 for 2007-02-02

powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# To set the format and size of the plot

png ("plot1.png", width =480, height=480)

# To plot 1
hist(powerDT [, Global_active_power], main = "Global Active Power",
              xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

# To save the graph in the directory as a png file and "plot.1" name
dev.off()
