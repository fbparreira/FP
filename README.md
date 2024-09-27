README
================

# FP

## Overview

`FP` is a collection of my personal functions that I use in my workflow.
The goal is to make my workflow easier by either creating functions to
address simple tasks or build on existing packages to mold the functions
to my personal needs. “Stolen” ideas from here and there are referenced.

## Installation

All `FP` functions are on the same script. Once loaded, all functions
will be available on `Global Environment`. To load the functions you can
source the script as follows:

``` r
source("https://raw.githubusercontent.com/fbparreira/FP/main/code.R")
```

## Functions

| **Name** | **Description** |
|:--:|:--:|
| `here()` | Sets the `wd` to the local path where the script is. |
| `column_clean()` | Cleans the `.` in the column’s names. An issue where imported `.xlsx` files with spaces in columns have. |
| `readxlsx_allsheets()` | Reads all sheets in a `.xlsx` to a list. |
| `emptyxlsx()` | Creates an empty `.xlsx` file. |
| `writexlsx()` | Writes an `.xlsx` file. |
| `view_in_excel()` | Open a `df` directly in Excel, creating a temporary file. Alternative to the base `View()`. |
| `textplot()` | Plots text as a base `plot()`. |

## `here()`

### Description

When you are working on a script not within an `R project`, instead of
using `setwd()` to manually paste the path, just run `here()`.

### Usage

``` r
here()
```

## `column_clean()`

### Description

When importing `.xlsx` files using `openxlsx::read.xlsx` (my preferred
package for dealing with `.xlsx` files) to a `df`, the white spaces in
the column names are translated to `.`. The `column_clean` function
restores the white spaces from those `.`.

### Usage

``` r
column_clean(df)
```

### Arguments

- `df` A Dataframe object.

## `readxlsx_allsheets()`

### Description

Imports all sheets of an `.xlsx` file to a list.

### Usage

``` r
readxlsx_allsheets(excel_file)
```

### Arguments

- `excel_file` Path to the `.xlsx` file.

### Example

``` r
# Import all sheets from `file.xlsx` to a list (`list_of_file_sheets`).
list_of_file_sheets <- 
  readxlsx_allsheets(excel_file = "path/to/file.xlsx")

# Assign the sheet named `sheet_name` to a `df`
df <- 
  list_of_file_sheets[["sheet_name"]]
```
