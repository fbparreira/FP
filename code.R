#
#
#
# Author: Filipe Parreira
# contact: fbparreira@ualg.pt
#
#
#
#
# Index:
# 1. here()
# 2. column_clean()
# 3. readxlsx_allsheets()
# 4. emptyxlsx()
# 5. writexlsx()
# 6. view_in_excel()
# 7. textplot()














# here()
#
# Description: 
# Sets the WD to the local path where the script is
#
here <- function(){
  
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))
  
  cat("------ Working directory set to: \n",
      getwd())
}


























# column_clean()
# Description:
# Cleans the "."'s in the column's names. An issue where imported .xlsx files with spaces in columns have.
#
# Arguments:
# df - Dataframe object
# dots_to - (default = " ") If "_", replaces the "." to "_". If " " (default), replaces the "." to " ". 
#
# References:
# https://stackoverflow.com/questions/39670918/replace-characters-in-column-names-gsub
column_clean <- function(df){ 
  
    colnames(df) <- gsub("\\.", " ", colnames(df)); df
  
} 























# readxlsx_allsheets()
#
# Description:
# Reads all sheets in a .xlsx to a list
#
# Arguments:
# excel_file - Path to write file
#
# References:
# https://stackoverflow.com/questions/12945687/read-all-worksheets-in-an-excel-workbook-into-an-r-list-with-data-frames
#
readxlsx_allsheets <- function(excel_file, 
                               tibble = FALSE) {
  
  sheets <- readxl::excel_sheets(excel_file)
  
  x <- lapply(sheets, function(X) readxl::read_excel(excel_file, sheet = X))
  if(!tibble) x <- lapply(x, as.data.frame)
  names(x) <- sheets
  x
}



























# emptyxlsx()
#
# Description:
# Creates an empty .xlsx file
#
# Arguments:
# excel_file - Path to write file
# overwrite - (default = TRUE) If TRUE, overwrite any existing file
# 
emptyxlsx <- function(excel_file, 
                      overwrite = TRUE){
  empty_workbook <- openxlsx::createWorkbook()# create an empty cohort_tables_total.xlsx
  openxlsx::saveWorkbook(empty_workbook,
               file = excel_file,
               overwrite = TRUE)
}

















































