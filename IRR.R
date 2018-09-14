# Case study on surveillance data analysis; cryptosporidosis
# Lore Merdrignac and Esther Kissling
# EpiConcept
# Created Oct 2016, revised July 2018
# R-code written by Alexander Spina September 2018

#### Reading in datasets ####

#load your cleaned dataset
load("cryptoyear.Rda")


#### Incidence rate ratios of all years compared to 2015 data ### 

# change 2015 to reference group using relevel function
cryptoyear$year <- relevel(factor(cryptoyear$year), ref = "2015")

# run poisson regression of counts by year
model1 <- glm(count ~ year , 
              family = poisson(link = "log"), 
              data = cryptoyear, offset = log(den_reg))

# use the tidy function from broom package to simplify the regression output
model1clean <- tidy(model1, exponentiate = TRUE, conf.int = TRUE)



#### Incidence rate ratio of 2015 compared to 2012-14 data ####

# collapse your data producing mean counts for 2012-2014 

# create a variable for current year 
cryptoyear$curryear <- NA
cryptoyear$curryear[cryptoyear$year == 2015] <- 1
cryptoyear$curryear[cryptoyear$year %in% c(2012:2014)] <- 0

# aggregate using the mean function
meanyear <- aggregate(count ~ curryear + den_reg, 
                      FUN = mean, 
                      data = cryptoyear)

# run poisson regression of counts by year
model2 <- glm(count ~ curryear, 
              family = poisson(link = "log"), 
              data = meanyear, offset = log(den_reg))

# use the tidy function from broom package to simplify the regression output
model2clean <- tidy(model2, exponentiate = TRUE, conf.int = TRUE)



#### Incidence rate ratio: urban vs rural areas #### 

# load your cleaned dataset
  # note that it is still called crypto
load("cryptorecodeddenom.Rda")


# only keep 2015 counts
crypto <- subset(crypto, 
                 year == 2015)

# aggregate using the sum function
cryptoag <- aggregate(count ~ urban + den_reg, 
                      FUN = sum, 
                      data = crypto)

# sum rural seperately 
  # aggregate doesnt work because only one urban row
cryptorural <- colSums(cryptoag[1:6, 2:3])

# bind sums together 
cryptosum <- rbind(cryptorural, cryptoag[7, 2:3])

# change urban to binary
cryptosum$urban <- c(0,1)


# run poisson regression of counts by year
model3 <- glm(count ~ urban, 
              family = poisson(link = "log"), 
              data = cryptosum, offset = log(den_reg))

# use the tidy function from broom package to simplify the regression output
model3clean <- tidy(model3, exponentiate = TRUE, conf.int = TRUE)
