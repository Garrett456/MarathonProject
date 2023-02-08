#######
# Data cleaning code

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

# remove NA fields
marathon <- na.omit(marathon)


# change some column names for readability
marathon <- marathon %>%
  rename("FinishCategory" = CATEGORY) %>%
  rename("Wall" = Wall21)


# view data
#head(marathon)
view(marathon)

# Save the data frame to the data/ directory
usethis::use_data(marathon)
