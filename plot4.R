plot4<-function()
{
        library(datasets)
        #plotDataDF<-getDataFrame()
        plotDF(getDataFrame())
        
        
}
plotDF<-function(dataFrameToPlot){
        # Setting param form more than one histogram
        plot_colors <-c("black", "red", "blue")
        png(filename="plot4.png")
        par (mfrow=c(2,2))
        
        # First plot (Global Active Power)
        with(dataFrameToPlot, plot(V2 ,Global_active_power,type="l", ylab = "Global Active Power", xlab=""))
        
        # Second plot (Voltage)
        with(dataFrameToPlot, plot(V2 ,Voltage, type="l", ylab = "Voltage", xlab="datetime"))
        
        
        # Third plot (Energy sub metering)
        with(dataFrameToPlot, plot(V2 ,Sub_metering_1, type="l", ylab = "Energy sub metering", xlab="", col="black"))
        with(dataFrameToPlot, lines(V2 ,Sub_metering_2, col="red"))
        with(dataFrameToPlot, lines(V2 ,Sub_metering_3, col="blue"))
        legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=plot_colors, lwd=1 )
        
        # Forth plot (Global_reactive_power)
        with(dataFrameToPlot, plot(V2 ,Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab="datetime"))
        
        
        #dev.copy(png, file="plot4.png")
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