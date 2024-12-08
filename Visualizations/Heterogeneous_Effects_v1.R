setwd("/Users/codyw/Desktop/RA Work")
library(readxl)

#########################################
###### Responded - Acceptance Rate ######
#########################################

data <- read_excel("Responded_Acceptance_Rate.xlsx")

time_black <- data$value[data$black == 1] - ifelse(data$value[data$black == 1] < 6, 0.2, 0.1)
coefficients_black <- data$coefficient[data$black == 1]
stderr_black <- data$standard_error[data$black == 1]

time_asian <- data$value[data$asian == 1] + ifelse(data$value[data$asian == 1] < 6, 0, 0)
coefficients_asian <- data$coefficient[data$asian == 1]
stderr_asian <- data$standard_error[data$asian == 1]

time_asian_white <- data$value[data$asian_white == 1] + ifelse(data$value[data$asian_white == 1] < 6, 0.2, 0.1)
coefficients_asian_white <- data$coefficient[data$asian_white == 1]
stderr_asian_white <- data$standard_error[data$asian_white == 1]

time_hispanic <- data$value[data$hispanic == 1] + ifelse(data$value[data$hispanic == 1] < 6, 0.4, 0.2)
coefficients_hispanic <- data$coefficient[data$hispanic == 1]
stderr_hispanic <- data$standard_error[data$hispanic == 1]

# Save current graphical parameters
opar <- par(no.readonly = TRUE)

# Change the margins of the plot (the first is the bottom margin)
par(mar = c(8, 4.1, 4.1, 2.1))

# Create PDF
pdf("responded_accaptance_plot.pdf", width = 14, height = 8.5)

# Plotting
plot(time_black, coefficients_black, ylim = c(-0.15, 0.05), xlim = c(1, 10),
     xlab = 'Percentage of Sample', ylab = 'Marginal Effects', 
     pch = 16, type = "p", col = "blue", xaxt = "n", cex = 1.5, lwd = 2)

# Add x-axis with custom ticks and labels in percentiles
axis(1, at = 1:10, labels = paste(seq(5, 50, by = 5), "%", sep = ""))

# Add error bars for the black group
arrows(time_black, coefficients_black - stderr_black, time_black, coefficients_black + stderr_black, angle = 90, code = 3, length = 0.1, col = "blue", lwd = 2)

# Add the asian group
points(time_asian, coefficients_asian, pch = 17, type = "p", col = "red", cex = 1.5, lwd = 2)
arrows(time_asian, coefficients_asian - stderr_asian, time_asian, coefficients_asian + stderr_asian, angle = 90, code = 3, length = 0.1, col = "red", lwd = 2)

# Add the asian_white group
points(time_asian_white, coefficients_asian_white, pch = 18, type = "p", col = "forestgreen", cex = 1.5, lwd = 2)
arrows(time_asian_white, coefficients_asian_white - stderr_asian_white, time_asian_white, coefficients_asian_white + stderr_asian_white, angle = 90, code = 3, length = 0.1, col = "forestgreen", lwd = 2)

# Add the hispanic group
points(time_hispanic, coefficients_hispanic, pch = 15, type = "p", col = "gold", cex = 1.5, lwd = 2)
arrows(time_hispanic, coefficients_hispanic - stderr_hispanic, time_hispanic, coefficients_hispanic + stderr_hispanic, angle = 90, code = 3, length = 0.1, col = "gold3", lwd = 2)

# Add red line at y=0
abline(h = 0, col = "red", lty = 2)

# Add legend outside the graph at the bottom
legend(x = 1.25, y = -0.225, legend = c("Black", "Asian", "Hispanic", "Asian with White First Names"),
       pch = c(16, 17, 15, 18), col = c("blue", "red", "gold", "forestgreen"), pt.cex = 1.5, cex = 1.2, ncol = 4, bty = "n", xpd = TRUE, horiz = FALSE, inset = c(-0.1, -0.1), text.width = c(1, .75, 1.1, 0.9))

# Close PDF file
dev.off()

# Back to the default graphical parameters
par(opar)



##############################################
###### Effective Rejection - Acceptance ######
##############################################

data <- read_excel("Effective_rejection_Acceptanc.xlsx")

time_black <- data$value[data$black == 1] - ifelse(data$value[data$black == 1] < 6, 0.2, 0.1)
coefficients_black <- data$coefficient[data$black == 1]
stderr_black <- data$standard_error[data$black == 1]

time_asian <- data$value[data$asian == 1] + ifelse(data$value[data$asian == 1] < 6, 0, 0)
coefficients_asian <- data$coefficient[data$asian == 1]
stderr_asian <- data$standard_error[data$asian == 1]

time_asian_white <- data$value[data$asian_white == 1] + ifelse(data$value[data$asian_white == 1] < 6, 0.2, 0.1)
coefficients_asian_white <- data$coefficient[data$asian_white == 1]
stderr_asian_white <- data$standard_error[data$asian_white == 1]

time_hispanic <- data$value[data$hispanic == 1] + ifelse(data$value[data$hispanic == 1] < 6, 0.4, 0.2)
coefficients_hispanic <- data$coefficient[data$hispanic == 1]
stderr_hispanic <- data$standard_error[data$hispanic == 1]

# Save current graphical parameters
opar <- par(no.readonly = TRUE)

# Change the margins of the plot (the first is the bottom margin)
par(mar = c(8, 4.1, 4.1, 2.1))

# Create PDF
pdf("rejection_accaptance_plot.pdf", width = 14, height = 8.5)

# Plotting
plot(time_black, coefficients_black, ylim = c(-0.05, 0.15), xlim = c(1, 10),
     xlab = 'Percentage of Sample', ylab = 'Marginal Effects', 
     pch = 16, type = "p", col = "blue", xaxt = "n", cex = 1.5, lwd = 2)

# Add x-axis with custom ticks and labels in percentiles
axis(1, at = 1:10, labels = paste(seq(5, 50, by = 5), "%", sep = ""))

# Add error bars for the black group
arrows(time_black, coefficients_black - stderr_black, time_black, coefficients_black + stderr_black, angle = 90, code = 3, length = 0.1, col = "blue", lwd = 2)

# Add the asian group
points(time_asian, coefficients_asian, pch = 17, type = "p", col = "red", cex = 1.5, lwd = 2)
arrows(time_asian, coefficients_asian - stderr_asian, time_asian, coefficients_asian + stderr_asian, angle = 90, code = 3, length = 0.1, col = "red", lwd = 2)

# Add the asian_white group
points(time_asian_white, coefficients_asian_white, pch = 18, type = "p", col = "forestgreen", cex = 1.5, lwd = 2)
arrows(time_asian_white, coefficients_asian_white - stderr_asian_white, time_asian_white, coefficients_asian_white + stderr_asian_white, angle = 90, code = 3, length = 0.1, col = "forestgreen", lwd = 2)

# Add the hispanic group
points(time_hispanic, coefficients_hispanic, pch = 15, type = "p", col = "gold", cex = 1.5, lwd = 2)
arrows(time_hispanic, coefficients_hispanic - stderr_hispanic, time_hispanic, coefficients_hispanic + stderr_hispanic, angle = 90, code = 3, length = 0.1, col = "gold3", lwd = 2)

