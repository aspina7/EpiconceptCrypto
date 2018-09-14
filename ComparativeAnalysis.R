# Case study on surveillance data analysis; cryptosporidosis
# Lore Merdrignac and Esther Kissling
# EpiConcept
# Created Oct 2016, revised July 2018
# R-code written by Alexander Spina September 2018


#### Reading in datasets ####

# load your dataset 
load("crypto.Rda")

#### Dropping data ####

# assign your 2014-2015 subset to crypto (over-write original crypto)
crypto <- subset(
  x = crypto,
  subset = year >= 2014
)

# check cases per year 
table(crypto$year, useNA = "always")

#### Comparison of age distribution ####


# specify you want one row of two histograms
par(mfrow = c(1,2))

# plot a histogram for males (use squarebrackets to subset)
  # give a title using "main", 
  # set the y axis limits using ylim
hist(crypto$age[crypto$year == 2014], 
     main = "2014",
     xlab = "Age", 
     ylab = "Count",
     breaks = 100, 
     xlim = c(0, 100), 
     ylim = c(0, 100) )

# plot a histogram for females
hist(crypto$age[crypto$year == 2015], 
     main = "2015",
     xlab = "Age", 
     ylab = "Count",
     breaks = 100, 
     xlim = c(0, 100), 
     ylim = c(0, 100) )


#### Looking at median and IQR ####

# use the aggregate function to group by year
  # year must be as a list
  # specify the function you would like to use (summary)
aggregate(crypto$age, by = list(crypto$year), FUN = summary)

# use the boxplot function to plot 
boxplot(age~year, data = crypto)


#### Test for equality of distributions ####

#use the tilda to specify comparison by
wilcox.test(crypto$age~crypto$year)

#### Test for equality of means (standard deviations) ####

# use the aggregate function to group by year 
  # year must be as a list 
  # specify the function you would like to use (summary)
aggregate(crypto$age, by = list(crypto$year), FUN = summary)

# use t.test function to compare means
t.test(crypto$age ~ crypto$year)

#### Comparison of proportion of male/female, hospitalised, urban/rural ####

# For sex

# get counts
  # save table as "counts"
counts <- table(crypto$sex, crypto$year) 

# get rounded proportions of counts
  # margin = 2 for column proportions
round(prop.table(counts, margin = 2) * 100, digits = 2)

# chisq.test function requires you to input a table
chisq.test(counts)


# For hospitalised

# get counts
  # save table as "counts"
counts <- table(crypto$hospitalised, crypto$year) 

# get rounded proportions of counts
  # margin = 2 for column proportions
round(prop.table(counts, margin = 2) * 100, digits = 2)

# chisq.test function requires you to input a table
chisq.test(counts)


# For urban

# get counts
  # save table as "counts"
counts <- table(crypto$urban, crypto$year) 

# get rounded proportions of counts
  # margin = 2 for column proportions
round(prop.table(counts, margin = 2) * 100, digits = 2)

# chisq.test function requires you to input a table
chisq.test(counts)


# For imported

# get counts
  # save table as "counts"
counts <- table(crypto$imported, crypto$year) 

# get rounded proportions of counts
  # margin = 2 for column proportions
round(prop.table(counts, margin = 2) * 100, digits = 2)

# chisq.test function requires you to input a table
chisq.test(counts)

