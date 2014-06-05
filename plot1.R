# Load the code to get the data we are going to work on
source("dataget.R")

mkPlot1 <- function() {
  
  # Acquire data
  data <- getData()
  
  # Set background to transparent.
  # Reduce fonts -- my linux fonts are HUGE!
  par(bg = "transparent", cex = 0.8)
  
  # Create screen plot
  hist(data$Global_active_power, main="Global Active Power",
       xlab = "Global Active Power (kilowatts)",
       ylab = "Frequency", col = "red")
  
  # In a more complex problem, there would be some code
  # to ask the user if he/she is satisfied with the current
  # plot, or wants to recalculate. If satisfied,
  # we would dump the plot to a PNG file in the following
  # way:
  
  # copy plot over to PNG device with specified parameters
  dev.copy(png, file = "plot1.png", width = 480, height = 480,
           units = "px")
    
  # close PNG device
  dev.off()
  
  # Show a nice label saying we are done :)
  "Plotting done"
  
}