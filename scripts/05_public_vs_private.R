library(tidyverse)
library(scales)

# ---------------------------
# STEP 1: Load cleaned data
# ---------------------------
fos_clean <- read_csv("data/processed/fos_clean.csv", show_col_types = FALSE)

# ---------------------------
# STEP 2: Sector-level summary
# ---------------------------
sector_summary <- fos_clean %>%
  group_by(institution_type) %>%
  summarise(
    median_earnings_1yr = median(earnings_1yr, na.rm = TRUE),
    median_earnings_5yr = median(earnings_5yr, na.rm = TRUE),
    median_growth = median(earnings_growth, na.rm = TRUE),
    program_count = n(),
    .groups = "drop"
  ) %>%
  filter(institution_type != "Foreign")

print(sector_summary)

# ---------------------------
# STEP 3: Visualization
# ---------------------------
p_sector <- ggplot(sector_summary,
                   aes(x = institution_type,
                       y = median_earnings_5yr,
                       fill = institution_type)) +
  geom_col() +
  scale_y_continuous(labels = dollar) +
  labs(title = "5-Year Median Earnings: Public vs Private",
       x = "Institution Type",
       y = "Median 5-Year Earnings") +
  theme_minimal() +
  theme(legend.position = "none")

ggsave("figures/public_vs_private.png", p_sector, width = 6, height = 4)

cat("Public vs Private analysis complete.\n")

