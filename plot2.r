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
feb_data$Date <- weekdays(feb_data$Date)
feb_data$Global_active_power <- as.numeric(as.character(feb_data$Global_active_power))

plot(1:2880, feb_data$Global_active_power, 
     type = "l",
     xaxt = 'n',
     xlab = '',
     ylab = 'Global Active Power (kilowatts)') 
axis(1, at = c(1,1440,2880), labels = c("Thu","Fri","Sat"))

dev.copy(png, file = 'plot2.png')
dev.off()