# Add red line at y=0
abline(h = 0, col = "red", lty = 2)

# Add legend outside the graph at the bottom
legend(x = 1.25, y = -0.125, legend = c("Black", "Asian", "Hispanic", "Asian with White First Names"),
       pch = c(16, 17, 15, 18), col = c("blue", "red", "gold", "forestgreen"), pt.cex = 1.5, cex = 1.2, ncol = 4, bty = "n", xpd = TRUE, horiz = FALSE, inset = c(-0.1, -0.1), text.width = c(1, .75, 1.1, 0.9))

# Close PDF file
dev.off()

# Back to the default graphical parameters
par(opar)



###########################################
###### Gave Waiver - Acceptance Rate ######
###########################################

data <- read_excel("Gavewaiver_Acceptance_Rate.xlsx")

time_black <- data$value[data$black == 1] - ifelse(data$value[data$black == 1] < 6, 0.2, 0.1)
coefficients_black <- data$coefficient[data$black == 1]
stderr_black <- data$standard_error[data$black == 1]

time_asian <- data$value[data$asian == 1] + ifelse(data$value[data$asian == 1] < 6, 0, 0)
coefficients_asian <- data$coefficient[data$asian == 1]
stderr_asian <- data$standard_error[data$asian == 1]

time_asian_white <- data$value[data$asian_white == 1] + ifelse(data$value[data$asian_white == 1] < 6, 0.2, 0.1)
coefficients_asian_white <- data$coefficient[data$asian_white == 1]
stderr_asian_white <- data$standard_error[data$asian_white == 1]

time_hispanic <- data$value[data$hispanic == 1] + ifelse(data$value[data$hispanic == 1] < 6, 0.4, 0.2)
coefficients_hispanic <- data$coefficient[data$hispanic == 1]
stderr_hispanic <- data$standard_error[data$hispanic == 1]

# Save current graphical parameters
opar <- par(no.readonly = TRUE)

# Change the margins of the plot (the first is the bottom margin)
par(mar = c(8, 4.1, 4.1, 2.1))

# Create PDF
pdf("waiver_accaptance_plot.pdf", width = 14, height = 8.5)

# Plotting
plot(time_black, coefficients_black, ylim = c(-0.25, 0.15), xlim = c(1, 11),
     xlab = 'Percentage of Sample', ylab = 'Marginal Effects', 
     pch = 16, type = "p", col = "blue", xaxt = "n", cex = 1.5, lwd = 2)

# Add x-axis with custom ticks and labels in percentiles
axis(1, at = seq(1, 11, by = 1), labels = paste(seq(5, 55, by = 5), "%", sep = ""))

# Add error bars for the black group
arrows(time_black, coefficients_black - stderr_black, time_black, coefficients_black + stderr_black, angle = 90, code = 3, length = 0.1, col = "blue", lwd = 2)

# Add the asian group
points(time_asian, coefficients_asian, pch = 17, type = "p", col = "red", cex = 1.5, lwd = 2)
arrows(time_asian, coefficients_asian - stderr_asian, time_asian, coefficients_asian + stderr_asian, angle = 90, code = 3, length = 0.1, col = "red", lwd = 2)

# Add the asian_white group
points(time_asian_white, coefficients_asian_white, pch = 18, type = "p", col = "forestgreen", cex = 1.5, lwd = 2)
arrows(time_asian_white, coefficients_asian_white - stderr_asian_white, time_asian_white, coefficients_asian_white + stderr_asian_white, angle = 90, code = 3, length = 0.1, col = "forestgreen", lwd = 2)

# Add the hispanic group
points(time_hispanic, coefficients_hispanic, pch = 15, type = "p", col = "gold", cex = 1.5, lwd = 2)
arrows(time_hispanic, coefficients_hispanic - stderr_hispanic, time_hispanic, coefficients_hispanic + stderr_hispanic, angle = 90, code = 3, length = 0.1, col = "gold3", lwd = 2)

# Add red line at y=0
abline(h = 0, col = "red", lty = 2)

# Add legend outside the graph at the bottom
legend(x = 1.25, y = -0.4, legend = c("Black", "Asian", "Hispanic", "Asian with White First Names"),
       pch = c(16, 17, 15, 18), col = c("blue", "red", "gold", "forestgreen"), pt.cex = 1.5, cex = 1.2, ncol = 4, bty = "n", xpd = TRUE, horiz = FALSE, inset = c(-0.1, -0.1), text.width = c(1, .75, 1.1, 0.9))

# Close PDF file
dev.off()

# Back to the default graphical parameters
par(opar)



#####################################
###### Responded - Endowment 1 ######
#####################################

data <- read_excel("Responded_Endowment.xlsx")

time_black <- data$value[data$black == 1] - ifelse(data$value[data$black == 1] < 6, 0.2, 0.1)
coefficients_black <- data$coefficient[data$black == 1]
stderr_black <- data$standard_error[data$black == 1]

time_asian <- data$value[data$asian == 1] + ifelse(data$value[data$asian == 1] < 6, 0, 0)
coefficients_asian <- data$coefficient[data$asian == 1]
stderr_asian <- data$standard_error[data$asian == 1]

time_asian_white <- data$value[data$asian_white == 1] + ifelse(data$value[data$asian_white == 1] < 6, 0.2, 0.1)
coefficients_asian_white <- data$coefficient[data$asian_white == 1]
stderr_asian_white <- data$standard_error[data$asian_white == 1]

time_hispanic <- data$value[data$hispanic == 1] + ifelse(data$value[data$hispanic == 1] < 6, 0.4, 0.2)
coefficients_hispanic <- data$coefficient[data$hispanic == 1]
stderr_hispanic <- data$standard_error[data$hispanic == 1]

# Save current graphical parameters
opar <- par(no.readonly = TRUE)

# Change the margins of the plot (the first is the bottom margin)
par(mar = c(8, 4.1, 4.1, 2.1))

# Create PDF
pdf("responded_endowment_plot.pdf", width = 14, height = 8.5)

# Plotting
plot(time_black, coefficients_black, ylim = c(-0.15, 0.05), xlim = c(1, 20),
     xlab = 'Quantile', ylab = 'Marginal Effects', 
     pch = 16, type = "p", col = "blue", xaxt = "n", cex = 1.5, lwd = 2)

# Add x-axis with custom ticks and labels in percentiles
axis(1, at = seq(1, 20, by = 1), labels = paste(seq(5, 100, by = 5), "%", sep = ""))

# Add error bars for the black group
arrows(time_black, coefficients_black - stderr_black, time_black, coefficients_black + stderr_black, angle = 90, code = 3, length = 0.1, col = "blue", lwd = 2)

# Add the asian group
points(time_asian, coefficients_asian, pch = 17, type = "p", col = "red", cex = 1.5, lwd = 2)
arrows(time_asian, coefficients_asian - stderr_asian, time_asian, coefficients_asian + stderr_asian, angle = 90, code = 3, length = 0.1, col = "red", lwd = 2)

