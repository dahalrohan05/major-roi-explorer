# Major Earnings Explorer

## Overview

Major Earnings Explorer is a business analytics project that evaluates U.S. bachelor’s majors using College Scorecard field-of-study data. The project focuses on comparing majors by early-career earnings, 5-year earnings, earnings growth, and variation across institutions.

The goal is to move beyond intuition and compare fields of study using a structured, data-driven framework.

## Business Question

Which bachelor’s majors lead to stronger earnings outcomes, faster earnings growth, and more consistent results across institutions?

## Data Source

- College Scorecard Field-of-Study data
- File used: `FieldOfStudyData1920_2021_PP.csv`

## Project Scope

- Bachelor’s degree programs only
- Main outcome: 5-year median earnings
- Additional metrics:
  - 1-year median earnings
  - earnings growth
  - earnings growth percentage
  - earnings variation across schools (IQR)
- Additional cuts:
  - Texas-only summary
  - public vs private comparison

## Methods Used

This project uses descriptive and comparative analytics in R.

Main methods:
- data cleaning and transformation
- grouped summary statistics
- median-based comparisons
- interquartile range (IQR) for variation
- ranking and flagging
- segmentation by institution type and Texas-specific slice
- visualization and reporting

## Key Metrics

- **Earnings 1 Year** = median earnings one year after completion
- **Earnings 5 Years** = median earnings five years after completion
- **Earnings Growth** = Earnings 5 Years - Earnings 1 Year
- **Earnings Growth %** = (Earnings 5 Years - Earnings 1 Year) / Earnings 1 Year
- **Earnings Variation** = IQR of 5-year earnings across institutions for the same major

## Key Findings

- In the unrestricted ranking, **Biomathematics/Bioinformatics/Computational Biology** and **Operations Research** had the highest 5-year median earnings.
- Among majors with broader representation across institutions, **Computer Engineering** and **Computer Science** were among the strongest-performing fields.
- Some majors showed high long-term earnings but also large variation across schools, suggesting that institution choice matters.
- Texas-specific summaries added local relevance, and public-versus-private comparisons added another useful segmentation layer.

## Project Structure

```text
major-roi-explorer/
  data/
    raw/
    processed/
  scripts/
  figures/
  reports/
  README.md
  .gitignore
  major-roi-explorer.Rproj