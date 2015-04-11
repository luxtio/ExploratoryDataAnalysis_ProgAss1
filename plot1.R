plot1<-function()
{
        library(datasets)
        plotDataDF<-getDataFrame()
        png(filename="plot1.png")
        with(plotDataDF, hist(Global_active_power, xlab = "Global Active Power (kw)", col="red", main="Global Active Power"))
        #dev.copy(png, file="plot1.png")
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
        finalDT <- cbind(finalDT[, 1:2, with=FALSE], finalDT[, lapply(.SD[, 3:9, with=FALSE], as.numeric)])
        
        finalDF<-as.data.frame( finalDT)
        

        
        # return filtered DataFrame
        finalDF
}