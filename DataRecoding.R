# Case study on surveillance data analysis; cryptosporidosis
# Lore Merdrignac and Esther Kissling
# EpiConcept
# Created Oct 2016, revised July 2018
# R-code written by Alexander Spina September 2018


#### Reading in datasets ####

# Reading in data from csv
crypto <- read.csv("crypto.csv", sep = ";" , 
                   stringsAsFactors = FALSE )



#### Renaming variables ####

# Renaming all variable names to all lowercase letters
names(crypto) <- tolower( names(crypto) )





#### Recode string to numeric variables ####

# replace unknown with NA 
crypto$agey[crypto$agey == "Unknown"] <- NA

# create new age variable as numeric of AgeY
crypto$age <- as.numeric(crypto$agey)


#### Add labels ####

# re-write the sex variable as a factor defining levels and labels
crypto$sex <- factor(crypto$sex, 
                     levels = c(1, 0), 
                     labels = c("male", "female")
)

# Check the outcome 
table(crypto$sex, useNA = "always")



#### Generating age groups #### 

#generate an empty variable called ar_age
crypto$ar_age <- NA

#where age is under 5, set ar_age to 0
crypto$ar_age[crypto$age < 5] <-  0

#set the rest of the groups 
crypto$ar_age[crypto$age >= 5 & 
                crypto$age < 10] <- 1

crypto$ar_age[crypto$age >= 10 & 
                crypto$age < 15] <- 2

crypto$ar_age[crypto$age >= 15 & 
                crypto$age < 20] <- 3

crypto$ar_age[crypto$age >= 20 & 
                crypto$age < 25] <- 4

crypto$ar_age[crypto$age >= 25 & 
                crypto$age < 35] <- 5

crypto$ar_age[crypto$age >= 35 & 
                crypto$age < 45] <- 6

crypto$ar_age[crypto$age >= 45 & 
                crypto$age < 55] <- 7

crypto$ar_age[crypto$age >= 55 & 
                crypto$age < 65] <- 8

crypto$ar_age[crypto$age >= 65] <- 9



#change to a factor and define labels 

crypto$ar_age <- factor(crypto$ar_age, 
                        levels = 0:9, 
                        labels = c("0-4",
                                   "5-9", 
                                   "10-14", 
                                   "15-19", 
                                   "20-24", 
                                   "25-34", 
                                   "35-44", 
                                   "45-54", 
                                   "55-64", 
                                   "65+"
                            )
                          )


#### Generating hospitalised fields #### 

# If hospital inpatient then 1 else 0
crypto$hospitalised <- ifelse(crypto$patienttype == "Hospital Inpatient", 
                              1, 0)

# Not specified and unknown set to missing
crypto$hospitalised[crypto$patienttype == "Not Specified" | 
                      crypto$patienttype == "Unknown"] <- NA



#### Create a proxy for urban vs. rural #### 

# if region is 1 then urban else rural
crypto$urban <- ifelse(crypto$region == 1, 1, 0) 

#add order and labels
crypto$urban <- factor(crypto$urban, 
                       levels = c(1, 0), 
                       labels = c("urban", "rural")
                       )


#### Create an imported variable #### 


#If country X then not imported, else imported
crypto$imported <- ifelse(crypto$countryofinfection == "Country X", 0, 1) 

#Not specified and unknown set to missing
crypto$imported[crypto$countryofinfection == "Not Specified" | 
                  crypto$countryofinfection == "Unknown"] <- NA

#add order and labels
crypto$imported <- factor(crypto$imported, 
                          levels = c(1, 0), 
                          labels = c("Imported", "Country X")
                          )




#### Add a count variable that signifies one count of disease ####

#assign a one to each row of new variable
crypto$count <- 1



#### Save the file ####

#save your dataset as an r data file
  #giving the file a name
save(crypto, file = "crypto.Rda")





