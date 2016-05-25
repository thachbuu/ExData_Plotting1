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

dt <- read.csv2("household_power_consumption.txt")
dt01_02 <- dt[dt$Date %in% c("1/2/2007", "2/2/2007"),]
dt01_02$Timestamp <-
  strptime(paste(dt01_02$Date, dt01_02$Time, sep = " "),"%d/%m/%Y %H:%M:%S")
dt01_02$Global_active_power <-
  as.numeric(dt01_02$Global_active_power)
dt01_02$Sub_metering_1 <- as.numeric(dt01_02$Sub_metering_1)
dt01_02$Sub_metering_2 <- as.numeric(dt01_02$Sub_metering_2)
dt01_02$Sub_metering_3 <- as.numeric(dt01_02$Sub_metering_3)

#plot 3
png("plot3.png", width = 480, height = 480)
plot(
  dt01_02$Timestamp, dt01_02$Sub_metering_1, type = "l", xlab = "", ylab = "Enery sub metering"
)
lines(dt01_02$Timestamp,dt01_02$Sub_metering_2,  col = "red")
lines(dt01_02$Timestamp, dt01_02$Sub_metering_3, col = "blue")
legend(
  "topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red", "blue"), lty = 1
)
dev.off()