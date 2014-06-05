# Load the code to get the data we are going to work on
source("dataget.R")

mkPlot2 <- function() {
  
  # Acquire data
  data <- getData()
  
  # Set background to transparent.
  # Reduce fonts -- my linux fonts are HUGE!
  par(bg = "transparent", cex = 0.8)
  
  # Try to set locale to english, to get the X-axis labels
  # to be the names of the days in English.
  # (Your system needs to support this to work fine,
  # else you will get a nice warning message :P )
  Sys.setlocale("LC_TIME", "en")
  
  # Create screen plot
  plot(data$DateTime, data$Global_active_power,
       typ = "l", main="", xlab = "", 
       ylab = "Global Active Power (kilowatts)")
  
  # In a more complex problem, there would be some code
  # to ask the user if he/she is satisfied with the current
  # plot, or wants to recalculate. If satisfied,
  # we would dump the plot to a PNG file in the following
  # way:

  # copy plot over to PNG device with specified parameters
  dev.copy(png, file = "plot2.png", width = 480, height = 480,
           units = "px")
    
  # close PNG device
  dev.off()
  
  # Show a nice label saying we are done :)
  "Plotting done"
  
}