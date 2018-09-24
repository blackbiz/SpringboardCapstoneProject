#Setup
library(tidyverse)
library(digest)
library(lubridate)

# load data
anondata <- read_csv("data/AnonData.csv")

# transform to logical data frame
voted_df <- 
  anondata %>%
  select(matches("^E[0-9]+")) %>%
  mutate_all(~ !is.na(.x)) %>%
  print()
nm <- gsub("^E", "", names(voted_df))
nm <- as.character(as.Date(nm, "%m%d%y"))
names(voted_df) <- nm

# only valid dates
voted_df <- voted_df[, !is.na(nm)]

# update names
nm <- names(voted_df)
names(nm) <- nm

# checks
stopifnot(!anyNA(nm))
stopifnot(!anyNA(anondata$REG_DT))

registered_chr <- as.character(anondata$REG_DT)
registered_df <-
  registered_chr %>%
  purrr::map_dfr(~ as.list(nm >= .x)) 

df <- tibble(
  REG_DT = anondata$REG_DT,
  n_votes = rowSums(voted_df),
  n_reg = rowSums(registered_df)
) %>%
  mutate(vote_fraction = n_votes / n_reg) %>%
  print()
# Verified in Excel using n_votes =COUNTIF($AR2:$DX2,">0"), n_reg =COUNTIF($AR$1:$DX$1,">"&$U2), vote_fraction = =EA2

write_csv(df, path = "data/VoteFraction.csv", col_names = TRUE)

#mutate(anondata, )

## START NEW SCRIPT  USE R_MARKDOWN TO RECORD PROJECT- MULT VERSIONS
# Change all dates in file to international date standard

anon_names <- names(anondata)
anon_index <- 44:139
anon_elect <- anon_names[anon_index]
anon_nonE <- sub("^E", "", anon_elect)
anon_date <- as.Date(anon_nonE, "%m%d%y")
anon_date
anon_char_date <- as.character(anon_date)
anon_char_date[is.na(anon_char_date)] <- "deleteme"
anon_names[anon_index] <- anon_char_date
anon_names
names(anondata) <- anon_names
names(anondata)

## Remove "deleteme" columns
#NewData <- select(anondata, -deleteme)
#dat[ , !names(dat) %in% c("foo","bar")]
#setdiff(names(dat), c("foo", "bar"))

# Without delement columns names
# names(anondata) <- setdiff(names(anondata), "deleteme")

index <- which(names(anondata) == "deleteme")
anondata <- anondata[, -index]
#index
#length(index)
#139-11

# Continue EDA
summary(anondata[,44:128]) #Verify same columns after EDA update

str(anondata)

head(anondata)

names(anondata)

ggplot(anondata, aes(x = PARTY)) +
  geom_bar()

anondata %>%
  as_tibble() %>%
  mutate(AGE = 2018 - "BIRTHDATE") # Work on this

ggplot(anondata, aes(x= GENDER)) +
  geom_bar()

ggplot(anondata, aes(x= ADDR_CITY)) +
  geom_bar() +
  coord_flip()

#ggplot(anondata, aes(x= )) +
#  geom_histogram()

df <- anondata[,44:128]
df_names <- names(df)
names(df_names) <- df_names
df_TrueFalse <- anondata$REG_DT %>%
  map(~ df_names > as.character(.x))

# Presidential Election Dates
Pres_Elec_DT <- c(1988-11-08, 1992-11-03, 1996-11-05, 2000-11-07, 2004-11-02, 2008-11-04, 2012-11-06, 2016-11-08)