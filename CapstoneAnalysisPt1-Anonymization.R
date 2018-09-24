#Setup
library(tidyverse)
library(digest)
library(lubridate)

digest_each <- function(x) {
    purrr::map_chr(x, ~ digest::digest(.))
}
  
# load data
rawdata <- read_csv("data/09221483_RANDOM_ORDER.csv", n_max = 1000)

# Anonymize data
anon_cols <- c('VOTERID', 'FIRSTNAME', 'LASTNAME', 'ADDR_NUM', 'ADDR_FRAC', 'ADDR_DIR', 'ADDR_STR', 'ADDR_TYPE', 'ADDR_PDIR', 'ADDR_OTHER', 'ADDR_ZIP4', 'PHONE')

# Not dropping columns using rawdata %>% select(-one_of(anon_cols))

# Remove month and day from BIRTHDATE
#anondata <- mutate(rawdata,
#       VOTERID = digest_each(VOTERID), 
#       FIRSTNAME = digest_each(FIRSTNAME))

# Apply digest_each to all variables in one shot
#?mutate_at()
#mutate_at(.tbl, .vars, .funs, ..., .cols = NULL)
anondata <- mutate_at(
  .tbl = rawdata, .vars = anon_cols, .funs = "digest_each")

# Convert dates to "01/01" plus the record year format for BIRTHDATE
BIRTHTEMP <- as.Date(rawdata$BIRTHDATE, format = "%m/%d/%Y")
month(BIRTHTEMP) <- 01
day(BIRTHTEMP) <- 01
anondata$BIRTHDATE <- as.character(BIRTHTEMP)


# Repeat for REG_DT, LSTACT_DT, LSTVOT_DT, LSTCHG_DT
# Convert dates to "01/01" plus the record year format for REG_DT
REG_DT_TEMP <- as.Date(rawdata$REG_DT, format = "%m/%d/%Y")
month(REG_DT_TEMP) <- 01
day(REG_DT_TEMP) <- 01
anondata$REG_DT <- as.character(REG_DT_TEMP)

# Convert dates to "01/01" plus the record year format for LSTACT_DT
LSTACT_DT_TEMP <- as.Date(rawdata$LSTACT_DT, format = "%m/%d/%Y")
month(LSTACT_DT_TEMP) <- 01
day(LSTACT_DT_TEMP) <- 01
anondata$LSTACT_DT <- as.character(LSTACT_DT_TEMP)

# Convert dates to "01/01" plus the record year format for LSTVOT_DT
LSTVOT_DT_TEMP <- as.Date(rawdata$LSTVOT_DT, format = "%m/%d/%Y")
month(LSTVOT_DT_TEMP) <- 01
day(LSTVOT_DT_TEMP) <- 01
anondata$LSTVOT_DT <- as.character(LSTVOT_DT_TEMP)

# Convert dates to "01/01" plus the record year format for LSTCHG_DT
LSTCHG_DT_TEMP <- as.Date(rawdata$LSTCHG_DT, format = "%m/%d/%Y")
month(LSTCHG_DT_TEMP) <- 01
day(LSTCHG_DT_TEMP) <- 01
anondata$LSTCHG_DT <- as.character(LSTCHG_DT_TEMP)


## END HERE
write_csv(anondata, path = "data/AnonData.csv", col_names = TRUE)

