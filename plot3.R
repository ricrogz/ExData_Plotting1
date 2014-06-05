# multiplots and dev.copy seem not to work too well together,
# so, this time, I'll use a slightly different approach

# Load the code to get the data we are going to work on
source("dataget.R")

drawPlot3 <- function(data) {
  
  # Set background to transparent.
  # Reduce fonts -- my linux fonts are HUGE!
  # Set margin -- helps with text positioning
  par(bg = "transparent", cex = 0.8)
  
  # Try to set locale to english, to get the X-axis labels
  # to be the names of the days in English.
  # (Your system needs to support this to work fine,
  # else you will get a nice warning message :P )
  Sys.setlocale("LC_TIME", "en")
  
  # Create blank screen plot
  plot(data$DateTime, data$Sub_metering_1, 
       typ = "n", main="", xlab = "", 
       ylab = "Energy sub metering")
  
  # Add lines:
  lines(data$DateTime, data$Sub_metering_1, col = "black")
  lines(data$DateTime, data$Sub_metering_2, col = "red")
  lines(data$DateTime, data$Sub_metering_3, col = "blue")
  
  # Add legend
  legendText <- c("Sub_metering_1", "Sub_metering_2",
                  "Sub_metering_3")
  legendColors <- c("black", "red", "blue")
  legendTypes  <- c(1,1,1)
  legend("topright", legend = legendText, col =legendColors,
         lty = legendTypes)
  
  # we could use this to check finalization
  invisible(TRUE)
}


mkPlot3 <- function() {
  # Acquire data
  mydata <- getData()
  
  # make plot on screen
  drawPlot3(mydata)
  
  # In a more complex problem, there would be some code
  # to ask the user if he/she is satisfied with the current
  # plot, or wants to recalculate. If satisfied,
  # we would produce the PNG.
  
  # This time we replot from scratch: copying with
  # dev.copy makes funny things to some object's positions.
  
  # open PNG device
  png(file = "plot3.png", width = 480, height = 480, units = "px")
  
  # replot
  drawPlot(mydata)
  
  # close PNG device
  dev.off()
  
  # Show a nice label saying we are done :)
  "Plotting done"  
}
