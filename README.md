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

    source("https://raw.githubusercontent.com/fbparreira/FP/main/code.R")

## Functions

<table>
<colgroup>
<col style="width: 44%" />
<col style="width: 55%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: center;"><strong>Name</strong></th>
<th style="text-align: center;"><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: center;"><code>here()</code></td>
<td style="text-align: center;">Sets the <code>wd</code> to the local
path where the script is.</td>
</tr>
<tr class="even">
<td style="text-align: center;"><code>column_clean()</code></td>
<td style="text-align: center;">Cleans the <code>.</code> in the
column’s names. An issue where imported <code>.xlsx</code> files with
spaces in columns have.</td>
</tr>
<tr class="odd">
<td style="text-align: center;"><code>readxlsx_allsheets()</code></td>
<td style="text-align: center;">Reads all sheets in a <code>.xlsx</code>
to a list.</td>
</tr>
<tr class="even">
<td style="text-align: center;"><code>emptyxlsx()</code></td>
<td style="text-align: center;">Creates an empty <code>.xlsx</code>
file.</td>
</tr>
<tr class="odd">
<td style="text-align: center;"><code>writexlsx()</code></td>
<td style="text-align: center;">Writes an <code>.xlsx</code> file.</td>
</tr>
<tr class="even">
<td style="text-align: center;"><code>view_in_excel()</code></td>
<td style="text-align: center;">Open a <code>df</code> directly in
Excel, creating a temporary file. Alternative to the base
<code>View()</code>.</td>
</tr>
<tr class="odd">
<td style="text-align: center;"><code>textplot()</code></td>
<td style="text-align: center;">Plots text as a base
<code>plot()</code>.</td>
</tr>
</tbody>
</table>

## `here()`

### Description

When you are working on a script not within an `R project`, instead of
using `setwd()` to manually paste the path, just run `here()`.

### Usage

    here()

    ## ------ Working directory set to: 
    ##  D:/LIBRARY/Statistic/R/GitHub/FP

## `column_clean()`

### Description

When importing `.xlsx` files using `openxlsx::read.xlsx` (my preferred
package for dealing with `.xlsx` files) to a `df`, the white spaces in
the column names are translated to `.`. The `column_clean` function
replaces those `.` by `" "`.

### Usage

    column_clean(df)

    ##   a b c d
    ## 1   1   1
    ## 2   0   2
    ## 3  23   3

### Arguments

\*`df` - A Dataframe object.
