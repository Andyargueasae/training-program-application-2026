# ---------------------------------------------------------

# Melbourne Bioinformatics Training Program

# This exercise to assess your familiarity with R and git. Please follow
# the instructions on the README page and link to your repo in your application.
# If you do not link to your repo, your application will be automatically denied.

# Leave all code you used in this R script with comments as appropriate.
# Let us know if you have any questions!


# You can use the resources available on our training website for help:
# Intro to R: https://mbite.org/intro-to-r
# Version Control with Git: https://mbite.org/intro-to-git/

# ----------------------------------------------------------

# Load libraries -------------------
# You may use base R or tidyverse for this exercise
library(tidyverse)
library(ggplot2)
library(dplyr)
library(tidyr)
# ex. library(tidyverse)

# Load data here ----------------------
# Load each file with a meaningful variable name.
data <- read.csv("/data/training-program-application-2026/data/GSE60450_GeneLevel_Normalized(CPM.and.TMM)_data.csv")
metadata <- read.csv("/data/training-program-application-2026/data/GSE60450_filtered_metadata.csv")

# Inspect the data -------------------------

# What are the dimensions of each data set? (How many rows/columns in each?)
# Keep the code here for each file.
## Expression data
dim(data)

## Metadata
dim(metadata)

# Prepare/combine the data for plotting ------------------------
# How can you combine this data into one data.frame?

sample_id=colnames(data)[3:ncol(data)] # Get the sample IDs from the data columns (excluding the 'Gene' column)


expr_long <- data %>%
  rename(ensembl_id = X) %>%                               # optional: clearer name
  pivot_longer(
    cols = starts_with("GSM"),
    names_to = "sample_id",
    values_to = "expr"
  )
  # no columns called gene.
meta2 <- metadata %>%
  rename(sample_id = X)  # metadata sample id column

merged_long <- expr_long %>%
  left_join(meta2, by = "sample_id")
# Plot the data --------------------------
## Plot the expression by cell type
## Can use boxplot() or geom_boxplot() in ggplot2

# ggplot(merged_long, aes(x = immunophenotype, y = expr)) +
#   geom_boxplot() +
#   labs(title = "Gene Expression by Cell Type",
#        x = "immunophenotype",
#        y = "Expression (CPM/TMM)") +
#   theme_minimal()
# ggsave("/data/training-program-application-2026/results/gene_expression_by_cell_type.png", width = 8, height = 6)


boxplot(expr ~ immunophenotype, data = merged_long,
        main = "Gene Expression by Cell Type",
        xlab = "immunophenotype",
        ylab = "Expression (CPM/TMM)")

## Save the plot
### Show code for saving the plot with ggsave() or a similar function
png("/data/training-program-application-2026/results/gene_expression_by_cell_type.png", width = 800, height = 600)
