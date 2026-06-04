# Load the package
library(tidyverse)
# "read_" manner is for tidyverse
# "read." manner is for basic R

# Load the inspections csv (quotation mark)
inspections <- read_csv("/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/inspections.csv")

# Take a glimpse/Check
glimpse(inspections)

# Remove space in certain names
names <- c("ID", "DBAName", "AKAName", "License", "FacilityType", "Risk", "Address", 
           "City", "State", "ZIP", "InspectionDate", "InspectionType", "Results",
           "Violations", "Latitude", "Longitude", "Location")
inspections <- read_csv("/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/inspections.csv", 
                        col_names=names)
glimpse(inspections)

# Skip the first row, allow R to recognize the data type accurately.
## skip argument = 2, remove the first two rows 
inspections <- read_csv("/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/inspections.csv", 
                        col_names=names, skip = 1)
glimpse(inspections)
#----------------------------------------------
# Load the inpatient csv
inpatient <- read_tsv("/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/inpatient.tsv")
glimpse(inpatient)

names <- c("DRG", "ProviderID", "Name", "Address", "City", "State", 
           "ZIP", "Region", "Discharges", "AverageCharges", "AverageTotalPayments", "AverageMedicarePayments")
inpatient <- read_tsv('/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/inpatient.tsv', col_names = names, skip=1)
glimpse(inpatient)

?read_tsv # set the columns types

# c: character; i:integer; n:number (less specific than double)
types = 'ccccccccinnn'
inpatient <- read_tsv('/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/inpatient.tsv', 
                      col_names = names, skip=1, col_types = types) 
glimpse(inpatient)
#----------------------------------------------
read_delim('/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/inspections.csv', 
           delim = ",")
read_delim('/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/inpatient.tsv', 
           delim = "\t")
#----------------------------------------------
# Fix fixed width files (how to count/estimate the blank space)
lengths <- c(32,50,24,NA)

names <- c("Name", "Title", "Department", "Salary")
widths <- fwf_widths(lengths, names)

?read_fwf()
employees <- read_fwf('/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/chicagoemployees.txt', widths, skip=1) 
glimpse(employees)
#----------------------------------------------
# Excel files
library(readxl)

chickens <- read_excel("/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/chickens.xlsx")
#read_xls() read_xlsx() They are two other different excel file format
?read_excel

glimpse(chickens)
#----------------------------------------------
# Web pages
library(tidyverse)
library(rvest)
html <- read_html("https://en.wikipedia.org/w/index.php?title=The_Lego_Movie&oldid=998422565") 
lego <- html_table(html_element(html, ".tracklist"))
lego

#----------------------Exercises------------------------
# Exercise 2.1
# a) Import the workstoppages.txt file from your working directory. Hint: find out the delimiter.
# b) Use glimpse to check the file structure.
workstoppages <- read_file('/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/workstoppages.txt')

?read_file

workstoppages

?read_delim
workstoppages <- read_delim(workstoppages, delim = "^")
glimpse(workstoppages)

# Exercise 2.2
# a) Import the breakfast.xlsx file from your working directory (skip unnecessary rows, add variable names as needed).
## Hint1: If it is not there, you can download from Courses, unzip, and copy to the right folder. 
## Hint2: Checking the file in Excel BEFORE the operation can be very helpful.
# b) Transform your values to logical units (persons instead of millions or thousands, decimals instead of percentages).
## Hint3: mutate() can help.

breakfast <- read_excel('/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/breakfast.xlsx')
glimpse(breakfast)

?read_excel

names <- c("FiscalYears", "Free", "Red.Price", "Paid", "Total", "MealsServed", "FreeRPofTotalMeals")
types = "Dnnnnnn"
breakfast <- read_excel('/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/breakfast.xlsx', 
                        col_names = names, skip = 5, col_types = types)
glimpse(breakfast)

?mutate
breakfast <- data.frame(breakfast)
mutate(breakfast, Free = Free * 1000000, Red.Price = Red.Price *1000000, Paid = Paid *1000000,
       Total = Total * 1000000, MealsServed = MealsServed * 1000000, FreeRPofTotalMeals = FreeRPofTotalMeals/100)

# Exercise 2.3
# a) Try to import the employees_broken.txt file. Figure out the type.
# b) Check what part of the file is not data, but metadata.
# c) For the import, use col_names = c("id", "name", "birthdate", "gender", "salary")
# d) List further problems (we will see solutions for additional problems later)
# e) Restart with the employees_broken2.txt file. Good luck!
employees_broken <- read_file('/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/employees_broken.txt')
glimpse(employees_broken)

employees_broken <- read_fwf('/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/employees_broken.txt')
glimpse(employees_broken)
# The first three rows are metadata
employees_broken <- read_fwf('/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/employees_broken.txt', skip = 3)
glimpse(employees_broken)

?separate()

employees_broken <- data.frame(employees_broken)
glimpse(employees_broken)
employees_broken <- employees_broken %>%
                    separate(X1, into = c("id", "name"), sep = 3)
employees_broken <- employees_broken %>%
                    separate(X2, into = c("birthdate", "gender"), sep = 8)
colnames(employees_broken)[5] <- "salary"
glimpse(employees_broken)

employees_broken2 <- read_file('/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/employees_broken2.txt')
glimpse(employees_broken2)

employees_broken2 <- read_fwf('/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/employees_broken2.txt')
glimpse(employees_broken2)
# The first three rows are metadata
employees_broken2 <- read_fwf('/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/employees_broken2.txt', skip = 3)
glimpse(employees_broken2)

lengths <- c(3,13,8,1,5)
names <- c("id", "name", "birthdate", "gender", "salary")
widths <- fwf_widths(lengths, names)
employees_broken2 <- read_fwf('/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/employees_broken2.txt', widths, skip = 3)
glimpse(employees_broken2)

# Exercise 2.4
# a) Read the planets.xlsx file into a data frame planets.
# b) Calculate the average mass of the planets (use the mean function and subsetting data as you learned in Session 1). 
planets <- read_excel('/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/planets.xlsx')
glimpse(planets)
planets <- read_excel('/Users/kao900531/Documents/Non-app/NEOMA MSc Business Analytics/Data Preparation for Business Analytics/Data/planets.xlsx', sheet = 2)
glimpse(planets)
planets <- data.frame(planets)
mass <- as.numeric(planets[1,2:9])
mean(mass)

# Exercise 2.5
# a) Import the “database test.sav” file. 
# b) Check the structure of this dataset. Compare the imported database as tibble, and as dataframe.
library(haven)
db_test <- read_sav('database test.sav')
glimpse(db_test)

library(tibble)
db_test_tibble <- tibble(db_test)
glimpse(db_test_tibble)

db_test_df <- data.frame(db_test)
glimpse(db_test_df)

