library(readxl)
library(tidyverse)

#----------------------------------------------
dataHR <- read_excel("dataHR_labeled.xlsx")

head(dataHR, 10)
tail(dataHR, 10)

summary(dataHR)

?table
table(dataHR$sex)
table(dataHR$edu)

# boxplot()
boxplot(dataHR$age)
# Examine the outliers (1.5 times of upper and lower quartile)

# Show the cross relationship
table(dataHR$sex, dataHR$jobtitle)

# prop.table() transform tables into proportion
prop.table(table(dataHR$sex, dataHR$edu)) 
prop.table(table(dataHR$sex, dataHR$edu), 1) # first dimension -> rows
prop.table(table(dataHR$sex, dataHR$edu), 2) # second dimension -> columns

#----------------------------------------------
whitehouse <- read_csv("whitehouse.csv", 
                       col_types = 'ccncci')

boxplot(whitehouse$Salary)
summary(whitehouse$Salary)

whitehouse |> filter(Salary > mean(Salary)*1.5)
boxplot(whitehouse$Salary)

whitehouse |> filter(Name == "Case, Michael A.")
whitehouse |> filter(Name == "Blair, Patricia A.")

whitehouse <- whitehouse %>%
              mutate(Salary = ifelse(Salary > 1000000, 98669, Salary))

whitehouse <- whitehouse %>%
              mutate(Salary = ifelse(Salary > 1000000, Salary/100, Salary))
boxplot(whitehouse$Salary)

#----------------------------------------------
tests <- read_csv("testscores.csv")

summary(tests)

boxplot(tests$age)

tests |> filter(age > 15)

tests <- tests |>
         mutate(age = ifelse(studentID == 10115, 7, age)) |>
         mutate(age = ifelse(studentID == 10116, 12, age))
tests <- tests |>
         mutate(age = ifelse(age > 15, grade = 5, age))

boxplot(tests$age)
# ~ put multiple variables together
boxplot(tests$age ~ tests$grade)

#----------------------------------------------
residents <- read_csv('residents.csv', col_types = 'iillll')

summary(residents)
residents |> filter(ownsHome == rentsHome)

#----------------------Exercises------------------------
# Exercise 6.1.
# a) Load the “dirty petal.csv” file.
# b) Search for outliers and propose a solution for them. Solve them with your proposal.
# c) Propose a solution for the NAs using the information in the dataset only. 
## Implement your proposal. Attention: now there are more Nas than yesterday. 
## You replaced outliers with NA, and they counter-attack. May the force with you.
petal = read_csv('dirty petal.csv')

summary(petal)
boxplot(petal$Sepal.Length)
# sepal length cannot be 0 or greater than 10.
boxplot(petal$Sepal.Width)
# sepal width cannot be 0, negative or even greater than 10.
boxplot(petal$Petal.Length)
# petal length cannot be 0 or greater than 10.
boxplot(petal$Petal.Width) # Inf appears
# 0 -> may suggest that there is no sepal or petal.

petal <- petal |>
         mutate(Sepal.Length = ifelse(Sepal.Length > 10 | Sepal.Length == 0, NA, Sepal.Length),
                Sepal.Width = ifelse(Sepal.Width < 0 | Sepal.Width > 10 | Sepal.Width == 0, NA, Sepal.Width),
                Petal.Length = ifelse(Petal.Length > 10 | Petal.Length == 0, NA, Petal.Length))

petal |> filter(Petal.Width == 'Inf')
petal <- petal |> mutate(Petal.Width = ifelse(Petal.Width == 'Inf', NA, Petal.Width))

summary(petal)

# We may replace NAs with each variables' mean.
petal <- petal |>
         mutate(Sepal.Length = ifelse(is.na(Sepal.Length) == TRUE, mean(Sepal.Length, na.rm = TRUE), Sepal.Length),
                Sepal.Width = ifelse(is.na(Sepal.Width) == TRUE, mean(Sepal.Width, na.rm = TRUE), Sepal.Width),
                Petal.Length = ifelse(is.na(Petal.Length) == TRUE, mean(Petal.Length, na.rm = TRUE), Petal.Length),
                Petal.Width = ifelse(is.na(Petal.Width) == TRUE, mean(Petal.Width, na.rm = TRUE), Petal.Width))

# Exercise 6.2.
# a) Load the “olympics.txt” file. Figure out the file type.
# b) The data is not tidy. Make it tidy by pivot transformations.
# c) Check for duplicates. Eliminate them.
# d) Check for outliers, propose a solution.
# e) Check the coherence between variable names and content, solve the problem. 
olympics <- read_delim("olympics.txt")

olympics |> pivot_longer(-1, names_to = 'year', values_to = 'values') |>
            pivot_wider(names_from = Year, values_from = values)
olympics_tidy <- olympics |>
                 pivot_longer(-1, names_to = 'year', values_to = 'values') |>
                 pivot_wider(names_from = Year, values_from = values)
unique(olympics_tidy$year)

colnames(olympics_tidy)[1] <- 'Year'

olympics_tidy |> separate(col = 1, 
                          into = c('Year1', 'Month'),
                          sep = '\\.\\.\\.') |>
                 select(-Month)
olympics_tidy <- olympics_tidy |> separate(col = 1, 
                                           into = c('Year1', 'Month'),
                                           sep = '\\.\\.\\.') |>
                                  select(-Month)
colnames(olympics_tidy)[1] <- 'Year'

summary(olympics_tidy)

olympics_tidy <- olympics_tidy %>%
                 mutate(Year = as.integer(Year),
                         across(c('Length (Days)', 'Participating Countries', 
                                  'Participating Athletes', 'Total Gold Medals', 
                                  'Gold Medals by African Athletes'), as.numeric))

olympics_tidy <- olympics_tidy |>
                 filter(!duplicated(Year)) |>
                 filter(!(City == 'Tokyo, Japan'& Year == 2020))


# Exercise 6.3.
# 1. Read the immunization data.
# 2. Check the tail of the dataset and remove the unnecessary rows.
# 3. Check for missing data and replace them by NA.
# 4. Rename columns and transform them to numeric (if possible):
# • ‘Time’ to year, 
# • `Population, total [SP.POP.TOTL]` to pop after division by 1,000,000
# • `Mortality rate, under-5 (per 1,000 live births) [SH.DYN.MORT]` to mort
# • `Immunization, measles (% of children ages 12-23 months) [SH.IMM.MEAS]` to imm
# • `GDP per capita, PPP (constant 2011 international $) [NY.GDP.PCAP.PP.KD]` to gdppc
# 5. Create two new numeric variables:
# • surv as (1000-mort)/100
# • lngdppc as the logarithm of gdppc
# 6. Rename two character-type variables:
# • ‘Country Name’ as countryname
# • ‘Country code’ as c
# 7. Rearrange the order of the variables in the following way: year, countryname, c, pop, mort, surv, imm, gdppc, lngdppc
# 8. Remove all observations before 1998 and all observations with NA in pop, mort and imm. 
# 9. Store the number of unique country names in a scalar called “number” and the number of missing values in the gdppc column in “miss_in”. Print number and miss_in.
# 10. Create a dataset where one row is one year, and one column is one country, and the values are the values of the imm variable.
immu = read_csv('immunization.csv')

immu |> tail(2)
immu_na <- immu |>
           filter(!(is.na(Time))) |>
           filter(!(Time == "Data from database: World Development Indicators" |
                      Time == "Last Updated: 06/28/2019"))
immu_na |> tail(10)

summary(immu_na)
                  