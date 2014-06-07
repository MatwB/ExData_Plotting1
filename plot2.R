

readEPC <- function() {							#this function reads the txt file and creates the dataframe
dfEPClocal <- NULL
filename <- file("./household_power_consumption.txt")
rows= read.table(filename,header= TRUE,sep=";", nrows = 5)		#read the first 5 rows, to get the classes
classes = sapply(rows,class)
library(sqldf)								#library sqldf is required; if not installed,  install.packages("sqldf")
filename <- file("./household_power_consumption.txt")
dfEPClocal <- sqldf("select * from filename where Date in('1/2/2007' ,'2/2/2007')  ",	  #read the dataset, only the dates 2007-02-01 and 2007-02-02, as suggested
	dbname=tempfile(),
	file.format=list(header=T,sep=";",
	row.names=F, colClasses = classes))
dfEPClocal$DateTime <- as.POSIXct(strptime(paste(dfEPClocal$Date,dfEPClocal$Time), "%d/%m/%Y %H:%M:%S"))	#create a new field, DateTime
dfEPC <<- dfEPClocal							#copy the local dataframe to the global dataframe
sqldf()
}


if(!exists("dfEPC"))    readEPC()	#if the database exists and is not null I don't read it again, for time saving
if(is.null(dfEPC))	readEPC()



#plot2 ---------------------------------------------------------------------------
png(filename = "plot2.png",width = 480, height = 480, units = "px",bg = "transparent")  #transparent o white
plot(dfEPC$DateTime,dfEPC$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()













