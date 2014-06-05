# Load the code to get the data we are going to work on
source("dataget.R")

drawPlot <- function(data) {
  
  # Set background to transparent and set up
  # mult-plots (fill columns first).
  # Also set margins slightly smaller
  par(bg = "transparent", mfcol = c(2,2),
      mar =c(6,4,5,3), cex = 0.6)
  
  # Set locale to english, to get the X-axis labels
  # to be the names of the days in English.
  # (Your system needs to support this to work fine,
  # else you will get a nice warning message :P )
  Sys.setlocale("LC_TIME", "en")
  
  
  # Make 1st plot: like plot2
  # (just copied the code from there)
  plot(data$DateTime, data$Global_active_power,
       typ = "l", main="", xlab = "", 
       ylab = "Global Active Power")  
  
  
  
  # Make 2nd plot, like plot3 (same code, too)
  # to be put right under 1st
  # Create blank screen plot
  plot(data$DateTime, data$Sub_metering_1, 
       typ = "n", main="", xlab = "", 
       ylab = "Energy sub metering")
  
  # Add lines:
  lines(data$DateTime, data$Sub_metering_1, col = "black")
  lines(data$DateTime, data$Sub_metering_2, col = "red")
  lines(data$DateTime, data$Sub_metering_3, col = "blue")
  
  # Add legend -- first define details
  legendText <- c("Sub_metering_1", "Sub_metering_2",
                  "Sub_metering_3")
  
  legendColors <- c("black", "red", "blue")
  

  # Small change in this one: box line is transparent
  legend("topright", legend = legendText, col =legendColors,
         lty = 1, bty = "n")
  

  # Make 3rd plot: like the 1st one, and straight
  # to its right
  plot(data$DateTime, data$Voltage,
       typ = "l", main="", xlab = "datetime", 
       ylab = "Voltage")
  
  # Make last plot, similar to the previous one
  plot(data$DateTime, data$Global_reactive_power,
       typ = "l", main="", xlab = "datetime", 
       ylab = "Global_reactive_power", cex = 0.4)  
  
  # we could use this to check finalization
  invisible(TRUE)
}


mkPlot4<- function() {
  # Acquire data
  mydata <- getData()
  
  # make plot on screen
  drawPlot(mydata)
  
  # In a more complex problem, there would be some code
  # to ask the user if he/she is satisfied with the current
  # plot, or wants to recalculate. If satisfied,
  # we would produce the PNG.
  
  # This time we replot from scratch: copying with
  # dev.copy makes funny things to some object's positions.
  
  # open PNG device
  png(file = "plot4.png", width = 480, height = 480, units = "px")
  
  # replot
  drawPlot(mydata)
  
  # close PNG device
  dev.off()
  
  # Reset multi-plot
  par(mfcol = c(1,1))
  
  # Show a nice label saying we are done :)
  "Plotting done"  
}