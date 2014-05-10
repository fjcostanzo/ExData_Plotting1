## Reading the Data into R - Set working directory to the directory
## with the household_power_consumption.txt file in it. 
## This method uses the "sqldf" package. 
##install.packages("sqldf") before running the code.

require("sqldf") # Tells R to use the package
require("data.table")

## SQL code to subsetting the data set
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"

## Creates data.frame by reading the file in conjuction with the SQL query
myData <- read.csv.sql("household_power_consumption.txt",mySql, sep=";")

## Reads myData as a data.table then
## uses data table processes to add a new variable that combines
## the date and time.
DT <- as.data.table(myData)
DT[,datetime:= as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")]


## Creates four plots
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

## Plot of datetime, Global Active Power
with(DT, {
  plot(datetime, Global_active_power, type="n",
       xlab="", ylab="Global Active Power (killowatts)")
  lines(datetime, Global_active_power)})

## Plot of datetime, Voltage
with(DT, {
  plot(datetime, Voltage, type="n",
       xlab="datetime", ylab="Voltage")
  lines(datetime, Voltage)})

## Plot of datetime, the Sub_meterings
with(DT, {
  plot(datetime, Sub_metering_1, type="n",
       xlab="", ylab="Energy sub metering")
  lines(datetime, Sub_metering_1, col="Black")
  lines(datetime, Sub_metering_2, col="Red")
  lines(datetime, Sub_metering_3, col="Blue")
  legend("topright", lty=1, bty="n", col=c("Black", "Red", "Blue"), 
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))})

## Plot of datetime, Global Reactive Power
with(DT, {
  plot(datetime, Global_reactive_power, type="n",
       xlab="datetime", ylab="Global reactive power")
  lines(datetime, Global_reactive_power)})
dev.off()


