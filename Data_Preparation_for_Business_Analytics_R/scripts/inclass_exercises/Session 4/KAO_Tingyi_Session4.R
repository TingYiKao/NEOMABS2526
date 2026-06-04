library(tidyverse)

names <- c("DRG", "ProviderID", "Name", 
           "Address", "City", "State", "ZIP", 
           "Region", "Discharges", "AverageCharges", 
           "AverageTotalPayments", "AverageMedicarePayments")
types = 'ccccccccinnn'
inpatient <- read_tsv('inpatient.tsv', 
                      col_names = names, 
                      skip=1, 
                      col_types = types)
# Find the unique values
unique(inpatient$DRG)

# Separate DRG
## separate(data, col, into, sep, remove, convert)
inpatient_separate <- inpatient |>
                      separate(col = DRG, 
                               into = c('DRGCode', 'DRGDescription'),
                               sep = '-')
inpatient$DRG[45894]
# 246 - PERC CARDIOVASC PROC W DRUG-ELUTING STENT W MCC OR 4+ VESSELS/STENTS ' - ' vs. '-'
unique(inpatient_separate$DRGCode)
unique(inpatient_separate$DRGDescription)

inpatient_separate <- inpatient |>
                      separate(col = DRG, 
                               into = c('DRGCode', 'DRGDescription'),
                               sep = ' - ')
# Separate by the first 4 digits, containing s space
inpatient_separate <- inpatient |>
                      separate(col = DRG, 
                               into = c('DRGCode', 'DRGDescription'),
                               3)
unique(inpatient_separate$DRGCode)


inpatient_separate <- inpatient_separate |>
                      separate(col = DRGDescription, 
                               into = c('waste', 'DRGDescription'),
                               3)
?select
# select(.data, ...)
inpatient_separate <- select(inpatient_separate, -waste)
# separate_wider_delim(data, cols, delim, names, cols_remove)

#> # separate_wider_delim(data, cols, delim, names, cols_remove)
inpatient_separate <- inpatient |>
                        separate_wider_delim(cols = DRG,
                                             names = c('DRGCode', 'DRGDescription'),
                                             delim = '-')
# Use `too_many = "debug"` to diagnose the problem.
# Use `too_many = "drop"/"merge"` to silence this message.
inpatient_separate <- inpatient |>
                      separate_wider_delim(cols = DRG,
                                           names = c('DRGCode', 'DRGDescription'),
                                           delim = '-',
                                           too_many = 'merge')
unique(inpatient_separate$DRGCode)
unique(inpatient_separate$DRGDescription)
# separate_wider_position(data, cols, widths, cols_remove)
## Format: 'XXX - XXXXXXXXXX...'
inpatient_separate <- inpatient |>
                      separate_wider_position(cols=DRG,
                                              widths=c(DRGcode = 3, 3, DRGdescription=200), 
                                              too_few="debug")
inpatient_separate <- select(inpatient_separate, 
                             -c('DRG', 'DRG_ok', 'DRG_width', 'DRG_remainder'))

# Unite
## unite(data, col, ..., sep, remove)
## remove = TRUE or FALSE
names <- c("ID", "DBAName", "AKAName", "License", "FacilityType", "Risk", 
           "Address", "City", "State", "ZIP", "InspectionDate", "InspectionType", "Results",
           "Violations", "Latitude","Longitude","Location")
inspections <- read_csv('inspections.csv', col_names=names, skip=1)
glimpse(inspections)

regional_inspections <- inspections |>
                        unite(col = Region, 
                              City, State, 
                              sep = ', ', 
                              remove = FALSE)
glimpse(regional_inspections)

unique(regional_inspections$Region)

#----------------------Exercises------------------------
# Exercise 4.1
# a) Import the data-messy.xlsx file as rainfall. Pay attention to the right header.
# b) Separate the month and the period into two columns.
# c) Remove mm from the data where it is necessary and change the data type (to prepare for later analysis).
# d) Restructure data, the geographical location should be a variable (call it “Place”). 
## The new numeric variable should be called “rainfall”.
# e) Take a look at the database now. Propose an additional change (and explain shortly why) and execute it.

