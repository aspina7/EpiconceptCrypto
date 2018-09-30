
# Case study on surveillance data analysis; cryptosporidosis
# Lore Merdrignac and Esther Kissling
# EpiConcept
# Created Oct 2016, revised July 2018
# R-code written by Alexander Spina September 2018


#### Installing packages ####


# install the epiR package and packages it depends on
# install.packages("epiR", dependencies = TRUE)


# Installing multiple required packages for the case study
# required_packages <- c("epiR", "broom")
# install.packages(required_packages, dependencies = TRUE)

# If unsure whether the packages installed use for-loop.
# Installing required packages for this case study
for (pkg in required_packages) {
  if (!pkg %in% rownames(installed.packages())) {
    install.packages(pkg)
  }
}


#### Loading packages to session ####

# loading one package
library(epiR)

# Loading multiple packages
# Loading required packages for this case study
required_packages <- c("epiR", "broom")

for (i in seq(along = required_packages)) {
  library(required_packages[i], character.only = TRUE)
}


#### Setting working directory ####


# Check your current working directory
getwd()

# choose your folder path 
# setwd("C:/Users/Username/Desktop/EpiconceptCrypto")



#### Reading in datasets ####

# If an english computer than seperator may be ","
  # Do not want to convert strings to factors 
crypto <- read.csv("crypto.csv", sep = ";" , 
                   stringsAsFactors = FALSE )

#### Data checking #### 

# Familiarise yourself with the data 

# str provides an overview of the number of observations and variable types
str(crypto)

# summary provides mean, median and max values of your variables
summary(crypto)



# Completeness

# Examine how many are missing or unknown in the AgeY variable 
table(is.na(crypto$AgeY) | crypto$AgeY == "Unknown")

# missing, unknown or not specified in the PatientType variable
table(is.na(crypto$PatientType) | 
        crypto$PatientType == "Unknown" | 
        crypto$PatientType == "Not Specified")

# missing, unknown or not specified in the CountryofInfection variable
table(is.na(crypto$CountryofInfection) | 
        crypto$CountryofInfection == "Unknown" | 
        crypto$CountryofInfection == "Not specified")


# Date validity

# change date variabels from characters to dates 

crypto$Notif_Date <- as.Date(crypto$Notif_Date, format = "%d.%m.%Y")
crypto$OnsetDate <- as.Date(crypto$OnsetDate, format = "%d.%m.%Y")


# check number not missing with onset on or before notification date

table(!is.na(crypto$Notif_Date) & 
        crypto$OnsetDate <= crypto$Notif_Date)


# Check for IDs with invalid dates (two methods)

# return IDs, onset and notification dates for those with onset after notification
subset(
  x = crypto,
  subset = !is.na(crypto$Notif_Date) &
    crypto$OnsetDate > crypto$Notif_Date,
  select = c("ID", "OnsetDate", "Notif_Date")
)


# return IDs, onset and notification dates for those with onset after notification

crypto[which(!is.na(crypto$Notif_Date) &
               crypto$OnsetDate > crypto$Notif_Date), c("ID", "OnsetDate", "Notif_Date")]


# Age: Checking if all ages are within a reasonable age range

# replace unknown with NA 
crypto$AgeY[crypto$AgeY == "Unknown"] <- NA

# create new age variable as numeric of AgeY
crypto$age <- as.numeric(crypto$AgeY)

# summary provides mean, median and max values of age
summary(crypto$age)



# Histogrammes of continuous variables/dates, checking for unusual patterns/outliers

# Plot a histogram of age
hist(crypto$age,
     xlab = "Age",
     ylab = "Count"
)

# save histogram of age as a png file
dev.copy(png,'age.png')
dev.off()


# plot histogram of notification date
# choose days and frequency
hist(crypto$Notif_Date,
     breaks = "days",
     freq = TRUE,
     xlab = "Notification date",
     ylab = "Count"
)

# save as a png
dev.copy(png,'notificationdate.png')
dev.off()



#plot histogram of onset date
#choose days and frequency
hist(crypto$OnsetDate,
     breaks = "days",
     freq = TRUE,
     xlab = "Onset date",
     ylab = "Count"
)

#save as a png
dev.copy(png,'onsetdate.png')
dev.off()

