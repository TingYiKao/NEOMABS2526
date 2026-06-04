library(tidyverse)
library(readxl)

origin

# Standard format of date
today()
now()
as.numeric(today())
as.numeric(now())

# Separators are fine
mdy("01-12-2026")
mdy("01:12:2026")
mdy("Jan 12 2026")
dmy("12 Jan 2026")
dmy("Jan 2026 12")
ydm("2026 12 Jan")
ymd_hms("2026 Jan 12 08 04 31")
mdy_hm("Feb 12 2026 23 59")

# Extraction (without regex)
year(now())
second(now())

alan <- mdy_hm("June 23, 1912, 02:15 AM", 
               tz = "Europe/London")
alan

Jessica <- mdy_hm("June 12, 1997, 02:15 AM", 
                  tz = "Asia/Shanghai")
Jessica

wday(alan)
wday(Jessica, label = TRUE)
wday(Jessica, label = TRUE, abbr = FALSE)

yday(Jessica) # The day of the year
semester(Jessica) # The semester of year
dst(Jessica) # Deadline Saving Time
am(Jessica)

leap_year(Jessica)
leap_year((year(Jessica))+2)

# Time zones
OlsonNames()

grep("Tokyo", OlsonNames(), value = TRUE)
grep("Beijing", OlsonNames(), value = TRUE)
grep("Taipei", OlsonNames(), value = TRUE)

with_tz(alan, "Asia/Tokyo") # Japan standard time
with_tz(Jessica, "Asia/Shanghai")

#----------------------------------------------
floor_date(now(), unit = "month") # The start of the month
floor_date(Jessica, unit = "day")

ceiling_date(now(), unit = "hour")
ceiling_date(Jessica, unit = "minute")

round_date(now(), unit = "hour")
round_date(Jessica, unit = "year")

age = year(now()) - year(Jessica)
age


round(1.5)
round(1.45)
round(1.45, digits = 2)
ceiling(1.45)
floor(1.346)

# Time difference
ddays(370) # duration
days(370)
dminutes(360)
minutes(360)


LunarOrbit <- ddays(29) + dhours(12) + dminutes(44)
LunarOrbit

ymd("2024-01-31") + LunarOrbit 
ymd("2026-01-31") + LunarOrbit
ymd("2025-01-01") + LunarOrbit

dmy("28 February, 2024") + years(1)
dmy("29 February, 2024") + years(1) # 2025 is not a leap year
dmy("29 February, 2024") + dyears(1) # One "dyear" is 365.25 days dmy("29 February, 2024") + months(1)
dmy("31 January, 2024") + months(1) # Feb only has 28 days normally
dmy("31 January, 2024") + dmonths(1) # One "dmonth" is 1/12 "dyear"
dmy("31 January, 2024") + months(1) 

alandiff = interval(alan, now())
alandiff/years(1)
alandiff/dyears(2)
Jessicadiff = interval(Jessica, now())
Jessicadiff/years(1)

# Exercise 7.1
# a) Read the mexicanweather.csv dataset and make it tidy.
# b) Separate the year, the month, and the day into new columns using lubridate functions.
# c) Look at the station column. What can you propose based on unique values?

mexicanweather = read_csv("mexicanweather.csv")

library(lubridate)
library(nycflights13)
?lubridate
mexicanweather = mexicanweather |> mutate(year = year(date),
                                          month = month(date),
                                          day = day(date))
unique(mexicanweather$station)
# They are all the same name. MX000017004

# Exercise 7.2
# a) Store your birth time in an object mybirth. Pay attention to the right time zone.
# b) Check if you were born in a leap year, or daylight-saving time. 
# c) What day of the week?
# d) Calculate your age in duration and period. Explain the difference between them.
# e) Calculate when you will be 20,000 days old.
# f) What will be the time in Auckland then? 
mybirth <- mdy_hm("May 31, 2001 02:04 AM", 
                  tz = "Asia/Taipei")
leap_year(mybirth)
# the year of 2001 is not a leap year
week(mybirth)
# 22th week of the year

myage <- year(now()) - year(mybirth) 
myage # 25 ans

myage1 <- interval(mybirth, now())
myage1/years(1) # 24.62153 ans
?years

mybirth <- mybirth + days(20000)
mybirth

grep("Auckland", OlsonNames(), value = TRUE)
mybirth_auc <- mdy_hm("May 31, 2001 02:04 AM", 
                  tz = "Pacific/Auckland")
mybirth_auc

# Exercise 7.3. (revision)
# a) Load the ‘Survey Data For My Best Exam 2024.txt’ file in R, using functions in the tidyverse library. 
##  Do NOT rename the file and do NOT edit it BEFORE loading.
# b) Detect and remove empty columns WITHOUT the janitor package. 
# c) Rename ‘Timestamp’ to ‘time’ and transform it to the right data format.
## Check with a code if the transformation was successful and you don’t have any NAs.
# d) What is the hour just now in El Salvador? Store it in a variable EShour.
# e) Look for outliers in the ‘Annual Salary’. Remove the people with the 3 most extreme outliers.
# Hint: to remove spaces from the annual salary, you can use the following code. 
# survey$`Annual salary` <- str_replace_all(survey$`Annual salary`, " ", "")
# f) Look for outliers in the `Years of experience in field` and `Overall years of professional experience` columns. 
## Explain in a comment what is wrong with them.
# g) Clean the `Years of experience in field` and `Overall years of professional experience` columns 
## and conclude on the relationship between the two variables (no statistical tools are needed). 

data = read_delim("Survey Data For My Best Exam 2024.txt", delim = "\t")
glimpse(data)
data = data |> select(-c("...19", "...20", "...21", "...22", "...23", "...24"))

colnames(data)[1] = "time"
data$time = mdy_hms(data$time)
glimpse(data)

# sum() number of NAs
# which() positions (row indices) of NAs
sum(is.na(data$time))

grep("Salvador", OlsonNames(), value = TRUE)
EShour = with_tz(now(),
                  tz = "America/El_Salvador")

data$"Annual salary" <- str_replace_all(data$"Annual salary", " ", "")
data$"Annual salary" = as.numeric(data$"Annual salary")
summary(data$"Annual salary")

boxplot(data$"Annual salary"[is.finite(data$"Annual salary")])
sort(data$"Annual salary", decreasing = TRUE)

data = data |>
       filter(-(data$"Annual salary" %in% c(870000000, 180000000, 102000000)))
