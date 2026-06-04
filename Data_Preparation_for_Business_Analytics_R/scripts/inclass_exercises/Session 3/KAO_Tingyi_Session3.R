# pivot_longer(data, column(s), names_to, values_to) 
# pivot_wider(data, names_from, values_from)

pew <- read_csv("pew.csv")
pew
# Need quotation mark (They are not variables at the moment)
pew.long <- pivot_longer(pew, -1, names_to = 'income', values_to = 'frequency')
pew.long

weather <- read_csv("mexicanweather.csv")
glimpse(weather)

# Don't Need Quotation Mark (Already Variables)
weather.wider <- pivot_wider(weather, names_from = element, values_from = value)

bond_df <- read_tsv('bond.txt')
bond_df.long <- pivot_longer(bond_df, -1, names_to = "decade", values_to = "frequency")
glimpse(bond_df.long)


bond_df.long <- pivot_longer(bond_df, -1, 
                             names_to = "decade", 
                             values_to = "frequency", 
                             values_drop_na = TRUE,
                             names_transform = list(decade=as.integer))
# Transpose a data frame
# %>% |>
planets <- read_excel('planets.xlsx', sheet = 2)
planets_long <- planets %>% 
                pivot_longer(-1, names_to = "planet") 
planets_wide <- planets_long %>%
                pivot_wider(names_from = metric, values_from = value)

planet_final <- planets %>%
                pivot_longer(-1, names_to = "planet") %>%
                pivot_wider(names_from = metric, values_from = value)

planet_final <- planets |>
                pivot_longer(-1, names_to = "planet") |>
                pivot_wider(names_from = metric, values_from = value)
# Change data type
planet_final <- planet_final |>
                mutate(mass = as.numeric(mass),
                       diameter = as.double(diameter),
                       gravity = as.double(gravity),
                       length_of_day = as.double(length_of_day),
                       distance_from_sun = as.double(distance_from_sun),
                       mean_temperature = as.double(mean_temperature),
                       surface_pressure = as.double(surface_pressure),
                       number_of_moons = as.integer(number_of_moons))
glimpse(planet_final)

planet_final <- planet_final |>
                mutate_at(vars(2:8), funs(as.double)) |>
                mutate_at(vars(number_of_moons), funs(as.integer))

planet_final <- planet_final |>
                mutate(across(2:8, as.double)) |> 
                mutate(across(number_of_moons, as.integer))

#----------------------Exercises------------------------
# Exercise 3.1.
# a) Load the “injuries.csv” file.
# b) Explain what is wrong with this data.
# c) Make the necessary transformation to have a tidy dataset.
# d) Check if the transformation is done, and all known problems are solved. 
##.  Explain what else to do (it is about thinking and not coding).

injuries <- read_csv('injuries.csv')
injuries
# Columns need to integrate as 'age' with corresponding values
injuries.long <- pivot_longer(injuries, c(-1:-2, -13), names_to = "Age", values_to = "Frequency")
injuries.long
# Need to drop out NA values
remove_missing(injuries.long)


# Exercise 3.2.
# a) Load the “athletes.csv” file. The data is about minimum and maximum heart rates of athletes during 5 tests.
# b) Explain what is wrong with this data.
# c) Make the necessary transformation to have a better dataset (just one pivot at once).
# d) Check if the transformation is done, and all known problems are solved. Explain what should be done as the next step.
# e) Try to find how to make the dataset wide. (advanced level, you will learn tricks to do it later)
athletes <- read_csv("athletes.csv")
# Columns need to integrate as 'Test' with corresponding values
athletes.long <- pivot_longer(athletes, -1, names_to = "Test", values_to = "Frequency")
# 'Test' should be separated by Max and Min.
athletes.long <- athletes |>
                 pivot_longer(c(3, 5, 7, 9, 11), names_to = "HRmax", values_to = "HRMaxFrequency") |>
                 pivot_longer(c(2, 3, 4, 5, 6), names_to = "HRmin", values_to = "HRMinFrequency")

# Exercise 3.3.
# a) Import the “sales.csv” dataset. It is about different products’ sales in the months of last year.
# b) Make the data tidy using the right pivot function. 
## Hint: (you may have “product”, “month”, and “sales” columns in the final database.
sales <- read_csv('sales.csv')
sales.long <- sales |>
              pivot_longer(-1, names_to = "Month", values_to = "Sales")

# Exercise 3.4.
# a) Import the “ratings.tsv” file. It is about average yearly rating of departments in the company during between 2015 and 2024.
# b) Prepare your data for charts in Excel: each department should be a column, and each year in a row.
ratings <- read_tsv('ratings.tsv')
ratings.wider <- ratings |>
                 pivot_wider(names_from = year, values_from = rating)

# Exercise 3.5.
# a) Import the “dept performance.csv” file. Pay attention to the delimiter. 
# b) Create a version of the data frame in tidy format (each store is a row; each variable is a column).
# c) Repeat the exercise with “debt performance2.csv”.
debt_performance <- read.delim('dept performance.csv', sep = ';')

debt_performance.longer <- data.frame(debt_performance) |>
                           pivot_longer(-1, names_to = "Store", values_to = "Number") |>
                           pivot_wider(names_from = metric, values_from = Number)

debt_performance2 <- read.delim('dept performance2.csv', sep = ';')
debt_performance2[-1]
debt_performance2.longer <- data.frame(debt_performance2[-1]) |>
                           pivot_longer(-1, names_to = "Store", values_to = "Number") |>
                           pivot_wider(names_from = metric, values_from = Number)

# Exercise 3.6.
# a) Import the data from the “sales report.xlsx” workbook. Pay attention to the arguments of the function. 
# b) Make the data tidy. Remember, the database contains sales values for products, in regions, in quarters. 
# c) Propose additional steps for business analytics (just explain what to do, no coding required here).
# d) Create a table with each region and quarter total sales. (advanced level, you will learn tricks to do it later).
sales_report <- read_excel('sales report.xlsx', sheet = 2)

sales_report.long <- sales_report |>
                     pivot_longer(-1, names_to = "Quarters", values_to = "Sales")
# We can analyse each quarter in specific token "A", "B", "C" to produce a more complete table.
TotalQuarterSales <- rowSums(sales_report[,-1])
Region <- c("North", "South", "East", "West")
SumTbl <- rbind(Region, TotalQuarterSales)
