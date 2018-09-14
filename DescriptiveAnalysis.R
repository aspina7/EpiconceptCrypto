# Case study on surveillance data analysis; cryptosporidosis
# Lore Merdrignac and Esther Kissling
# EpiConcept
# Created Oct 2016, revised July 2018
# R-code written by Alexander Spina September 2018


#### Reading in datasets ####

# load your dataset 
load("crypto.Rda")


#### Focusing on 2015 data ####

# assign your 2015 subset to crypto (over-write original crypto)
crypto <- subset(
  x = crypto,
  subset = year == 2015
)

#### What is the number of cases for 2015? ####

# check number of rows in your dataset
nrow(crypto)

#### Describing age ####


# Plot a histogram of age
  # you can specify a bar for each age with "breaks"
  # you can set your x axis from 0-100 using "xlim"
hist(crypto$age, 
     xlab = "Age",
     ylab = "Count", 
     breaks = 100,
     xlim = c(0, 100)
)


# Get a summary of age 
summary(crypto$age)


# Plot a histogram of age by sex 

# specify you want one row of two histograms
par(mfrow = c(1,2))

# plot a histogram for males (use squarebrackets to subset)
  # give a title using "main", 
  # set the y axis limits using ylim
hist(crypto$age[crypto$sex == "male"], 
     main = "male",
     xlab = "Age", 
     ylab = "Count",
     breaks = 100, 
     xlim = c(0, 100), 
     ylim = c(0, 50) )

# plot a histogram for females
hist(crypto$age[crypto$sex == "female"], 
     main = "female",
     xlab = "Age", 
     ylab = "Count",
     breaks = 100, 
     xlim = c(0, 100), 
     ylim = c(0, 40) )

#### Describing sex ####

# get counts of sex 
  # save table as "counts"
counts <- table(crypto$sex) 

# get proportions for counts table
prop.table(counts)

# you could also multiple by 100 and round to 2 digits
round(
  prop.table(counts)*100, 
  digits = 2
  )

#### Describing hospitalised ####

# get counts of hospitalisations 
  # save table as "counts"
counts <- table(crypto$hospitalised) 

# get rounded proportions of counts
round(
  prop.table(counts)*100, 
  digits = 2
  )


# get counts of hospitalisations by agegroup
  # save table as "counts"
counts <- table(crypto$ar_age, crypto$hospitalised)

# get rounded proportions of counts
  # specify that you want row proportions (margin = 1)
round(
  prop.table(counts, margin = 1) * 100,
  digits = 2
  )

#### Describe urban ####

#get counts
  #save table as "counts"
counts <- table(crypto$urban) 

#get rounded proportions of counts
round(
  prop.table(counts)*100,
  digits = 2
  )


#### Describe imported ####

#get counts
  #save table as "counts"
counts <- table(crypto$imported) 

#get rounded proportions of counts
round(
  prop.table(counts)*100, 
  digits = 2
  )

