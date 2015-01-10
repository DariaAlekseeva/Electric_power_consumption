URL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
path <- 'household_power_consumption.zip'
download.file(URL, path)
unzip('household_power_consumption.zip')

hhdata <- read.table("household_power_consumption.txt", 
                     header = TRUE, sep = ';')

hhdata$Date <- as.Date(strptime(hhdata$Date, format = '%d/%m/%Y'))
first <- as.Date(strptime("01/02/2007", format = '%d/%m/%Y'))
second <- as.Date(strptime("02/02/2007", format = '%d/%m/%Y'))
feb_data <- subset(hhdata, hhdata$Date == first | hhdata$Date == second)
feb_data$Sub_metering_1 <- as.numeric(as.character(feb_data$Sub_metering_1))
feb_data$Sub_metering_2 <- as.numeric(as.character(feb_data$Sub_metering_2))
feb_data$Sub_metering_3 <- as.numeric(as.character(feb_data$Sub_metering_3))

plot(1:2880, feb_data$Sub_metering_1, type = 'l',
     xaxt = 'n',
     xlab = '',
     ylab = 'Energy Sub metering') 
axis(1, at = c(1,1440,2880), labels = c("Thu","Fri","Sat"))
lines(1:2880, feb_data$Sub_metering_2, col = 'red') 
lines(1:2880, feb_data$Sub_metering_3, col = 'blue') 
legend('topright', names(feb_data)[7:9], lty = 1, col = c('black', 'red', 'blue'), cex = 0.75)

dev.copy(png, file = 'plot3.png')
dev.off()