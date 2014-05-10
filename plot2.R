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

## Creates the plot for datetime, Global_active_power
png("plot2.png", width=480, height=480)
with(DT, {
  plot(datetime, Global_active_power, type="n",
       xlab="", ylab="Global Active Power (killowatts)")
  lines(datetime, Global_active_power)})
dev.off()