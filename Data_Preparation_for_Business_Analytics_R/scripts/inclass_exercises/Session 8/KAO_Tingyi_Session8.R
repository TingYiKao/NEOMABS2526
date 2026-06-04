library(tidyverse)
library(stringr)

names <- c("ID", "DBAName", "AKAName", "License", "FacilityType", "Risk", 
           "Address", "City", "State", "ZIP", "InspectionDate", "InspectionType", "Results",
           "Violations", "Latitude","Longitude","Location")
inspections <- read_csv("inspections.csv", col_names = names, skip=1) 
regional_inspections <- unite(inspections, Region, City, State, sep=", ", remove = FALSE)

# str_to_upper(): converting everything to uppercase
regional_inspections <- regional_inspections %>% 
                        mutate(Region = str_to_upper(Region))

unique(regional_inspections$Region) # Observe numerous misspellings

badchicagos <- c('CCHICAGO, IL', 'CHCICAGO, IL', 
                 'CHICAGOCHICAGO, IL', 'CHCHICAGO, IL', 'CHICAGOI, IL')

regional_inspections <- regional_inspections %>%
                        mutate(Region = ifelse(Region %in% badchicagos, 'CHICAGO, IL', Region))
regional_inspections <- regional_inspections %>%
                        mutate(Region = ifelse(Region == "CHICAGO, NA", 'CHICAGO, IL', Region))
unique(regional_inspections$Region)

nachicagos <- c('NA, IL', 'NA, NA', 'INACTIVE, IL')
regional_inspections <- regional_inspections |>
                        mutate(Region = ifelse(Region %in% nachicagos, NA, Region))
unique(regional_inspections$Region)

# str_c(): concatenating strings together with stringr
## !!!do not support factor
str_c("Beautiful","day", sep=" ") 
str_c("Beautiful", NA, sep = " ") # if strings contain one NA value, string will become NA.

paste("Beautiful", NA, sep=" ") # use paste() to ignore the effect of NA

# Checking Length
nchar(c("Bruce", "Wayne")) # Length of characters
nchar(c("Jessica", "Monica"))

str_length(c("Bruce", "Wayne")) # support factor
str_length(factor(c("Bruce", "Wayne")))
nchar(factor(c("Bruce", "Wayne")))

# Extract sub-strings
str_sub(c("Bruce", "Wayne"), 1, 4) 
str_sub(c("Bruce", "Wayne"), -3, -1) 
name = factor(c("Bruce", "Wayne", "Jessica", "Monica"))
str_sub(name)

# Matches
pizzas <- c("cheese", "pepperoni", "sausage and green peppers") 
pizzas |> str_detect(pattern = 'pepper') # Matching exactly the word
pizzas |> str_subset(pattern = 'pepper') # By matching words containing the pattern
pizzas |> str_count(pattern = 'e') # Return the frequency of the pattern appearing in each word

inspections %>% group_by(DBAName) %>% 
                summarize(inspections = n()) %>% # n()-> group size
                arrange(desc(inspections)) # descending order
# MCDONALD'S, MCDONALDS
unique(inspections$DBAName)

inspections <- inspections %>%
              mutate(Mcdo = str_detect(inspections$DBAName, pattern="MCDO")) 
sum(inspections$Mcdo)

wrongMcDo <- unique(str_subset(inspections$DBAName, pattern="MCDO")) 
wrongMcDo

# Parsing strings into variables
## str_split(): pull apart raw string data into more useful variables.
## fixed(): iteral comparisons
date_ranges <- c("23.01.2017 - 29.01.2017", "30.01.2017 - 06.02.2017") 
split_dates <- str_split(date_ranges, pattern = fixed(" - ")) 
split_dates
?fixed

# Replacing matches in strings
ids <- c("ID#: 192", "ID#: 118", "ID#: 001") 
id_nums <- ids |> str_replace("ID#: ", "") # Replace "ID#: " with "" (nothing)
id_nums
as.numeric(id_nums)

phone_numbers <- c("510-555-0123", "541-555-0167") 
str_replace_all(phone_numbers, "-", ".") 

# Regular expressions
string <- "car"
pattern <- "car"
grep(pattern, string) # To find a pattern in a string

string <- c("car", "cars", "in a car", "truck", "car's trunk")
pattern <- "car"
grep(pattern, string) # Return the location in the string containing "car"

# grepl(): returns logical value
grepl(pattern, string)

# Meta and special characters
## special characters: . \ | ( ) [ ] { } ^ $ * + ? \- escape character
## . - any (just one) character
## ^ - beginning of a string
## $ - end of string
string <- c("car", "cars", "in a car", "truck", "car's trunk") 
grep("^c.r",string) # start with c, _, end with r
grep("^c..$",string) # start with c, _, end with anything, exactly 3 characters
grep("^c.r.$",string) # start with c, _, r, _, end with anything, exactly 4 characters

# Alphanumeric character / Non
grep("\\w", c(" ", "a", "1", "A", "%", "\t")) # Alphanumeric
grep("\\W", c(" ", "a", "1", "A", "%", "\t")) # Non-alphanumeric

grepl("\\w", c(" ", "a", "1", "A", "%", "\t")) # Alphanumeric
grepl("\\W", c(" ", "a", "1", "A", "%", "\t")) # Non-alphanumeric

# Whitespace / Non
grep("\\s", c(" ", "a", "1", "A", "%", "\t")) # Whitespace
grep("\\S", c(" ", "a", "1", "A", "%", "\t")) # Non-whitespace

