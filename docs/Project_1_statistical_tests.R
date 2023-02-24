# statistical testing for project 1: Marathon Time Predictions

# import packages
library(tidyverse)
library(MarathonProject)
library(cowplot)
library(patchwork)


# some data wrangling
marathon <- marathon %>%
  mutate(first_split_percent = round((Wall/MarathonTime*100), 2) )

marathon <- marathon %>%
  mutate( cross_train_y_n = ifelse(CrossTraining=="None", "No", "Yes") )


# testing the assumptions

# qq plots:
qqnorm(marathon$first_split_percent)
qqline(marathon$first_split_percent, col = "steelblue")

qqnorm(marathon$km4week)
qqline(marathon$km4week, col = "steelblue")


# simple linear regression test
first_split_percent_vs_MarathonTime <- lm(MarathonTime ~ first_split_percent, data = marathon )
summary(first_split_percent_vs_MarathonTime)

km4week_vs_MarathonTime <- lm(MarathonTime ~ km4week, data = marathon )
summary(km4week_vs_MarathonTime)

# residual plots
residuals.1 <- resid(first_split_percent_vs_MarathonTime)
plot(fitted(first_split_percent_vs_MarathonTime), residuals.1)
abline(0,0)

residuals.2 <- resid(km4week_vs_MarathonTime)
plot(fitted(km4week_vs_MarathonTime), residuals.2)
abline(0,0)

# 1 and 2

res_plot1 <- plot(first_split_percent_vs_MarathonTime, 1)
qq_plot1 <- plot(first_split_percent_vs_MarathonTime, 2)

plot_grid(qq_plot1, res_plot1)

res_plot2 <- plot(km4week_vs_MarathonTime, 1)
qq_plot2 <- plot(km4week_vs_MarathonTime, 2)

plot_grid(qq_plot2, res_plot2)

qq_plot1 + res_plot1