# Add the asian_white group
points(time_asian_white, coefficients_asian_white, pch = 18, type = "p", col = "forestgreen", cex = 1.5, lwd = 2)
arrows(time_asian_white, coefficients_asian_white - stderr_asian_white, time_asian_white, coefficients_asian_white + stderr_asian_white, angle = 90, code = 3, length = 0.1, col = "forestgreen", lwd = 2)

# Add the hispanic group
points(time_hispanic, coefficients_hispanic, pch = 15, type = "p", col = "gold", cex = 1.5, lwd = 2)
arrows(time_hispanic, coefficients_hispanic - stderr_hispanic, time_hispanic, coefficients_hispanic + stderr_hispanic, angle = 90, code = 3, length = 0.1, col = "gold3", lwd = 2)

# Add red line at y=0
abline(h = 0, col = "red", lty = 2)

# Add legend outside the graph at the bottom
legend(x = 1, y =-0.225 , legend = c("Black", "Asian", "Hispanic", "Asian with White First Names"),
       pch = c(16, 17, 15, 18), col = c("blue", "red", "gold", "forestgreen"), pt.cex = 1.5, cex = 1.2, ncol = 4, bty = "n", xpd = TRUE, horiz = FALSE, inset = c(-0.1, -0.1), text.width = c(1.5, 1.5, 2, 0.9))

# Close PDF file
dev.off()

# Back to the default graphical parameters
par(opar)



###############################################
###### Effective Rejection - Endowment 1 ######
###############################################

data <- read_excel("Effective_rejection_Endowment.xlsx")

time_black <- data$value[data$black == 1] - ifelse(data$value[data$black == 1] < 6, 0.2, 0.1)
coefficients_black <- data$coefficient[data$black == 1]
stderr_black <- data$standard_error[data$black == 1]

time_asian <- data$value[data$asian == 1] + ifelse(data$value[data$asian == 1] < 6, 0, 0)
coefficients_asian <- data$coefficient[data$asian == 1]
stderr_asian <- data$standard_error[data$asian == 1]

time_asian_white <- data$value[data$asian_white == 1] + ifelse(data$value[data$asian_white == 1] < 6, 0.2, 0.1)
coefficients_asian_white <- data$coefficient[data$asian_white == 1]
stderr_asian_white <- data$standard_error[data$asian_white == 1]

time_hispanic <- data$value[data$hispanic == 1] + ifelse(data$value[data$hispanic == 1] < 6, 0.4, 0.2)
coefficients_hispanic <- data$coefficient[data$hispanic == 1]
stderr_hispanic <- data$standard_error[data$hispanic == 1]

# Save current graphical parameters
opar <- par(no.readonly = TRUE)

# Change the margins of the plot (the first is the bottom margin)
par(mar = c(8, 4.1, 4.1, 2.1))

# Create PDF
pdf("rejection_endowment_plot.pdf", width = 14, height = 8.5)

# Plotting
plot(time_black, coefficients_black, ylim = c(-0.05, 0.2), xlim = c(1, 20),
     xlab = 'Quantile', ylab = 'Marginal Effects', 
     pch = 16, type = "p", col = "blue", xaxt = "n", cex = 1.5, lwd = 2)

# Add x-axis with custom ticks and labels in percentiles
axis(1, at = seq(1, 20, by = 1), labels = paste(seq(5, 100, by = 5), "%", sep = ""))

# Add error bars for the black group
arrows(time_black, coefficients_black - stderr_black, time_black, coefficients_black + stderr_black, angle = 90, code = 3, length = 0.1, col = "blue", lwd = 2)

# Add the asian group
points(time_asian, coefficients_asian, pch = 17, type = "p", col = "red", cex = 1.5, lwd = 2)
arrows(time_asian, coefficients_asian - stderr_asian, time_asian, coefficients_asian + stderr_asian, angle = 90, code = 3, length = 0.1, col = "red", lwd = 2)

# Add the asian_white group
points(time_asian_white, coefficients_asian_white, pch = 18, type = "p", col = "forestgreen", cex = 1.5, lwd = 2)
arrows(time_asian_white, coefficients_asian_white - stderr_asian_white, time_asian_white, coefficients_asian_white + stderr_asian_white, angle = 90, code = 3, length = 0.1, col = "forestgreen", lwd = 2)

# Add the hispanic group
points(time_hispanic, coefficients_hispanic, pch = 15, type = "p", col = "gold", cex = 1.5, lwd = 2)
arrows(time_hispanic, coefficients_hispanic - stderr_hispanic, time_hispanic, coefficients_hispanic + stderr_hispanic, angle = 90, code = 3, length = 0.1, col = "gold3", lwd = 2)

# Add red line at y=0
abline(h = 0, col = "red", lty = 2)

# Add legend outside the graph at the bottom
legend(x = 1, y =-0.25 , legend = c("Black", "Asian", "Hispanic", "Asian with White First Names"),
       pch = c(16, 17, 15, 18), col = c("blue", "red", "gold", "forestgreen"), pt.cex = 1.5, cex = 1.2, ncol = 4, bty = "n", xpd = TRUE, horiz = FALSE, inset = c(-0.1, -0.1), text.width = c(1.25, 1.25, 1.5, 0.9))

# Close PDF file
dev.off()

# Back to the default graphical parameters
par(opar)



######################################
###### Gave Waiver - Endowment 1 ######
######################################

data <- read_excel("Gavewaiver_Endowment.xlsx")

time_black <- data$value[data$black == 1] - ifelse(data$value[data$black == 1] < 6, 0.2, 0.1)
coefficients_black <- data$coefficient[data$black == 1]
stderr_black <- data$standard_error[data$black == 1]

time_asian <- data$value[data$asian == 1] + ifelse(data$value[data$asian == 1] < 6, 0, 0)
coefficients_asian <- data$coefficient[data$asian == 1]
stderr_asian <- data$standard_error[data$asian == 1]

time_asian_white <- data$value[data$asian_white == 1] + ifelse(data$value[data$asian_white == 1] < 6, 0.2, 0.1)
coefficients_asian_white <- data$coefficient[data$asian_white == 1]
stderr_asian_white <- data$standard_error[data$asian_white == 1]

time_hispanic <- data$value[data$hispanic == 1] + ifelse(data$value[data$hispanic == 1] < 6, 0.4, 0.2)
coefficients_hispanic <- data$coefficient[data$hispanic == 1]
stderr_hispanic <- data$standard_error[data$hispanic == 1]

# Save current graphical parameters
opar <- par(no.readonly = TRUE)

# Change the margins of the plot (the first is the bottom margin)
par(mar = c(8, 4.1, 4.1, 2.1))

# Create PDF
pdf("waiver_endowment_plot.pdf", width = 14, height = 8.5)

# Plotting
plot(time_black, coefficients_black, ylim = c(-0.10, 0.05), xlim = c(1, 20),
     xlab = 'Quantile', ylab = 'Marginal Effects', 
     pch = 16, type = "p", col = "blue", xaxt = "n", cex = 1.5, lwd = 2)

# Add x-axis with custom ticks and labels in percentiles
axis(1, at = seq(1, 20, by = 2), labels = paste(seq(5, 100, by = 10), "%", sep = ""))

