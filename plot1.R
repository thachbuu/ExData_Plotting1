# LOADING DATA SOURCE
dataSource = "household_power_consumption.zip"

if (!file.exists(dataSource)) {
  download.file(
    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
    destfile = dataSource
  )
}


if (!file.exists("household_power_consumption.txt")) {
  unzip(dataSource)
}

# PREPARE DATA
original_data <- read.csv2("household_power_consumption.txt")
subset_data <-
  original_data[original_data$Date %in% c("1/2/2007", "2/2/2007"),]
subset_data$datetime <-
  strptime(paste(subset_data$Date, subset_data$Time, sep = " "),"%d/%m/%Y %H:%M:%S")
subset_data$Global_active_power <-
  as.numeric(as.character(subset_data$Global_active_power))
subset_data$Sub_metering_1 <-
  as.numeric(as.character(subset_data$Sub_metering_1))
subset_data$Sub_metering_2 <-
  as.numeric(as.character(subset_data$Sub_metering_2))
subset_data$Sub_metering_3 <-
  as.numeric(as.character(subset_data$Sub_metering_3))
# PLOT GLOBAL ACTIVE POWER
hist(
  subset_data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"
)

dev.copy(device = png, "plot1.png", width = 480, height = 480)
dev.off()