#Exercise 9.1. (technical practice for regex)
#a) Let’s create a variable called text1 and populate it with the value “The dragon year is 2025.”
text1 = "The dragon year is 2025."

#b) Create a variable called my_pattern and implement the required pattern 
## for finding any digit in the variable text1. 
## Use function grepl to verify if there is a digit in the string variable.
my_pattern = "\\d+"
text1 |> str_extract(pattern = my_pattern)
grepl(my_pattern, text1)
?gregexpr

#c) Use function gregexpr to find all the positions in text1 where there is a digit. 
## Place the results in a variable called string_position.
my_pattern <- "\\d"
string_position <- gregexpr(my_pattern, text1)
string_position

#d) Create a variable called my_pattern and implement the required pattern for 
## finding one digit and one uppercase alphanumeric character, in variable text1.
my_pattern <- "\\d[A-Z0-9]"
text1 |> str_extract(pattern = my_pattern)

#e) Use function regexpr to find the position of the first space in text1. 
## Place the results in a variable called first_space.
my_pattern = "\\s"
first_space = text1 |> regexpr(my_pattern)
first_space

#f) Create a pattern that checks in text1 if there is a lowercase character, 
## followed by any character and then by a digit.
pattern <- "[a-z].\\d"
text1 |> str_extract(pattern = pattern)

#g) Find the starting position of the above string. Place the results in a variable called string_pos2.
string_pos2 <- regexpr(pattern, text1)
string_pos2

#h) Find the following pattern: one space followed by two lowercase letters and one more space. 
## Use a function that returns the starting point of the found string and place its result in string_pos3.
pattern = "\\s[a-z][a-z]\\s"
string_pos3 <- regexpr(pattern, text1)
string_pos3

#i) Using the sub function, replace the pattern found on the previous exercise by the string ” is not ”.
## Place the resulting string in text2 variable.
text2 = sub(pattern, " is not ", text1)
text2

#j) Find in text2 the following pattern: Four digits starting at the end of the string. 
## Use a function that returns the starting point of the found string and place its result in string_pos4.
pattern <- "\\d{4}$"
string_pos4 <- regexpr(pattern, text2)
string_pos4

#k) According to the position of the string found in the previous exercise, 
## extract the first two digits starting at string_pos4.
substr(text2, string_pos4, string_pos4 + 1)


# Exercise 9.2. (quick, only a few steps)
# a) Load the inpatient.tsv data with a not perfect separation of DRG. 
# names <- c("DRG", "ProviderID", "Name", "Address", "City", "State", "ZIP", "Region", "Discharges", "AverageCharges", "AverageTotalPayments", "AverageMedicarePayments")
# types = 'ccccccccinnn'
# inpatient <- read_tsv(inpatient.tsv', col_names = names, skip=1, col_types = types)
# inpatient_separate <- separate(inpatient,DRG,c('DRGcode','DRGdescription'),4)
inpatient = read_tsv("inpatient.tsv")
names <- c("DRG", "ProviderID", "Name", "Address", "City", 
            "State", "ZIP", "Region", "Discharges", "AverageCharges", 
           "AverageTotalPayments", "AverageMedicarePayments")
types = 'ccccccccinnn'
inpatient <- read_tsv("inpatient.tsv", col_names = names, skip=1, col_types = types)
inpatient_separate <- separate(inpatient,DRG,c('DRGcode','DRGdescription'),4)

# b) Trim the DRGcode field. Hint: str_trim()
?str_trim
#str_trim(string, side = c("both", "left", "right"))
str_trim(inpatient_separate$DRGcode)

# c) Remove the ‘– ‘ from the beginning of the DRGdescription column.
str_split(inpatient_separate$DRGdescription , pattern = "- ") 





