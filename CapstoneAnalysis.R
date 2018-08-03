# Voter Pattern Analysis and Prediction Capstone

# Setup
library(tidyverse)
getwd()
setwd("C:/Users/craig/Documents/VoterData/")
getwd()

# Load Data
voter_small <- read_csv("data/VoterDataSmall1000.csv")

# Anonymize Data
head(select(voter_small, -VOTERID, -FIRSTNAME, -LASTNAME, -))


rawload <- read_csv("VoterDataSmall100.csv")

SubsetAddy2 <- read_csv("VoterDataSmall100.csv", na = "") %>% 
  select(ADDR_NUM, ADDR_DIR, ADDR_STR, ADDR_TYPE, ADDR_CITY, STATE, ADDR_ZIP)


# demoload <- read_csv("VoterDataSmall100.csv", cols(ADDR_STR, .default = col_guess()))

# cols(ADDR_STR, .default = col_guess())

# Pull address data to create address geocode reference table. (NA's need some love)
# RawAddy <- read_csv("09221483_RANDOM_ORDER.csv") %>% 
#   select(ADDR_NUM, ADDR_DIR, ADDR_STR, ADDR_TYPE, ADDR_CITY, STATE, ADDR_ZIP)

write_excel_csv(RawAddy, path = "RawAddyOnly.csv", col_names = TRUE)

write_excel_csv(SubsetAddy2, path = "DeleteMeDemo.csv", col_names = TRUE)

## na = c("", "NA")

