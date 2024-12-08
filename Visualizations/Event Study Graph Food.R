setwd("/Users/codyw/Desktop/RA Work")
install.packages("ggplot2")
library(ggplot2)
library(readxl)

####################################
###### Event Study Graph Food ######
####################################

data <- read_excel("eventstudy_graph_food.xlsx")

# Exporting to PDF in landscape orientation
pdf("eventstudy_food_graph.pdf", width = 11, height = 8.5)  # Width and height for landscape orientation

# Adjust margins to ensure axes are fully labeled
par(mar = c(5, 5, 2, 2) + 0.1)  # Adjusted inner margins (bottom, left, top, right)

# Plotting
plot(data$time, data$avg_treat_effect, ylim = c(min(data$lower_confidence_interval), max(data$upper_confidence_interval)), 
     xlim = c(-20, 16),
     xlab = 'Time', ylab = 'Treatment Effect', 
     pch = 16, col = ifelse(data$time < 0, "blue", "red"), cex = 1.5, lwd = 2, xaxt = "n")

# Adding custom x-axis with increments of 2
axis(1, at = seq(-20, 16, by = 2))

# Add error bars
arrows(data$time, data$lower_confidence_interval, data$time, data$upper_confidence_interval, angle = 90, code = 3, length = 0.1, col = ifelse(data$time < 0, "blue", "red"), lwd = 2)

# Add vertical line at x = -0.5
abline(v = -0.5, col = "red", lty = 2)

# Add horizontal line at y = 0
abline(h = 0, col = "black", lty = 1)

# Close the device to finalize the PDF
dev.off()



###############################
###### Event Study Graph ######
###############################

data1 <- read_excel("eventstudy_graph.xlsx")

# Exporting to PDF in landscape orientation
pdf("eventstudy_graph.pdf", width = 8.5, height = 7.5)  # Width and height for landscape orientation

# Adjust margins to ensure axes are fully labeled
par(mar = c(5, 5, 2, 2) + 0.1)  # Adjusted inner margins (bottom, left, top, right)

# Plotting
plot(data1$time, data1$avg_treat_effect, ylim = c(min(data1$lower_confidence_interval), max(data1$upper_confidence_interval)), 
     xlim = c(-20, 16),
     xlab = 'Time', ylab = 'Treatment Effect', 
     pch = 16, col = ifelse(data1$time < 0, "blue", "red"), cex = 1.5, lwd = 2, xaxt = "n")

# Adding custom x-axis with increments of 1
axis(1, at = seq(-20, 16, by = 1))

# Add error bars
arrows(data1$time, data1$lower_confidence_interval, data1$time, data1$upper_confidence_interval, angle = 90, code = 3, length = 0.1, col = ifelse(data1$time < 0, "blue", "red"), lwd = 2)

# Add vertical line at x = -0.5
abline(v = -0.5, col = "red", lty = 2)

# Add horizontal line at y = 0
abline(h = 0, col = "black", lty = 1)

# Close the device to finalize the PDF
dev.off()