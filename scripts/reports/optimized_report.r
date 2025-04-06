---
title: "Optimized Sales Report"
output: html_document
---

## Optimized Summary Table

```{r}
library(readr)
summary_data <- read_csv("data/processed/summary_data.csv")
head(summary_data)
