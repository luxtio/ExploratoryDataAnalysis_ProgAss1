plot3<-function()
{
        library(datasets)
        #plotDataDF<-getDataFrame()
        plotDF(getDataFrame())
        

}
plotDF<-function(dataFrameToPlot){
        # Setting param form more than one histogram
        # par (mfrow(2,2))
        plot_colors <-c("black", "red", "blue")
        png(filename="plot3.png")
        with(dataFrameToPlot, plot(V2 ,Sub_metering_1, type="l", ylab = "Energy sub metering", xlab="", col="black"))
        with(dataFrameToPlot, lines(V2 ,Sub_metering_2, col="red"))
        with(dataFrameToPlot, lines(V2 ,Sub_metering_3, col="blue"))
        legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=plot_colors, lwd=1 )
        
        #dev.copy(png, file="plot3.png")
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