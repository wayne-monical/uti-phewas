
# title: "Building the website"
# author: "Wayne Monical"
# date: "2026-02-03"


# description: Run this R script to generate the website from the Rmd files.
# includes generating pages for each variant from the template


# loading libraries
library(tidyverse)
library(rmarkdown)

# read in all variants, and a get a list of variants
variants  = 
  read_csv('data/all_data.csv', show_col_types = FALSE) |> 
  mutate(
    snp = paste(chrom, pos, reference, alternate, sep = "-")) |> 
  pull(snp) |> 
  unique()


# generate html pages 
for (var in variants) {
  print(paste0('Rendering ', var))
  render(
    input = "variant_template.Rmd",
    # Dynamically name the output file
    output_file = paste0(var, ".html"), 
    output_dir = 'variants', 
    # Pass the variant to the template
    params = list(variant_id = var),
    quiet = TRUE
  )
}


# render home page
render(input = "index.Rmd", output_file = "index.html")