# Add error bars for the black group
arrows(time_black, coefficients_black - stderr_black, time_black, coefficients_black + stderr_black, angle = 90, code = 3, length = 0.1, col = "blue", lwd = 2)

# Add the asian group
points(time_asian, coefficients_asian, pch = 17, type = "p", col = "red", cex = 1.5, lwd = 2)
arrows(time_asian, coefficients_asian - stderr_asian, time_asian, coefficients_asian + stderr_asian, angle = 90, code = 3, length = 0.1, col = "red", lwd = 2)

# Add the asian_white group
points(time_asian_white, coefficients_asian_white, pch = 18, type = "p", col = "forestgreen", cex = 1.5, lwd = 2)
arrows(time_asian_white, coefficients_asian_white - stderr_asian_white, time_asian_white, coefficients_asian_white + stderr_asian_white, angle = 90, code = 3, length = 0.1, col = "forestgreen", lwd = 2)

# Add the hispanic group
points(time_hispanic, coefficients_hispanic, pch = 15, type = "p", col = "gold", cex = 1.5, lwd = 2)
arrows(time_hispanic, coefficients_hispanic - stderr_hispanic, time_hispanic, coefficients_hispanic + stderr_hispanic, angle = 90, code = 3, length = 0.1, col = "gold3", lwd = 2)

# Add red line at y=0
abline(h = 0, col = "red", lty = 2)

# Add legend outside the graph at the bottom
legend(x = 1, y =-0.15 , legend = c("Black", "Asian", "Hispanic", "Asian with White First Names"),
       pch = c(16, 17, 15, 18), col = c("blue", "red", "gold", "forestgreen"), pt.cex = 1.5, cex = 1.2, ncol = 4, bty = "n", xpd = TRUE, horiz = FALSE, inset = c(-0.1, -0.1), text.width = c(1.5, 1.5, 2, 0.9))

# Close PDF file
dev.off()

# Back to the default graphical parameters
par(opar)



#####################################
###### Responded - Rural/Urban ######
#####################################

data <- read_excel("Responded_RuralUrban.xlsx")

# Ensure that each group has exactly three observations for the categories
categories <- c("Rural", "Suburban", "Urban")

# Extract data for each group and category
black_values <- data$coefficient[data$black == 1]
black_lower <- data$lowerbound[data$black == 1]
black_upper <- data$upperbound[data$black == 1]

asian_values <- data$coefficient[data$asian == 1]
asian_lower <- data$lowerbound[data$asian == 1]
asian_upper <- data$upperbound[data$asian == 1]

asian_white_values <- data$coefficient[data$asian_white == 1]
asian_white_lower <- data$lowerbound[data$asian_white == 1]
asian_white_upper <- data$upperbound[data$asian_white == 1]

hispanic_values <- data$coefficient[data$hispanic == 1]
hispanic_lower <- data$lowerbound[data$hispanic == 1]
hispanic_upper <- data$upperbound[data$hispanic == 1]

# Check that each group has the correct number of observations
if(length(black_values) != 3 | length(asian_values) != 3 | length(asian_white_values) != 3 | length(hispanic_values) != 3) {
  stop("Each group must have exactly three observations (one for each category).")
}

# Define x positions for each category with staggered positions
x_positions <- 1:length(categories)
x_positions_black <- x_positions - 0.1
x_positions_asian <- x_positions
x_positions_asian_white <- x_positions + 0.1
x_positions_hispanic <- x_positions + 0.2

# Save current graphical parameters
opar <- par(no.readonly = TRUE)

# Change the margins of the plot (the first is the bottom margin)
par(mar = c(8, 4.1, 4.1, 2.1))

# Create PDF
pdf("responded_ruralurban_plot.pdf")

# Plot the points for each group
plot(x_positions_black, black_values, type = 'p', ylim = c(-0.20,0.05), xlim = c(0.5, 3.5),
     xlab = 'School Location', ylab = 'Marginal Effects', 
     col = "blue", pch = 16, xaxt = "n", cex = 1.5)

# Add x-axis labels
axis(1, at = x_positions, labels = categories)

# Add points for other groups
points(x_positions_asian, asian_values, col = "red", pch = 17, cex = 1.5)
points(x_positions_asian_white, asian_white_values, col = "forestgreen", pch = 18, cex = 1.5)
points(x_positions_hispanic, hispanic_values, col = "gold", pch = 15, cex = 1.5)

# Add error bars for each group
arrows(x_positions_black, black_lower, x_positions_black, black_upper, angle = 90, code = 3, length = 0.1, col = "blue", lwd = 2)
arrows(x_positions_asian, asian_lower, x_positions_asian, asian_upper, angle = 90, code = 3, length = 0.1, col = "red", lwd = 2)
arrows(x_positions_asian_white, asian_white_lower, x_positions_asian_white, asian_white_upper, angle = 90, code = 3, length = 0.1, col = "forestgreen", lwd = 2)
arrows(x_positions_hispanic, hispanic_lower, x_positions_hispanic, hispanic_upper, angle = 90, code = 3, length = 0.1, col = "gold", lwd = 2)

# Add red line at y=0
abline(h = 0, col = "red", lty = 2)

# Add legend outside the graph at the bottom
legend(x = .5, y =-0.32 , legend = c("Black", "Asian", "Hispanic", "Asian with White First Names"),
       pch = c(16, 17, 15, 18), col = c("blue", "red", "gold", "forestgreen"), pt.cex = 1.5, cex = 1.2, ncol = 4, bty = "n", xpd = TRUE, horiz = FALSE, inset = c(-0.1, -0.1), text.width = c(.33, .33, .4, 0.9))

# Close PDF file
dev.off()

# Back to the default graphical parameters
par(opar)



###############################################
###### Effective Rejection - Rural/Urban ######
###############################################

data <- read_excel("Effective_rejection_RuralUrba.xlsx")

# Ensure that each group has exactly three observations for the categories
categories <- c("Rural", "Suburban", "Urban")

# Extract data for each group and category
black_values <- data$coefficient[data$black == 1]
black_lower <- data$lowerbound[data$black == 1]
black_upper <- data$upperbound[data$black == 1]

asian_values <- data$coefficient[data$asian == 1]
asian_lower <- data$lowerbound[data$asian == 1]
asian_upper <- data$upperbound[data$asian == 1]

asian_white_values <- data$coefficient[data$asian_white == 1]
asian_white_lower <- data$lowerbound[data$asian_white == 1]
asian_white_upper <- data$upperbound[data$asian_white == 1]

hispanic_values <- data$coefficient[data$hispanic == 1]
hispanic_lower <- data$lowerbound[data$hispanic == 1]
hispanic_upper <- data$upperbound[data$hispanic == 1]

# Check that each group has the correct number of observations
if(length(black_values) != 3 | length(asian_values) != 3 | length(asian_white_values) != 3 | length(hispanic_values) != 3) {
  stop("Each group must have exactly three observations (one for each category).")
}

# Define x positions for each category with staggered positions
x_positions <- 1:length(categories)
x_positions_black <- x_positions - 0.1
x_positions_asian <- x_positions
x_positions_asian_white <- x_positions + 0.1
x_positions_hispanic <- x_positions + 0.2

