# Load necessary libraries
library(ggplot2)
library(dplyr)

# Load Uber dataset (replace 'uber_data.csv' with your dataset file)
uber_data <- read.csv('uber_data.csv')

# Convert the 'Date' column to a Date type
uber_data$Date <- as.Date(uber_data$Date)

# Data Exploration
summary(uber_data)

# Data Visualization
ggplot(uber_data, aes(x = Date, y = Rides)) +
  geom_line() +
  labs(title = "Uber Rides Over Time", x = "Date", y = "Number of Rides")

# Data Analysis (Example: Monthly averages)
monthly_averages <- uber_data %>%
  group_by(Year = lubridate::year(Date), Month = lubridate::month(Date)) %>%
  summarise(AvgRides = mean(Rides))

# Data Visualization (Monthly Averages)
ggplot(monthly_averages, aes(x = paste(Year, Month, sep = "-"), y = AvgRides)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Monthly Average Uber Rides", x = "Year-Month", y = "Average Rides")

# Statistical Analysis (Example: Linear Regression)
model <- lm(Rides ~ Date, data = uber_data)
summary(model)


# Reporting and Visualization (e.g., RMarkdown or Shiny dashboard)

# Save Plots as PNG
ggsave("uber_rides_over_time.png", width = 8, height = 6)

# Save Data Analysis Results
write.csv(monthly_averages, "monthly_averages.csv")

