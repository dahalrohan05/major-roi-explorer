library(tidyverse)

# ---------------------------
# STEP 1: Load cleaned data
# ---------------------------
fos_clean <- read_csv("data/processed/fos_clean.csv", show_col_types = FALSE)

# ---------------------------
# STEP 2: Remove extreme outliers (optional but good practice)
# ---------------------------
fos_clean <- fos_clean %>%
  filter(
    earnings_5yr > 1000,
    earnings_5yr < 500000
  )

# ---------------------------
# STEP 3: Create major-level summary
# ---------------------------
major_summary <- fos_clean %>%
  group_by(major_name) %>%
  summarise(
    median_earnings_1yr = median(earnings_1yr, na.rm = TRUE),
    median_earnings_5yr = median(earnings_5yr, na.rm = TRUE),
    median_growth = median(earnings_growth, na.rm = TRUE),
    median_growth_pct = median(earnings_growth_pct, na.rm = TRUE),
    earnings_variation = IQR(earnings_5yr, na.rm = TRUE),
    school_count = n(),
    .groups = "drop"
  )

# ---------------------------
# STEP 4: Create ranking metrics
# ---------------------------
major_summary <- major_summary %>%
  mutate(
    earnings_rank = dense_rank(desc(median_earnings_5yr)),
    growth_rank = dense_rank(desc(median_growth)),
    consistency_rank = dense_rank(earnings_variation)
  )

# ---------------------------
# STEP 5: Create flags
# ---------------------------
earnings_cutoff <- quantile(
  major_summary$median_earnings_5yr,
  0.25,
  na.rm = TRUE
)

growth_cutoff <- quantile(
  major_summary$median_growth,
  0.75,
  na.rm = TRUE
)

major_summary <- major_summary %>%
  mutate(
    low_earnings_flag = median_earnings_5yr <= earnings_cutoff,
    high_growth_flag = median_growth >= growth_cutoff
  )

# ---------------------------
# STEP 6: Save results
# ---------------------------
write_csv(major_summary, "data/processed/major_summary.csv")

cat("Saved major_summary.csv successfully\n")

# Quick preview
print(head(major_summary))

