library(tidyverse)
library(scales)

# Load summary data
major_summary <- read_csv("data/processed/major_summary.csv", show_col_types = FALSE)


# Top 10 Majors by 5-Year Earnings
top_earnings <- major_summary %>%
  arrange(desc(median_earnings_5yr)) %>%
  slice(1:10)

p1 <- ggplot(top_earnings,
             aes(x = reorder(major_name, median_earnings_5yr),
                 y = median_earnings_5yr)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  scale_y_continuous(labels = dollar) +
  labs(title = "Top 10 Majors by 5-Year Median Earnings",
       x = "Major",
       y = "Median 5-Year Earnings") +
  theme_minimal()

ggsave("figures/top_5yr_earnings.png", p1, width = 8, height = 5)


# Top 10 Majors by Earnings Growth
top_growth <- major_summary %>%
  arrange(desc(median_growth)) %>%
  slice(1:10)

p2 <- ggplot(top_growth,
             aes(x = reorder(major_name, median_growth),
                 y = median_growth)) +
  geom_col(fill = "darkgreen") +
  coord_flip() +
  scale_y_continuous(labels = dollar) +
  labs(title = "Top 10 Majors by Earnings Growth (1yr → 5yr)",
       x = "Major",
       y = "Median Earnings Growth") +
  theme_minimal()

ggsave("figures/top_growth.png", p2, width = 8, height = 5)

# Distribution of 5-Year Earnings
p3 <- ggplot(major_summary,
             aes(x = median_earnings_5yr)) +
  geom_histogram(bins = 40, fill = "purple", alpha = 0.7) +
  scale_x_continuous(labels = dollar) +
  labs(title = "Distribution of 5-Year Median Earnings",
       x = "Median 5-Year Earnings",
       y = "Count of Majors") +
  theme_minimal()

ggsave("figures/earnings_distribution.png", p3, width = 8, height = 5)


# Majors with Highest Earnings Variation
top_variation <- major_summary %>%
  arrange(desc(earnings_variation)) %>%
  slice(1:10)

p4 <- ggplot(top_variation,
             aes(x = reorder(major_name, earnings_variation),
                 y = earnings_variation)) +
  geom_col(fill = "orange") +
  coord_flip() +
  scale_y_continuous(labels = dollar) +
  labs(title = "Majors with Highest Earnings Variation Across Schools",
       x = "Major",
       y = "Earnings IQR") +
  theme_minimal()

ggsave("figures/highest_variation.png", p4, width = 8, height = 5)

cat("All visualizations saved in /figures folder\n")
