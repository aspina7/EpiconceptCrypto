# Case study on surveillance data analysis; cryptosporidosis
# Lore Merdrignac and Esther Kissling
# EpiConcept
# Created Oct 2016, revised July 2018
# R-code written by Alexander Spina September 2018


#### Reading in datasets ####


# read in denominators by region
region <- read.csv("region.csv", sep = ";" , 
                   stringsAsFactors = FALSE )


# read in denominators by age
agegroup <- read.csv("agegroup.csv", sep = ";" , 
                     stringsAsFactors = FALSE )

# read in denominatros by age and region
agegroupregion <- read.csv("agegroupregion.csv", sep = ";" , 
                           stringsAsFactors = FALSE )


#### Merging with denominators ####


# load your dataset 
load("crypto.Rda")

# check region has no missings
table(crypto$region, useNA = "always")


#### Merge first with region data ####

# overwrite crypto with merged dataset
  # all.x specifies crypto as the main dataset of interest
crypto <- merge(crypto, region, by = "region", all.x = TRUE)

# rename the total variable
  # subset crypto variable names where equal to "total"
  # overwrite with "den_reg"
names(crypto)[names(crypto) == "total"] <- "den_reg"


#### Merge with age data ####

# overwrite crypto with merged dataset
  # all.x specifies crypto as the main dataset of interest
crypto <- merge(crypto, agegroup, by = "age", all.x = TRUE)

# rename the total variable
  # subset crypto variable names where equal to "total"
  # overwrite with "den_reg"
names(crypto)[names(crypto) == "total"] <- "den_age"

# drop those with missing denominator data
crypto <- subset(x = crypto, 
                 subset = !is.na(crypto$den_age)
                 )

#### Saving data ####

# save your dataset
save(crypto, file = "cryptorecodeddenom.Rda")


