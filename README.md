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

    source("https://raw.githubusercontent.com/fbparreira/FP/main/code.R")

Once loaded, all functions will be visible on `Global Environment`.

### Functions

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
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
<td style="text-align: center;">Sets the WD to the local path where the
script is</td>
</tr>
<tr class="even">
<td style="text-align: center;"><code>column_clean()</code></td>
<td style="text-align: center;">Cleans the ‘.’ in the column’s names. An
issue where imported .xlsx files with spaces in columns have.</td>
</tr>
<tr class="odd">
<td style="text-align: center;"><code>readxlsx_allsheets()</code></td>
<td style="text-align: center;">Reads all sheets in a .xlsx to a
list</td>
</tr>
</tbody>
</table>
