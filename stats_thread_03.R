# Install and load necessary libraries
install.packages("ggplot2")
library(ggplot2)

# Generate sample data for DiD visualization
# Time period
time <- 1:20

# Control series: A slight upward trend with random noise
set.seed(123)
control <- 0.5*time + rnorm(20, sd = 1)

# Treatment series: Similar to control until time t=10, then diverges
t <- 10
treatment <- control + c(runif(n = t, min = -1, max = 1), rnorm(20-t, mean = 5, sd = 1))

data <- data.frame(
  Time = c(time, time),
  Value = c(control, treatment),
  Group = c(rep("Control", 20), rep("Treatment", 20))
)

# Generate the DiD plot
plot <- ggplot(data, aes(x = Time, y = Value, color = Group)) +
  geom_line(size=1.2) +
  geom_vline(aes(xintercept = t), linetype = "dashed", color = "black", size = 0.8) +
  annotate("text", x = t, y = max(data$Value) - 2, label = "Treatment Time (t)", vjust = 1, hjust = 1.5) +
  labs(
    title = "Difference-in-Differences Visualization",
    x = "Time",
    y = NULL,
    subtitle = "Treatment starts at time t, causing a divergence in the treatment group."
  ) +
  theme_minimal()
ggsave("DiD_plot.png", plot, width=6, height=5)
