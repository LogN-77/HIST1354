install.packages("dplyr")
install.packages("ggplot2")

library(dplyr)
library(ggplot2)

census_data <- read.csv("census_data.csv") 
county_codes <- read.csv("county_codes.csv")

colnames(county_codes) <- gsub(" ", "_", colnames(county_codes))

davidson_county_info <- county_codes[county_codes$State == "Tennessee" & county_codes$County == "Davidson", ]

state_code <- davidson_county_info$STATEICP
county_code <- davidson_county_info$County_cod

davidson_census <- census_data[census_data$stateicp == state_code &
                                 census_data$county == county_code &
                                 census_data$year %in% c(1820, 1830, 1840), ]

davidson_census_summary <- aggregate(ntotal ~ year, data = davidson_census, sum, na.rm = TRUE)
print(davidson_census_summary)

library(ggplot2)
ggplot(davidson_census_summary, aes(x = year, y = ntotal)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Population of Davidson County (1820-1840)",
    x = "Year",
    y = "Total Population"
  ) +
  theme_minimal()


