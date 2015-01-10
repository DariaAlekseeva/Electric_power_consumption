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
feb_data$Global_active_power <- as.numeric(as.character(feb_data$Global_active_power))

hist(feb_data$Global_active_power, 
     col = 'red', 
     xlab = 'Global Active Power (kilowatts)', 
     main = 'Global Active Power')

dev.copy(png, file = 'plot1.png')
dev.off()