# Save current graphical parameters
opar <- par(no.readonly = TRUE)

# Change the margins of the plot (the first is the bottom margin)
par(mar = c(8, 4.1, 4.1, 2.1))

# Create PDF
pdf("rejection_ruralurban_plot.pdf")

# Plot the points for each group
plot(x_positions_black, black_values, type = 'p', ylim = c(-0.05,0.2), xlim = c(0.5, 3.5),
     xlab = 'School Location', ylab = 'Marginal Effects', 
     col = "blue", pch = 16, xaxt = "n", cex = 1.5)

# Add x-axis labels
axis(1, at = x_positions, labels = categories)

# Add points for other groups
points(x_positions_asian, asian_values, col = "red", pch = 17, cex = 1.5)
points(x_positions_asian_white, asian_white_values, col = "forestgreen", pch = 18, cex = 1.5)
points(x_positions_hispanic, hispanic_values, col = "gold", pch = 15, cex = 1.5)

# Add error bars for each group
arrows(x_positions_black, black_lower, x_positions_black, black_upper, angle = 90, code = 3, length = 0.1, col = "blue", lwd = 2)
arrows(x_positions_asian, asian_lower, x_positions_asian, asian_upper, angle = 90, code = 3, length = 0.1, col = "red", lwd = 2)
arrows(x_positions_asian_white, asian_white_lower, x_positions_asian_white, asian_white_upper, angle = 90, code = 3, length = 0.1, col = "forestgreen", lwd = 2)
arrows(x_positions_hispanic, hispanic_lower, x_positions_hispanic, hispanic_upper, angle = 90, code = 3, length = 0.1, col = "gold", lwd = 2)

# Add red line at y=0
abline(h = 0, col = "red", lty = 2)

# Add legend outside the graph at the bottom
legend(x = .5, y =-0.15 , legend = c("Black", "Asian", "Hispanic", "Asian with White First Names"),
       pch = c(16, 17, 15, 18), col = c("blue", "red", "gold", "forestgreen"), pt.cex = 1.5, cex = 1.2, ncol = 4, bty = "n", xpd = TRUE, horiz = FALSE, inset = c(-0.1, -0.1), text.width = c(.33, .33, .4, 0.9))

# Close PDF file
dev.off()

# Back to the default graphical parameters
par(opar)



#######################################
###### Gave Waiver - Rural/Urban ######
#######################################

data <- read_excel("Gavewaiver_RuralUrban.xlsx")

# Ensure that each group has exactly three observations for the categories
categories <- c("Rural", "Suburban", "Urban")

# Extract data for each group and category
black_values <- data$coefficient[data$black == 1]
black_lower <- data$lowerbound[data$black == 1]
black_upper <- data$upperbound[data$black == 1]

asian_values <- data$coefficient[data$asian == 1]
asian_lower <- data$lowerbound[data$asian == 1]
asian_upper <- data$upperbound[data$asian == 1]

asian_white_values <- data$coefficient[data$asian_white == 1]
asian_white_lower <- data$lowerbound[data$asian_white == 1]
asian_white_upper <- data$upperbound[data$asian_white == 1]

hispanic_values <- data$coefficient[data$hispanic == 1]
hispanic_lower <- data$lowerbound[data$hispanic == 1]
hispanic_upper <- data$upperbound[data$hispanic == 1]

# Check that each group has the correct number of observations
if(length(black_values) != 3 | length(asian_values) != 3 | length(asian_white_values) != 3 | length(hispanic_values) != 3) {
  stop("Each group must have exactly three observations (one for each category).")
}

# Define x positions for each category with staggered positions
x_positions <- 1:length(categories)
x_positions_black <- x_positions - 0.1
x_positions_asian <- x_positions
x_positions_asian_white <- x_positions + 0.1
x_positions_hispanic <- x_positions + 0.2

# Save current graphical parameters
opar <- par(no.readonly = TRUE)

# Change the margins of the plot (the first is the bottom margin)
par(mar = c(8, 4.1, 4.1, 2.1))

# Create PDF
pdf("waiver_ruralurban_plot.pdf")

# Plot the points for each group
plot(x_positions_black, black_values, type = 'p', ylim = c(-0.1,0.05), xlim = c(0.5, 3.5),
     xlab = 'School Location', ylab = 'Marginal Effects', 
     col = "blue", pch = 16, xaxt = "n", cex = 1.5)

# Add x-axis labels
axis(1, at = x_positions, labels = categories)

# Add points for other groups
points(x_positions_asian, asian_values, col = "red", pch = 17, cex = 1.5)
points(x_positions_asian_white, asian_white_values, col = "forestgreen", pch = 18, cex = 1.5)
points(x_positions_hispanic, hispanic_values, col = "gold", pch = 15, cex = 1.5)

# Add error bars for each group
arrows(x_positions_black, black_lower, x_positions_black, black_upper, angle = 90, code = 3, length = 0.1, col = "blue", lwd = 2)
arrows(x_positions_asian, asian_lower, x_positions_asian, asian_upper, angle = 90, code = 3, length = 0.1, col = "red", lwd = 2)
arrows(x_positions_asian_white, asian_white_lower, x_positions_asian_white, asian_white_upper, angle = 90, code = 3, length = 0.1, col = "forestgreen", lwd = 2)
arrows(x_positions_hispanic, hispanic_lower, x_positions_hispanic, hispanic_upper, angle = 90, code = 3, length = 0.1, col = "gold", lwd = 2)

# Add red line at y=0
abline(h = 0, col = "red", lty = 2)

# Add legend outside the graph at the bottom
legend(x = .5, y =-0.15 , legend = c("Black", "Asian", "Hispanic", "Asian with White First Names"),
       pch = c(16, 17, 15, 18), col = c("blue", "red", "gold", "forestgreen"), pt.cex = 1.5, cex = 1.2, ncol = 4, bty = "n", xpd = TRUE, horiz = FALSE, inset = c(-0.1, -0.1), text.width = c(.33, .33, .4, 0.9))

# Close PDF file
dev.off()

# Back to the default graphical parameters
par(opar)



##########################################
###### Responded - Public / Private ######
##########################################

data <- read_excel("Responded_PublicPrivate.xlsx")

# Ensure that each group has exactly three observations for the categories
categories <- c("Public", "Private")

# Extract data for each group and category
black_values <- data$coefficient[data$black == 1]
black_lower <- data$lowerbound[data$black == 1]
black_upper <- data$upperbound[data$black == 1]

asian_values <- data$coefficient[data$asian == 1]
asian_lower <- data$lowerbound[data$asian == 1]
asian_upper <- data$upperbound[data$asian == 1]

asian_white_values <- data$coefficient[data$asian_white == 1]
asian_white_lower <- data$lowerbound[data$asian_white == 1]
asian_white_upper <- data$upperbound[data$asian_white == 1]

hispanic_values <- data$coefficient[data$hispanic == 1]
hispanic_lower <- data$lowerbound[data$hispanic == 1]
hispanic_upper <- data$upperbound[data$hispanic == 1]

# Check that each group has the correct number of observations
if(length(black_values) != 2 | length(asian_values) != 2 | length(asian_white_values) != 2 | length(hispanic_values) != 2) {
  stop("Each group must have exactly three observations (one for each category).")
}