grepl("\\s", c(" ", "a", "1", "A", "%", "\t")) # Whitespace
grepl("\\S", c(" ", "a", "1", "A", "%", "\t")) # Non-whitespace

# Digit / Non
grep("\\d", c(" ", "a", "1", "A", "%", "\t")) # Digit
grep("\\D", c(" ", "a", "1", "A", "%", "\t")) # Non-digit

grepl("\\d", c(" ", "a", "1", "A", "%", "\t")) # Digit
grepl("\\D", c(" ", "a", "1", "A", "%", "\t")) # Non-digit

# Possible values for a character
grep("^[abc]\\w\\w", c("car", "bus", "no", "cars", "big car")) 
# start with 'a', 'b', or 'c' and have at least two alphanumeric value

grep("^[abc]\\w\\w$", c("car", "bus", "no", "cars")) 
# start with 'a', 'b', or 'c', followed by exactly two alphanumeric value

grep("^[a-z][a-z][a-z]$", c("Car", "Cars", "cars","car", "no", "three:", "tic", "tac"))
# Exactly three lowercase alphabets 

# One or two digits anywhere     
## Exactly one or two digits
grep("((\\d)|([1-9]\\d))", c("1", "20", "0", "zero", "it is 100%", "09"))
# digits or 1-9 and digits

grep("^((\\d)|([1-9]\\d))$", c("1", "20", "0", "nid", "to the 100%", "09"))
# digits or two digits start with 1~9

grep("^((\\d)|(\\d\\d))$", c("1", "20", "0", "nid", "to the 100%", "09"))

# Repeating
## ?: matches at most 1 times 
## *: matches at least 0 times 
## +: matches at least 1 times 
## {m}: matches exactly m times 
## {m, n}: matches between m and n times 
## {m, }: matches at least m times 
string <- c("a", "ab", "acb", "accb", "acccb", "accccb") 
grep("ac*b", string) # 'c' may exist or not
grep("ac+b", string) # 'c' must exist one time

grep("ac?b", string, value=TRUE) # c at most one time
grep("ac{2}b", string, value = TRUE) # c appears exactly two timea
grep("ac{2,}b", string, value = TRUE) # c appears at least two times
grep("ac{2,3}b", string, value = TRUE) # c appears 2 or 3 times

grep("^([a-z]+ )*[a-z]+$", c("words", "words or sentences", "123 no", "Words"," word","word 123"))
# start with a-z at least 1 time, a space and end with a-z at least 1 time

grep("^[a-z]{3,5}$", c("words", "words or sentences", "123 no", "Words"," word","word 123","hey"))
# start with a-z between 3 and 5 characters

grep("^[+-]?(0|[1-9][0-9]*)$", c("++0", "+1", "01", "-99", "+0h"))
grep("^[+-]?(0|[1-9]\\d*)$", c("++0", "+1", "01", "-99", "+0h"))
# start with +/r, followed by 0 or 1-9, and match 0-9 at least 0 time

# Greedy and Lazy Repetition
string<-"This is a <EM>first</EM> test"
pattern<-"<.+>" # at least one character
r<-regexpr(pattern,string) 
regmatches(string, r) # get pattern between the string

pattern<-"<.+?>" 
r<-regexpr(pattern,string) 
regmatches(string, r)
?regmatches

# Sub-pattern (group catching)
string <- c("(1,2)", "( -2, 7)", "( -3 , 45)", "(a, 3)") 
pattern<-"\\(\\s*([+-]?(0|[1-9][0-9]*))\\s*,\\s*([+-]?(0|[1-9][0-9]*))\\s*\\)" 
lidx <- !grepl(pattern, string)
lidx
?sub
komp1 <- sub(pattern, "\\1", string) # find the first part
komp1[lidx] <- NA 
komp1
komp2 <- sub(pattern, "\\3", string) # find the third part
komp2[lidx] <- NA
as.integer(komp1)
komp2
## Group 1: ([+-]?(0|[1-9][0-9]*)) → the first integer (with optional + or -)
## Group 2: (0|[1-9][0-9]*) → the unsigned integer part inside the first integer (because it’s nested)
## Group 3: ([+-]?(0|[1-9][0-9]*)) → the second integer
## Group 4: (0|[1-9][0-9]*) → nested unsigned part for the second integer

# gregexpr
F## inds all positions and lengths of matched patterns, and returns a list.
text<-"Yesterday I had 100 Euros, today I only have 45 Euros left." 
gregexpr("(\\d+)", text)

# regmatches
## Extracts or replaces matched substrings from match data obtained by regexpr, gregexpr or regexec.
regmatches(text, gregexpr("\\d+",text))
regmatches(text, gregexpr("\\d..",text))
str_extract(text, "\\d+")
str_extract_all(text, "\\d+")

inspections %>% filter(grepl("McDo", DBAName, ignore.case=TRUE)) %>% 
                select(DBAName) %>% 
                unique() %>% 
                View()

alternates <- inspections %>%
              filter(grepl("McDo", DBAName, ignore.case=TRUE)) %>% 
              filter(DBAName!='SARAH MCDONALD STEELE') %>% select(DBAName) %>%
              unique() %>%
              pull(DBAName) |>
              View()
inspections <- inspections %>%
               mutate(DBAName=ifelse(DBAName %in% alternates, 'MCDONALDS', DBAName))

inspections %>% group_by(DBAName) %>%
                summarize(inspections=n()) %>%
                arrange(desc(inspections))

# Stringr and regular expressions 
## str_subset (grep) 
fruit |> str_subset("\\s") # contain a space


