library(ggplot2)

data <- read.csv('historical_trade_data.csv')

View(data)
head(data)
str(data)

high_exports <- subset(data, Exports > 200000)
print(high_exports)

data$Trade_Balance <- data$Exports - data$Imports

ggplot(data, aes(x = Year, y = Trade_Balance)) +
  geom_line(color = "blue", size = 1) +
  labs(title = "Trade Balance Over Time", 
       x = "Year", y = "Trade Balance") +
  theme_minimal()

ggsave("trade_balance_plot.png", width = 8, height = 5)

cat("Plot saved as trade_balance_plot.png and the exercise is complete.")