# Define x positions for each category with staggered positions
x_positions <- 1:length(categories)
x_positions_black <- x_positions - 0.1
x_positions_asian <- x_positions
x_positions_asian_white <- x_positions + 0.1
x_positions_hispanic <- x_positions + 0.2

# Save current graphical parameters
opar <- par(no.readonly = TRUE)

# Change the margins of the plot (the first is the bottom margin)
par(mar = c(8, 4.1, 4.1, 2.1))

# Create PDF
pdf("responded_publicprivate_plot.pdf")

# Plot the points for each group
plot(x_positions_black, black_values, type = 'p', ylim = c(-0.20,0.05), xlim = c(0.5, 2.5),
     xlab = 'Public/Private Designation', ylab = 'Marginal Effects', 
     col = "blue", pch = 16, xaxt = "n", cex = 1.5)

# Add x-axis labels
axis(1, at = x_positions, labels = categories)

# Add points for other groups
points(x_positions_asian, asian_values, col = "red", pch = 17, cex = 1.5)
points(x_positions_asian_white, asian_white_values, col = "forestgreen", pch = 18, cex = 1.5)
points(x_positions_hispanic, hispanic_values, col = "gold", pch = 15, cex = 1.5)

# Add error bars for each group
arrows(x_positions_black, black_lower, x_positions_black, black_upper, angle = 90, code = 3, length = 0.1, col = "blue", lwd = 2)
arrows(x_positions_asian, asian_lower, x_positions_asian, asian_upper, angle = 90, code = 3, length = 0.1, col = "red", lwd = 2)
arrows(x_positions_asian_white, asian_white_lower, x_positions_asian_white, asian_white_upper, angle = 90, code = 3, length = 0.1, col = "forestgreen", lwd = 2)
arrows(x_positions_hispanic, hispanic_lower, x_positions_hispanic, hispanic_upper, angle = 90, code = 3, length = 0.1, col = "gold", lwd = 2)

# Add red line at y=0
abline(h = 0, col = "red", lty = 2)

# Add legend outside the graph at the bottom
legend(x = .5, y =-0.3 , legend = c("Black", "Asian", "Hispanic", "Asian with White First Names"),
       pch = c(16, 17, 15, 18), col = c("blue", "red", "gold", "forestgreen"), pt.cex = 1.5, cex = 1.2, ncol = 4, bty = "n", xpd = TRUE, horiz = FALSE, inset = c(-0.1, -0.1), text.width = c(.177, .177, .225, 0.9))

# Close PDF file
dev.off()

# Back to the default graphical parameters
par(opar)



##################################################
###### Effective Rejection - Public/Private ######
##################################################

data <- read_excel("Effective_rejection_PublicPri.xlsx")

# Ensure that each group has exactly three observations for the categories
categories <- c("Public", "Private")

# Extract data for each group and category
black_values <- data$coefficient[data$black == 1]
black_lower <- data$lowerbound[data$black == 1]
black_upper <- data$upperbound[data$black == 1]

asian_values <- data$coefficient[data$asian == 1]
asian_lower <- data$lowerbound[data$asian == 1]
asian_upper <- data$upperbound[data$asian == 1]

asian_white_values <- data$coefficient[data$asian_white == 1]
asian_white_lower <- data$lowerbound[data$asian_white == 1]
asian_white_upper <- data$upperbound[data$asian_white == 1]

hispanic_values <- data$coefficient[data$hispanic == 1]
hispanic_lower <- data$lowerbound[data$hispanic == 1]
hispanic_upper <- data$upperbound[data$hispanic == 1]

# Check that each group has the correct number of observations
if(length(black_values) != 2 | length(asian_values) != 2 | length(asian_white_values) != 2 | length(hispanic_values) != 2) {
  stop("Each group must have exactly three observations (one for each category).")
}

# Define x positions for each category with staggered positions
x_positions <- 1:length(categories)
x_positions_black <- x_positions - 0.1
x_positions_asian <- x_positions
x_positions_asian_white <- x_positions + 0.1
x_positions_hispanic <- x_positions + 0.2

# Save current graphical parameters
opar <- par(no.readonly = TRUE)

# Change the margins of the plot (the first is the bottom margin)
par(mar = c(8, 4.1, 4.1, 2.1))

# Create PDF
pdf("rejection_publicprivate_plot.pdf")

# Plot the points for each group
plot(x_positions_black, black_values, type = 'p', ylim = c(-0.05,0.2), xlim = c(0.5, 2.5),
     xlab = 'Public/Private Designation', ylab = 'Marginal Effects', 
     col = "blue", pch = 16, xaxt = "n", cex = 1.5)

# Add x-axis labels
axis(1, at = x_positions, labels = categories)

# Add points for other groups
points(x_positions_asian, asian_values, col = "red", pch = 17, cex = 1.5)
points(x_positions_asian_white, asian_white_values, col = "forestgreen", pch = 18, cex = 1.5)
points(x_positions_hispanic, hispanic_values, col = "gold", pch = 15, cex = 1.5)

# Add error bars for each group
arrows(x_positions_black, black_lower, x_positions_black, black_upper, angle = 90, code = 3, length = 0.1, col = "blue", lwd = 2)
arrows(x_positions_asian, asian_lower, x_positions_asian, asian_upper, angle = 90, code = 3, length = 0.1, col = "red", lwd = 2)
arrows(x_positions_asian_white, asian_white_lower, x_positions_asian_white, asian_white_upper, angle = 90, code = 3, length = 0.1, col = "forestgreen", lwd = 2)
arrows(x_positions_hispanic, hispanic_lower, x_positions_hispanic, hispanic_upper, angle = 90, code = 3, length = 0.1, col = "gold", lwd = 2)

# Add red line at y=0
abline(h = 0, col = "red", lty = 2)

# Add legend outside the graph at the bottom
legend(x = .5, y =-0.15 , legend = c("Black", "Asian", "Hispanic", "Asian with White First Names"),
       pch = c(16, 17, 15, 18), col = c("blue", "red", "gold", "forestgreen"), pt.cex = 1.5, cex = 1.2, ncol = 4, bty = "n", xpd = TRUE, horiz = FALSE, inset = c(-0.1, -0.1), text.width = c(.177, .177, .225, 0.9))

# Close PDF file
dev.off()

# Back to the default graphical parameters
par(opar)



###########################################
###### Gave Waiver - Public/Private ######
##########################################

data <- read_excel("Gavewaiver_PublicPrivate.xlsx")

# Ensure that each group has exactly three observations for the categories
categories <- c("Public", "Private")

# Extract data for each group and category
black_values <- data$coefficient[data$black == 1]
black_lower <- data$lowerbound[data$black == 1]
black_upper <- data$upperbound[data$black == 1]

asian_values <- data$coefficient[data$asian == 1]
asian_lower <- data$lowerbound[data$asian == 1]
asian_upper <- data$upperbound[data$asian == 1]

asian_white_values <- data$coefficient[data$asian_white == 1]
asian_white_lower <- data$lowerbound[data$asian_white == 1]
asian_white_upper <- data$upperbound[data$asian_white == 1]

