# Missing values
numbirds <- c(1, 2, 3, 4/0, 0/0, NA)
numbirds

# Inf means infinite number
# NaN means not a number
# NA means missing values

# Detection of NA values
is.na(numbirds)
# NaN/NA belongs to NA values
# Inf is not NA values

# Detection of NaN values
is.nan(numbirds)

# Detection of infinite numbers
is.infinite(numbirds)

# Detection of finite numbers
is.finite(numbirds)

#----------------------------------------------
names <- c("ID", "DBAName", "AKAName", "License", "FacilityType", "Risk", 
           "Address", "City", "State", "ZIP", "InspectionDate", "InspectionType", "Results",
           "Violations", "Latitude","Longitude","Location")
inspections <- read_csv('inspections.csv', col_names=names, skip=1)

summary(inspections)

# Obtain the license shows NA
unlicensed <- inspections |>
              filter(is.na(License))

licensed <- inspections |>
            filter(!is.na(License))

summary(licensed)

inspections |> filter(License == 9999999)

#----------------------------------------------
heating <- read_csv("heating.csv")

glimpse(heating)

heating <- heating |>
           pivot_longer(cols = -1,
                        names_to = "Age",
                        values_to = "Homes") 

heating <- heating |>
            pivot_longer(cols = -1,
                         names_to = "Age",
                         values_to = "Homes",
                         values_transform = list(Homes = as.character)) 
glimpse(heating)
summary(heating)

heating |> mutate(Homes = as.numeric(Homes)) # NAs introduced by coercion 

heating |> filter(is.na(as.numeric(Homes)))

# ifelese()
heating |> mutate(Homes = ifelse(Homes == '.', 0, Homes)) |>
           mutate(Homes = ifelse(Homes == 'Z', 0, Homes)) |>
           mutate(Homes = as.numeric(Homes)) |>
           filter(Source == 'Cooking stove')
heating <- heating |> mutate(Homes = ifelse(Homes == '.', 0, Homes)) |>
                      mutate(Homes = ifelse(Homes == 'Z', 0, Homes)) |>
                      mutate(Homes = as.numeric(Homes))

#----------------------------------------------
land <- read_csv('publiclands.csv')
glimpse(land)
summary(land)

# tibble() as data frame
missing_states <- tibble(State=c('Connecticut', 'Delaware', 'Hawaii', 'Iowa', 
                                 'Maryland', 'Massachusetts', 'New Jersey', 'Rhode Island'), 
                         PublicLandAcres=c(0,0,0,0,0,0,0,0))
# rbind() or bind_rows are workable
land_full <- bind_rows(land, missing_states)

mean(land$PublicLandAcres)
mean(land_full$PublicLandAcres)

#----------------------------------------------
iris <- read_csv("dirty petal.csv")

sum(iris$Petal.Length)
sum(iris$Petal.Width)

# na.rm() removes missing values
sum(iris$Petal.Length, na.rm = TRUE)

#----------------------------------------------
# Duplicated values

olympics <- read_csv("olympic games.txt")

olympics <- unique(olympics)

olympics <- olympics |>
            filter(!(City == 'Tokyo, Japan'& Year == 2020))

#----------------------------------------------
library(readxl)
france <- read_excel("France population 2015.xlsx")
glimpse(france)
france <- read_excel("France population 2015.xlsx", range = "C4:D12")

sum(france$Population)

# Note the usage of 'in'
france <- france |>
          filter(!(Category %in% c('Total', 'Male', 'Female')))
sum(france$Population)

#----------------------------------------------
# Units / Data conversion
weather <- read_csv("mexicanweather.csv")
weather<- pivot_wider(weather, names_from=element, values_from=value)

# Use head() and tail() to check top and bottom records
head(weather, 10)
tail(weather, 10)

weather <- weather |>
           filter(!(is.na(TMAX) & is.na(TMIN)))

# rename() to rename col names
weather <- weather |>
           rename(maxtemp = TMAX, mintemp = TMIN) |>
           select(station, date, mintemp, maxtemp) # Re-order the col

head(weather)

# mutate() is a good function to change values in data frame
weather <- weather |>
           mutate(mintemp = mintemp/10) |>
           mutate(maxtemp = maxtemp/10)

weather_fahrenheit <- weather |>
                      mutate(mintemp = mintemp*(9/5)+32) |>
                      mutate(maxtemp = maxtemp*(9/5)+32)

#----------------------Exercises------------------------
# Exercise 5.1 (continued from Session 4)
# a) Read the coffeeshop.csv file to a data frame as it is using the tidyverse library. Do not change variable types and names.
# b) The data frame is not tidy. Explain what is wrong and why.
# c) Using pivot functions, restructure the data frame.
# d) Clean the first column, it should be named ‘Beverage_category’ and should have only text, but no … or numbers.
# e) Check the unique values of Total fat and Caffeine. What problems do you see with them?
# f) Clean the Total fat. We should have numbers. Also, clean Caffeine, whenever more values are possible, just use NA. 
## (Hint: this question is easy-to-understand if you solved e), otherwise… hmmm, good luck!) 
#g) Change variable types, use numeric where it is possible to.
# h) Calculate the sugar content in grams of the drink with the highest caffeine level. (hard exercise) 
## If you finish this exercise before the end of the class, raise your hand, and ask for as many bonus points as the right answer. 
?data.frame
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
# separate_wider_delim(data, cols, delim, names, cols_remove)
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
coffeeshop_df_clean <- remove_missing(coffeeshop_df_Item, na.rm = TRUE)
coffeeshop_df_clean <- coffeeshop_df_clean |>
                       mutate('Caffeine (mg)' = ifelse('Caffeine (mg)' == 'varies', 0, 'Caffeine (mg)'))

typeof(coffeeshop_df_clean)
is.data.frame(coffeeshop_df_clean)
glimpse(coffeeshop_df_clean)

coffeeshop_df_clean <- coffeeshop_df_clean |>
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


# Exercise 5.2.
# a) Load the “dirty petal.csv” file.
# b) Propose a solution for the NAs using the information in the dataset only. Implement your proposal.
iris <- read_csv("dirty petal.csv")
