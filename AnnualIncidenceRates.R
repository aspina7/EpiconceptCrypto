# Case study on surveillance data analysis; cryptosporidosis
# Lore Merdrignac and Esther Kissling
# EpiConcept
# Created Oct 2016, revised July 2018
# R-code written by Alexander Spina September 2018

#### load required packages ####

library(epiR)


#### Reading in datasets ####

#load your cleaned dataset
  # note that it is still called crypto
load("cryptorecodeddenom.Rda")


#### Annual incidence rates overall ####

# First collapse the data by year 
  #(and region, as all our denominators are by region)

# sum the counts variable while grouping region, year and denom
cryptoreg <- aggregate(count ~ region + year + den_reg, 
                       FUN = sum, 
                       data = crypto)


# We can now collapse again by year

# cbind collapses count and den_reg sepparately by year
cryptoyear <- aggregate(cbind(count, den_reg) ~ year, 
                        FUN = sum, 
                        data = cryptoreg)


# Calculate the annual incidence rates with 95% CI

# epiconf requires your counts and denoms to be in a matrix
  # select columns from your cryptoyear dataset using squarebrackets
  # change it to a matrix using as.matrix
IR <- epi.conf(as.matrix(cryptoyear[, c("count", "den_reg")]),
               ctype = "inc.rate",
               method = "exact") * 100000


# Add this to your collapsed dataframe with counts using cbind 

# add columns to cryptoyear from IR
cryptoyear <- cbind(cryptoyear, IR)



# Plot the incidence rates

# plot the estimate from above
  # type "o" specifies line graph
plot(cryptoyear$year, cryptoyear$est, type = "o")


# And you can make the plot nicer: 
plot(cryptoyear$year, cryptoyear$est, type = "o", 
     ylim = c(0, 16), 
     ylab = "Crude incidence rate per 100,000 inhabitants", 
     xlab = "Year")

# You can then also export your plot and save your dataset 

# export plot as a png file
dev.copy(png,'Crypto inc by year.png')
dev.off()

# save incidence rate dataset
save(cryptoyear, file = "cryptoyear.Rda")




####  Annual incidence rates by region ####

# load your cleaned dataset
  # note that it is still called crypto
load("cryptorecodeddenom.Rda")


# First collapse the data by year 
  #(and region, as all our denominators are by region)

# sum the counts variable while grouping region, year and denom
cryptoreg <- aggregate(count ~ region + year + den_reg, 
                       FUN = sum, 
                       data = crypto)

# sort your dataset by region 
cryptoreg <- cryptoreg[order(cryptoreg$region), ]



# Calculate the annual incidence rates with 95% CI

# epiconf requires your counts and denoms to be in a matrix
  # select columns from your dataset using squarebrackets
  # change it to a matrix using as.matrix
IR <- epi.conf(as.matrix(cryptoreg[, c("count", "den_reg")]),
               ctype = "inc.rate",
               method = "exact") * 100000

# add columns to dataset from IR
cryptoreg <- cbind(cryptoreg, IR)



# We can graph this

# First we need to get rid of unnecessary variables
cryptoreg <- cryptoreg[ , c("region", "year", "est")]


# then we can spread the data with reshape
cryptoreg <- reshape(cryptoreg, 
                     idvar = "year", 
                     timevar = "region", 
                     direction = "wide")


# use matplot to plot columns 2 to 8 of your dataset
  # choose to plot lines with dots using pch = 1
matplot(cryptoreg$year, cryptoreg[, 2:8],   
        type = "o", 
        col = 1:7 , 
        pch = 1, 
        ylab = "Crude incidence rate", 
        xlab = "Year"
        )

# add a legend 
legend("topright", 
       legend = 1:7, 
       col = 1:7, 
       pch = 1)


#### Annual incidence rates by age #### 

# load your cleaned dataset
  # note that it is still called crypto
load("cryptorecodeddenom.Rda")

# First collapse the data by year and age 
  # (remember to use the denominator for age)

# sum the counts variable while grouping age, agegroup, year and denom
cryptoage <- aggregate(count ~ age + ar_age + year + den_age, 
                       FUN = sum, 
                       data = crypto)

# sort your dataset by year 
cryptoage <- cryptoage[order(cryptoage$year), ]


# Then in a second step collapse the data by age group and year
  # note that here we need to collapse the denominator data

# cbind collapses count and den_reg sepparately by year
cryptoage <- aggregate(cbind(count, den_age) ~ ar_age + year, 
                       FUN = sum, 
                       data = cryptoage)


# Calculating the annual incidence rates with 95% CI

# epiconf requires your counts and denoms to be in a matrix
  # select columns from your dataset using squarebrackets
  # change it to a matrix using as.matrix
IR <- epi.conf(as.matrix(cryptoage[, c("count", "den_age")]),
               ctype = "inc.rate",
               method = "exact") * 100000

# add columns to dataset from IR
cryptoage <- cbind(cryptoage, IR)



