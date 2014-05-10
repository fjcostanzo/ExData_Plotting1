## Reading the Data into R - Set working directory to the directory
## with the household_power_consumption.txt file in it. 
## This method uses the "sqldf" package. 
##install.packages("sqldf") before running the code.

require("sqldf") # Tells R to use the package

## SQL code to subset the data
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"

## Creates data.frame by reading the file in conjuction with the SQL query
myData <- read.csv.sql("household_power_consumption.txt",mySql, sep=";")

## Creates Histogram of Global_active_power frequency

png("plot1.png", width=480, height=480)
hist(myData$Global_active_power, 
     col="Red", xlab="Global Active Power (kilowats)", 
     main="Global Active Power")
dev.off()