# writexlsx()
#
# Description:
# Writes an .xlsx file
#
# Arguments:
# df - Dataframe object
# excel_file - Path to write file
# sheet_name - (default = FALSE) Name for the Excel sheet
# append_sheet - (default = FALSE) If TRUE, adds a new sheet to the existing file. A sheet_name is required
# filter - (default = FALSE) If TRUE, applies a filter to the first row
# alt_shading - (default = FALSE) If TRUE, applies alternative fill color (grey and white) base on a variable (alt_shading_var).
# alt_shading_var - Variable within the df to apply the alternative fill color (alt_shading)
# col_width_auto - (default = FALSE) If TRUE, automatically adjusts the column widths according to content
# freeze_first_row - (default = FALSE) If TRUE, freezes the first row
# bottom_border - (default = FALSE) If TRUE, applies a bottom border based on a variable (bottom_border_var)
# bottom_border_var - Variable within the df to apply the bottom border (bottom_border)
#
# References:
# https://github.com/MarcioFCMartins/MMartins/blob/master/R/df_to_xlsx.R
#
writexlsx <- function(df,
                      excel_file, 
                      sheet_name = FALSE, 
                      append_sheet = FALSE,
                      filter = FALSE,
                      alt_shading = FALSE,
                      alt_shading_var,
                      col_width_auto = FALSE,
                      freeze_first_row = FALSE,
                      bottom_border = FALSE,
                      bottom_border_var){
  #if the name is >31, than it's shortened
  if (nchar(sheet_name) > 31) {
    sheet_name <- substr(sheet_name,0,31)
    message("Sheet_name was shortened")
  }
  
  
  
  # append_sheet = TRUE: a new sheet is added to the existent file
  if(append_sheet == TRUE){
    # when append_sheet = TRUE, a sheet_name MUST be provided
    if(sheet_name == F){
      stop("sheet_name is missing!")
    }else{
      # load the existent file
      wb <- openxlsx::loadWorkbook(excel_file)
      # Check if provided sheet name already exists
      if(sheet_name %in% names(wb)){
        stop("Your workbook already has a sheet named: ", sheet_name)
      }
      # add a new sheet
      openxlsx::addWorksheet(wb, sheetName = sheet_name)
      message("New sheet added")
      # add the dataframe to the sheet
      openxlsx::writeData(wb = wb, sheet = sheet_name, x = df)
      # add filter option for the first row
      if(filter == TRUE){
        openxlsx::addFilter(wb = wb, sheet = sheet_name, rows = 1, cols = seq_len(ncol(df)))
        message("Filter applyed to first row")
      }
      # add alternative shading based on a variable
      if(alt_shading == TRUE){
        grey_style <- openxlsx::createStyle(fgFill = "#D9D9D9")  # Light grey background
        no_shading_style <- openxlsx::createStyle(fgFill = "#FFFFFF")  # No shading (white background)
        previous_variable <- "somevariablethatisnevergoingtobeused"
        use_grey <- TRUE # Start with grey
        for (i in 1:nrow(df)) {
          # If the variable changes, toggle the shading
          if(df[[alt_shading_var]][i] != previous_variable){
            use_grey <- !use_grey
          }
          # Apply the corresponding style (grey or white)
          style_to_use <- if (use_grey) grey_style else no_shading_style
          openxlsx::addStyle(wb, 
                             sheet = sheet_name, 
                             style = style_to_use, 
                             rows = i + 1, 
                             cols = 1:ncol(df), 
                             gridExpand = TRUE)
          # Update the previous variable
          previous_variable <- df[[alt_shading_var]][i]
        }
        message(paste("Alternate shading applyed based on factor:",alt_shading_var))
      }
      # add bottom border based on a variable
      if (bottom_border == TRUE){
        border_style <- openxlsx::createStyle(border = "Bottom", 
                                    borderColour = "black")
        # Apply the style only when the variable changes
        for (row in 1:(nrow(df) - 1)) {
          if (df[[bottom_border_var]][row] != df[[bottom_border_var]][row + 1]) {
            openxlsx::addStyle(wb, 
                     sheet_name, 
                     style = border_style, 
                     rows = row + 1, 
                     cols = 1:ncol(df), 
                     gridExpand = TRUE, 
                     stack = TRUE)
          }
        }
        message(paste("Bottom border applyed based on factor:",bottom_border_var))
      }
      # add automatically adjust column widths
      if (col_width_auto == TRUE) {
        openxlsx::setColWidths(wb, sheet = sheet_name, cols = 1:ncol(df), widths = "auto")
        message("Auto adjustment of column widths applyed")
      }
      # add freeze first row
      if (freeze_first_row == TRUE) {
        openxlsx::freezePane(wb, sheet = sheet_name, firstRow = TRUE)
        message("Freeze applyed to first row")
      }
      #Save final excel workbook
      openxlsx::saveWorkbook(wb, excel_file, overwrite = TRUE)
    }
    
    
    
    
  }else{
    # append_sheet = FALSE: a new file is created
    wb <- openxlsx::createWorkbook()
    message("New file was created")
    # If no sheet name is given, name it "Sheet 1"
    if (sheet_name == FALSE) {
      sheet_name = "Sheet 1"
    }
    # add a new sheet
    openxlsx::addWorksheet(wb, sheetName = sheet_name)
    message("New sheet created")
    # add the dataframe to the sheet
    openxlsx::writeData(wb = wb, sheet = sheet_name, x = df)
    # add filter option for the first row
    if(filter == TRUE){
      openxlsx::addFilter(wb = wb, sheet = sheet_name, rows = 1, cols = seq_len(ncol(df)))
      message("Filter applyed to first row")
    }
    # add alternative shading based on a variable
    if(alt_shading == TRUE){
      grey_style <- openxlsx::createStyle(fgFill = "#D9D9D9")  # Light grey background
      no_shading_style <- openxlsx::createStyle(fgFill = "#FFFFFF")  # No shading (white background)
      previous_variable <- "somevariablethatisnevergoingtobeused"
      use_grey <- TRUE # Start with grey
      for (i in 1:nrow(df)) {
        # If the variable changes, toggle the shading
        if(df[[alt_shading_var]][i] != previous_variable){
          use_grey <- !use_grey
        }
        # Apply the corresponding style (grey or white)
        style_to_use <- if (use_grey) grey_style else no_shading_style
        openxlsx::addStyle(wb, 
                           sheet = sheet_name, 
                           style = style_to_use, 
                           rows = i + 1, 
                           cols = 1:ncol(df), 
                           gridExpand = TRUE)
        # Update the previous variable
        previous_variable <- df[[alt_shading_var]][i]
      }
      message(paste("Alternate shading applyed based on factor:",alt_shading_var))
    }
    # add bottom border based on a variable
    if (bottom_border == TRUE){
      border_style <- openxlsx::createStyle(border = "Bottom", 
                                  borderColour = "black")
      # Apply the style only when the variable changes
      for (row in 1:(nrow(df) - 1)) {
        if (df[[bottom_border_var]][row] != df[[bottom_border_var]][row + 1]) {
          openxlsx::addStyle(wb, 
                   sheet_name, 
                   style = border_style, 
                   rows = row + 1, 
                   cols = 1:ncol(df), 
                   gridExpand = TRUE, 
                   stack = TRUE)
        }
      }
      message(paste("Bottom border applyed based on factor:",bottom_border_var))
    }
    # add automatically adjust column widths
    if (col_width_auto == TRUE) {
      openxlsx::setColWidths(wb, sheet = sheet_name, cols = 1:ncol(df), widths = "auto")
      message("Auto adjustment of column widths applyed")
    }
    # add freeze first row
    if (freeze_first_row == TRUE) {
      openxlsx::freezePane(wb, sheet = sheet_name, firstRow = TRUE)
      message("Freeze applyed to first row")
    }
    #Save final excel workbook
    openxlsx::saveWorkbook(wb, excel_file, overwrite = TRUE)
  }
}


























































