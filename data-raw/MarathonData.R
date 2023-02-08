#######
# Data cleaning

# load libraries
library(tidyverse)


# read in data
marathon = read.csv("/Users/garrett/Desktop/MarathonData.csv", row.names=1, stringsAsFactors = FALSE)
# head(marathon)


# view data structure
str(marathon)


# this data field was messed up so I manually corrected it
marathon[marathon$Name=="Nathan Khan", "sp4week"] <- 11.125


# removed columns that won't be used
marathon <- marathon %>%
  select(c(-Name, -Marathon))


# make the cross training column more readable
marathon$CrossTraining[marathon$CrossTraining == ""] <- "None"


# make this column numbers
marathon <- marathon %>%
  mutate(Wall21 = as.numeric(Wall21))

# change some column names for readability
marathon <- marathon %>%
  rename("FinishCategory" = CATEGORY) %>%
  rename("Wall" = Wall21)

# make these columns factors
marathon <- marathon %>%
  mutate(Category = as.factor(Category)) %>%
  mutate(CrossTraining = as.factor(CrossTraining)) %>%
  mutate(FinishCategory = as.factor(FinishCategory))

# remove NA fields
marathon <- na.omit(marathon)


# view data
#head(marathon)
view(marathon)
str(marathon)

# Save the data frame to the data/ directory
usethis::use_data(marathon, overwrite = TRUE)