hispanic_values <- data$coefficient[data$hispanic == 1]
hispanic_lower <- data$lowerbound[data$hispanic == 1]
hispanic_upper <- data$upperbound[data$hispanic == 1]

# Check that each group has the correct number of observations
if(length(black_values) != 2 | length(asian_values) != 2 | length(asian_white_values) != 2 | length(hispanic_values) != 2) {
  stop("Each group must have exactly three observations (one for each category).")
}

# Define x positions for each category with staggered positions
x_positions <- 1:length(categories)
x_positions_black <- x_positions - 0.1
x_positions_asian <- x_positions
x_positions_asian_white <- x_positions + 0.1
x_positions_hispanic <- x_positions + 0.2

# Save current graphical parameters
opar <- par(no.readonly = TRUE)

# Change the margins of the plot (the first is the bottom margin)
par(mar = c(8, 4.1, 4.1, 2.1))

# Create PDF
pdf("waiver_publicprivate_plot.pdf")

# Plot the points for each group
plot(x_positions_black, black_values, type = 'p', ylim = c(-0.10,0.05), xlim = c(0.5, 2.5),
     xlab = 'Public/Private Designation', ylab = 'Marginal Effects', 
     col = "blue", pch = 16, xaxt = "n", cex = 1.5)

# Add x-axis labels
axis(1, at = x_positions, labels = categories)

# Add points for other groups
points(x_positions_asian, asian_values, col = "red", pch = 17, cex = 1.5)
points(x_positions_asian_white, asian_white_values, col = "forestgreen", pch = 18, cex = 1.5)
points(x_positions_hispanic, hispanic_values, col = "gold", pch = 15, cex = 1.5)

# Add error bars for each group
arrows(x_positions_black, black_lower, x_positions_black, black_upper, angle = 90, code = 3, length = 0.1, col = "blue", lwd = 2)
arrows(x_positions_asian, asian_lower, x_positions_asian, asian_upper, angle = 90, code = 3, length = 0.1, col = "red", lwd = 2)
arrows(x_positions_asian_white, asian_white_lower, x_positions_asian_white, asian_white_upper, angle = 90, code = 3, length = 0.1, col = "forestgreen", lwd = 2)
arrows(x_positions_hispanic, hispanic_lower, x_positions_hispanic, hispanic_upper, angle = 90, code = 3, length = 0.1, col = "gold", lwd = 2)

# Add red line at y=0
abline(h = 0, col = "red", lty = 2)

# Add legend outside the graph at the bottom
legend(x = .5, y =-0.1555 , legend = c("Black", "Asian", "Hispanic", "Asian with White First Names"),
       pch = c(16, 17, 15, 18), col = c("blue", "red", "gold", "forestgreen"), pt.cex = 1.5, cex = 1.2, ncol = 4, bty = "n", xpd = TRUE, horiz = FALSE, inset = c(-0.1, -0.1), text.width = c(.177, .177, .225, 0.9))

# Close PDF file
dev.off()

# Back to the default graphical parameters
par(opar)



#####################################
###### Responded - School Size ######
#####################################

data <- read_excel("Responded_SchoolSize.xlsx")

# Ensure that each group has exactly three observations for the categories
categories <- c("Small", "Medium", "Large", "Very Large")

# Extract data for each group and category
black_values <- data$coefficient[data$black == 1]
black_lower <- data$lowerbound[data$black == 1]
black_upper <- data$upperbound[data$black == 1]

asian_values <- data$coefficient[data$asian == 1]
asian_lower <- data$lowerbound[data$asian == 1]
asian_upper <- data$upperbound[data$asian == 1]

asian_white_values <- data$coefficient[data$asian_white == 1]
asian_white_lower <- data$lowerbound[data$asian_white == 1]
asian_white_upper <- data$upperbound[data$asian_white == 1]

hispanic_values <- data$coefficient[data$hispanic == 1]
hispanic_lower <- data$lowerbound[data$hispanic == 1]
hispanic_upper <- data$upperbound[data$hispanic == 1]

# Check that each group has the correct number of observations
if(length(black_values) != 4 | length(asian_values) != 4 | length(asian_white_values) != 4 | length(hispanic_values) != 4) {
  stop("Each group must have exactly three observations (one for each category).")
}

# Define x positions for each category with staggered positions
x_positions <- 1:length(categories)
x_positions_black <- x_positions - 0.1
x_positions_asian <- x_positions
x_positions_asian_white <- x_positions + 0.1
x_positions_hispanic <- x_positions + 0.2

# Save current graphical parameters
opar <- par(no.readonly = TRUE)

# Change the margins of the plot (the first is the bottom margin)
par(mar = c(8, 4.1, 4.1, 2.1))

# Create PDF
pdf("responded_size_plot.pdf")

# Plot the points for each group
plot(x_positions_black, black_values, type = 'p', ylim = c(-0.20,0.05), xlim = c(0.5, 4.5),
     xlab = 'Size of Student Population', ylab = 'Marginal Effects', 
     col = "blue", pch = 16, xaxt = "n", cex = 1.5)

# Add x-axis labels
axis(1, at = x_positions, labels = categories)

# Add points for other groups
points(x_positions_asian, asian_values, col = "red", pch = 17, cex = 1.5)
points(x_positions_asian_white, asian_white_values, col = "forestgreen", pch = 18, cex = 1.5)
points(x_positions_hispanic, hispanic_values, col = "gold", pch = 15, cex = 1.5)

# Add error bars for each group
arrows(x_positions_black, black_lower, x_positions_black, black_upper, angle = 90, code = 3, length = 0.1, col = "blue", lwd = 2)
arrows(x_positions_asian, asian_lower, x_positions_asian, asian_upper, angle = 90, code = 3, length = 0.1, col = "red", lwd = 2)
arrows(x_positions_asian_white, asian_white_lower, x_positions_asian_white, asian_white_upper, angle = 90, code = 3, length = 0.1, col = "forestgreen", lwd = 2)
arrows(x_positions_hispanic, hispanic_lower, x_positions_hispanic, hispanic_upper, angle = 90, code = 3, length = 0.1, col = "gold", lwd = 2)

# Add red line at y=0
abline(h = 0, col = "red", lty = 2)

# Add legend outside the graph at the bottom
legend(x = .5, y =-0.3 , legend = c("Black", "Asian", "Hispanic", "Asian with White First Names"),
       pch = c(16, 17, 15, 18), col = c("blue", "red", "gold", "forestgreen"), pt.cex = 1.5, cex = 1.2, ncol = 4, bty = "n", xpd = TRUE, horiz = FALSE, inset = c(-0.1, -0.1), text.width = c(.5, .5, .5, 0.9))

# Close PDF file
dev.off()

# Back to the default graphical parameters
par(opar)



###############################################
###### Effective Rejection - School Size ######
###############################################

data <- read_excel("Effective_rejection_SchoolSi.xlsx")

# Ensure that each group has exactly three observations for the categories
categories <- c("Small", "Medium", "Large", "Very Large")

# Extract data for each group and category
black_values <- data$coefficient[data$black == 1]
black_lower <- data$lowerbound[data$black == 1]
black_upper <- data$upperbound[data$black == 1]

