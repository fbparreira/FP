# FP

## Overview

`FP` is a collection of my personal functions that I use in my workflow.
The goal is to make my workflow easier by either creating functions to
address simple tasks or build on existing packages to mold the functions
to my personal needs. “Stolen” ideas from here and there are referenced
in the script.

## Usage

### Installation

All `FP` functions are on the same script. To load the functions you can
source the script as follows:

``` r
source("https://raw.githubusercontent.com/fbparreira/FP/main/code.R")
```

Once loaded, all functions will be visible on `Global Environment`.

### Functions

| **Name** | **Description** |
|:--:|:---:|
|`here()`|Sets the `wd` to the local path where the script is.|
|`column_clean()`|Cleans the `.` in the column's names. An issue where imported `.xlsx` files with spaces in columns have.|
|`readxlsx_allsheets()`|Reads all sheets in a `.xlsx` to a list.|
|`emptyxlsx()`|Creates an empty `.xlsx` file.|
|`writexlsx()`|Writes an `.xlsx` file.|
|`view_in_excel()`|Open a `df` directly in Excel, creating a temporary file. Alternative to the base `View()`.|
|`textplot()`|Plots text as a base `plot()`.|
