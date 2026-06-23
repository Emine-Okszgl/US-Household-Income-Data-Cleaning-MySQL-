# US Household Income Data Cleaning

## Project Overview
This project focuses on cleaning the US Household Income dataset using MySQL.  
The purpose of this project is to identify and fix data quality issues before performing exploratory data analysis.

## Tools Used
- MySQL
- MySQL Workbench

## Data Cleaning Steps
- Imported CSV files into MySQL
- Renamed incorrect column caused by encoding issue
- Checked total record counts
- Identified duplicate records
- Removed duplicate rows using ROW_NUMBER()
- Standardized misspelled state names
- Checked and corrected empty Place values
- Standardized Type values
- Checked land and water area values

## Key Cleaning Actions
- Fixed `georia` to `Georgia`
- Fixed missing Place value for Autauga County
- Changed `Boroughs` to `Borough`
- Removed duplicate records from the dataset

## Next Step
After cleaning the dataset, I will continue with Exploratory Data Analysis using SQL.