# view_in_excel()
#
# Description:
# Open a df directly in Excel, creating a temporary file. Alternative to the base View().
#
# Arguments:
# df - Dataframe object
# filter - (default = TRUE) Applies a filter to the first row
# alt_shading - (default = FALSE) If TRUE, applies alternative fill color (grey and white) base on a variable (alt_shading_var).
# alt_shading_var - variable within the df to apply the alternative fill color (alt_shading)
# col_width_auto - (default = TRUE) Automatically adjusts the column widths according to content
# freeze_first_row - (default = TRUE) Freezes the first row
# bottom_border - (default = FALSE) If TRUE, applies a bottom border based on a variable (bottom_border_var)
# bottom_border_var - Variable within the df to apply the bottom border (bottom_border)
#
# Dependencies:
# writexlsx()
#
# References:
# https://stackoverflow.com/questions/12164897/quickly-view-an-r-data-frame-vector-or-data-table-in-excel
#
view_in_excel <- function(df, 
                          filter = T,
                          alt_shading = FALSE,
                          alt_shading_var,
                          col_width_auto = TRUE,
                          freeze_first_row = TRUE,
                          bottom_border = FALSE,
                          bottom_border_var) {
  
  # path to temporary excel file
  excel_file = tempfile(pattern = "temp_file", 
                        fileext = ".xlsx")
  
  # Check OS type
  os_type <- .Platform$OS.type
  
  # Write the dataframe to an Excel file
  writexlsx(df = df, 
            excel_file = excel_file, 
            filter = filter,
            alt_shading = alt_shading, 
            alt_shading_var = alt_shading_var,
            col_width_auto = col_width_auto,
            freeze_first_row = freeze_first_row,
            bottom_border = bottom_border,
            bottom_border_var = bottom_border_var)
  
  
  print(paste("Temporary file path:", excel_file))
  
  # Define the command to open the file
  if (os_type == "windows") {
    shell.exec(excel_file)  # Open in Excel on Windows
  } else if (os_type == "unix" && grepl("darwin", R.version$os)) {
    system2("open", excel_file)  # Open in Excel on Mac
  } else {
    stop("Unsupported OS")
  }
}

































# textplot()
#
# Description: 
# Plots text as a base plot
#
# Arguments:
# text - Text to be plotted
# size - Size of the text in the plot
# 
textplot <- function(text = text, size = cex){
  
  plot(1, type = "n", xlab = "", ylab = "", axes = FALSE)
  
  text(1, 1, labels = text, cex = size)
}