asian_values <- data$coefficient[data$asian == 1]
asian_lower <- data$lowerbound[data$asian == 1]
asian_upper <- data$upperbound[data$asian == 1]

asian_white_values <- data$coefficient[data$asian_white == 1]
asian_white_lower <- data$lowerbound[data$asian_white == 1]
asian_white_upper <- data$upperbound[data$asian_white == 1]

hispanic_values <- data$coefficient[data$hispanic == 1]
hispanic_lower <- data$lowerbound[data$hispanic == 1]
hispanic_upper <- data$upperbound[data$hispanic == 1]

# Check that each group has the correct number of observations
if(length(black_values) != 4 | length(asian_values) != 4 | length(asian_white_values) != 4 | length(hispanic_values) != 4) {
  stop("Each group must have exactly three observations (one for each category).")
}

# Define x positions for each category with staggered positions
x_positions <- 1:length(categories)
x_positions_black <- x_positions - 0.1
x_positions_asian <- x_positions
x_positions_asian_white <- x_positions + 0.1
x_positions_hispanic <- x_positions + 0.2

# Save current graphical parameters
opar <- par(no.readonly = TRUE)

# Change the margins of the plot (the first is the bottom margin)
par(mar = c(8, 4.1, 4.1, 2.1))

# Create PDF
pdf("rejection_size_plot.pdf")

# Plot the points for each group
plot(x_positions_black, black_values, type = 'p', ylim = c(-0.05,0.2), xlim = c(0.5, 4.5),
     xlab = 'Size of Student Population', ylab = 'Marginal Effects', 
     col = "blue", pch = 16, xaxt = "n", cex = 1.5)

# Add x-axis labels
axis(1, at = x_positions, labels = categories)

# Add points for other groups
points(x_positions_asian, asian_values, col = "red", pch = 17, cex = 1.5)
points(x_positions_asian_white, asian_white_values, col = "forestgreen", pch = 18, cex = 1.5)
points(x_positions_hispanic, hispanic_values, col = "gold", pch = 15, cex = 1.5)

# Add error bars for each group
arrows(x_positions_black, black_lower, x_positions_black, black_upper, angle = 90, code = 3, length = 0.1, col = "blue", lwd = 2)
arrows(x_positions_asian, asian_lower, x_positions_asian, asian_upper, angle = 90, code = 3, length = 0.1, col = "red", lwd = 2)
arrows(x_positions_asian_white, asian_white_lower, x_positions_asian_white, asian_white_upper, angle = 90, code = 3, length = 0.1, col = "forestgreen", lwd = 2)
arrows(x_positions_hispanic, hispanic_lower, x_positions_hispanic, hispanic_upper, angle = 90, code = 3, length = 0.1, col = "gold", lwd = 2)

# Add red line at y=0
abline(h = 0, col = "red", lty = 2)

# Add legend outside the graph at the bottom
legend(x = .5, y =-0.15 , legend = c("Black", "Asian", "Hispanic", "Asian with White First Names"),
       pch = c(16, 17, 15, 18), col = c("blue", "red", "gold", "forestgreen"), pt.cex = 1.5, cex = 1.2, ncol = 4, bty = "n", xpd = TRUE, horiz = FALSE, inset = c(-0.1, -0.1), text.width = c(.5, .5, .5, 0.9))

# Close PDF file
dev.off()

# Back to the default graphical parameters
par(opar)



#######################################
###### Gave Waiver - School Size ######
#######################################

data <- read_excel("Gavewaiver_SchoolSize.xlsx")

# Ensure that each group has exactly three observations for the categories
categories <- c("Small", "Medium", "Large", "Very Large")

# Extract data for each group and category
black_values <- data$coefficient[data$black == 1]
black_lower <- data$lowerbound[data$black == 1]
black_upper <- data$upperbound[data$black == 1]

asian_values <- data$coefficient[data$asian == 1]
asian_lower <- data$lowerbound[data$asian == 1]
asian_upper <- data$upperbound[data$asian == 1]

asian_white_values <- data$coefficient[data$asian_white == 1]
asian_white_lower <- data$lowerbound[data$asian_white == 1]
asian_white_upper <- data$upperbound[data$asian_white == 1]

hispanic_values <- data$coefficient[data$hispanic == 1]
hispanic_lower <- data$lowerbound[data$hispanic == 1]
hispanic_upper <- data$upperbound[data$hispanic == 1]

# Check that each group has the correct number of observations
if(length(black_values) != 4 | length(asian_values) != 4 | length(asian_white_values) != 4 | length(hispanic_values) != 4) {
  stop("Each group must have exactly three observations (one for each category).")
}

# Define x positions for each category with staggered positions
x_positions <- 1:length(categories)
x_positions_black <- x_positions - 0.1
x_positions_asian <- x_positions
x_positions_asian_white <- x_positions + 0.1
x_positions_hispanic <- x_positions + 0.2

# Save current graphical parameters
opar <- par(no.readonly = TRUE)

# Change the margins of the plot (the first is the bottom margin)
par(mar = c(8, 4.1, 4.1, 2.1))

# Create PDF
pdf("waiver_size_plot.pdf")

# Plot the points for each group
plot(x_positions_black, black_values, type = 'p', ylim = c(-0.1,0.05), xlim = c(0.5, 4.5),
     xlab = 'Size of Student Population', ylab = 'Marginal Effects', 
     col = "blue", pch = 16, xaxt = "n", cex = 1.5)

# Add x-axis labels
axis(1, at = x_positions, labels = categories)

# Add points for other groups
points(x_positions_asian, asian_values, col = "red", pch = 17, cex = 1.5)
points(x_positions_asian_white, asian_white_values, col = "forestgreen", pch = 18, cex = 1.5)
points(x_positions_hispanic, hispanic_values, col = "gold", pch = 15, cex = 1.5)

# Add error bars for each group
arrows(x_positions_black, black_lower, x_positions_black, black_upper, angle = 90, code = 3, length = 0.1, col = "blue", lwd = 2)
arrows(x_positions_asian, asian_lower, x_positions_asian, asian_upper, angle = 90, code = 3, length = 0.1, col = "red", lwd = 2)
arrows(x_positions_asian_white, asian_white_lower, x_positions_asian_white, asian_white_upper, angle = 90, code = 3, length = 0.1, col = "forestgreen", lwd = 2)
arrows(x_positions_hispanic, hispanic_lower, x_positions_hispanic, hispanic_upper, angle = 90, code = 3, length = 0.1, col = "gold", lwd = 2)

# Add red line at y=0
abline(h = 0, col = "red", lty = 2)

# Add legend outside the graph at the bottom
legend(x = .5, y =-0.15 , legend = c("Black", "Asian", "Hispanic", "Asian with White First Names"),
       pch = c(16, 17, 15, 18), col = c("blue", "red", "gold", "forestgreen"), pt.cex = 1.5, cex = 1.2, ncol = 4, bty = "n", xpd = TRUE, horiz = FALSE, inset = c(-0.1, -0.1), text.width = c(.5, .5, .5, 0.9))

# Close PDF file
dev.off()

# Back to the default graphical parameters
par(opar)