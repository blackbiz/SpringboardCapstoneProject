#Setup
library(tidyverse)
library(digest)
library(lubridate)

# load data
anondata <- read_csv("data/AnonData.csv")


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
summary(anondata[,44:128])

str(anondata)

head(anondata)

names(anondata)

ggplot(anondata, aes(x = PARTY)) +
  geom_bar()

anondata %>%
  as_tibble() %>%
  mutate(AGE = 2018 - 0)

ggplot(anandata, aes(x= )) +
  geom_histogram()
