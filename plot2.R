plot2<-function()
{
        library(datasets)
        plotDataDF<-getDataFrame()
        png(filename="plot2.png")
        with(plotDataDF, plot(V2 ,Global_active_power,type="l", ylab = "Global Active Power (kilowatts)", xlab=""))
        #dev.copy(png, file="plot2.png")
        dev.off()
        
}

getDataFrame<-function ()
{
        library(data.table)
        # Read the whole file
        # quizDF<-read.table ("./household_power_consumption.txt") 
        quizDT<-fread ("./household_power_consumption.txt", sep=";")
        
        
        # Filter only 1 and 2 February 2007
        finalDT<-quizDT[Date %in% c("1/2/2007","2/2/2007")]
        
        # force all numeric field to be numeric
        # finalDT <- cbind(finalDT[, 1:2, with=FALSE], finalDT[, lapply(.SD[, 3:9, with=FALSE], as.numeric)])
        finalDT2 <- cbind(as.Date(unlist(finalDT[, 1, with=FALSE]), "%d/%m/%Y"),
                          strptime(paste(unlist(finalDT[, 1, with=FALSE]), unlist(finalDT[, 2, with=FALSE])), "%d/%m/%Y %H:%M:%S"), 
                          finalDT[, lapply(.SD[, 3:9, with=FALSE], as.numeric)])
                         
                         
        
        finalDF<-as.data.frame( finalDT2)
        
        
        
        # return filtered DataFrame
        finalDF
}