# Exercise 4.3
# Go back to Exercise 3.2 and solve the remaining problems with the athletes’ data. 
library(readxl)
messy <- read_excel('messy-data.xlsx', sheet = 1)

glimpse(messy)

messy <- read_excel('messy-data.xlsx', sheet = 1, skip = 1)
messy
messy_separate <- messy |>
                  separate(col = 'Month, period',
                           into = c('Month', 'Period'),
                           sep = ',')
glimpse(messy_separate)

messy_separate <- messy_separate |>
                  separate_wider_delim(cols = 'Lake Victoria',
                                       names = c('LakeVictoria'),
                                       delim = 'mm',
                                       too_many = 'drop')
messy_separate <- messy_separate |>
                  separate_wider_delim(cols = Simiyu,
                                       names = 'Simiyu',
                                       delim = 'mm',
                                       too_many = 'drop')
glimpse(messy_separate)
messy_separate$LakeVictoria <- as.numeric(messy_separate$LakeVictoria)
messy_separate$Simiyu <- as.numeric(messy_separate$Simiyu)

messy_separate.long <- pivot_longer(messy_separate, cols = -1:-2, names_to = 'Place', values_to = 'Rainfall')


# Exercise 4.2
# a) Read the coffeeshop.csv file to a data frame as it is using the tidyverse library. 
## Do not change variable types and names.
# b) The data frame is not tidy. Explain what is wrong and why.
# c) Using pivot functions, restructure the data frame.
# d) Clean the first column, it should be named ‘Beverage_category’ and should have only text, but no … or numbers.
# e) Check the unique values of Total fat and Caffeine. What problems do you see with them?

# Exercise 4.4
# Go back to Exercise 3.6 and solve the remaining problems with the sales data. 
coffeeshop <- read_csv('coffeeshop.csv')
coffeeshop_df <- data.frame(coffeeshop)
glimpse(coffeeshop)

# The SalesItem should be developed to cover all different coffee types
coffeeshop_df_Item <- coffeeshop_df |>
                      pivot_longer(cols = -1,
                                   names_to = 'SalesItem',
                                   values_to = 'Values') |>
                      pivot_wider(names_from = Beverage_category,
                                  values_from = Values)
#> # separate_wider_delim(data, cols, delim, names, cols_remove)
coffeeshop_df_Item <- coffeeshop_df_Item |>
                      separate_wider_delim(col = SalesItem,
                                           names = c('Item', 'ItemNumber'),
                                           delim = '...')
coffeeshop_df_Item <- select(coffeeshop_df_Item, -ItemNumber)

unique(coffeeshop_df_Item$'Total Fat (g)')
is.numeric(coffeeshop_df_Item$'Total Fat (g)')
unique(coffeeshop_df_Item$'Caffeine (mg)')

# The column 'Caffeine' contains missing values and non-numerical data.
# Assuming that other columns have the similar situation.
?remove_missing
coffeeshop_df_Item <- replace(coffeeshop_df_Item, 'Varies', 0)


glimpse(coffeeshop_df_Item)
coffeeshop_df_Item <- coffeeshop_df_Item |>
                      mutate(Calories = as.numeric(Calories),
                             'Total Fat (g)' = as.numeric('Total Fat (g)'),
                             'Trans Fat (g)' = as.numeric('Trans Fat (g)'),
                             'Saturated Fat (g)' = as.numeric('Saturated Fat (g)'),
                             'Sodium (mg)' = as.numeric('Sodium (mg)'),
                             'Total Carbohydrates (g)' = as.numeric('Total Carbohydrates (g)'),
                             'Cholesterol (mg)' = as.numeric('Cholesterol (mg)'),
                             'Dietary Fibre (g)' = as.numeric('Dietary Fibre (g)'),
                             'Sugars (g)' = as.numeric('Sugars (g)'),
                             'Protein (g)' = as.numeric('Protein (g)'),
                             'Vitamin A (% DV)' = as.numeric('Vitamin A (% DV)'),
                             'Vitamin C (% DV)' = as.numeric('Vitamin C (% DV)'),
                             'Calcium (% DV)' = as.numeric('Calcium (% DV)'),
                             'Iron (% DV)' = as.numeric('Iron (% DV)'),
                             'Caffeine (mg)' = as.numeric('Caffeine (mg)'))
