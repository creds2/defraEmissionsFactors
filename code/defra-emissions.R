library(tidyverse)
u2018 = "https://www.gov.uk/government/uploads/system/uploads/attachment_data/file/715425/Conversion_Factors_2018_-_Condensed_set__for_most_users__v01-01.xls"
f = file.path(tempdir(), "Conversion_Factors_2018_-_Condensed_set__for_most_users__v01-01.xls")
download.file(u2018, f)
cars_size = readxl::read_excel(f, sheet = "Passenger vehicles", skip = 45) %>%
  rename_all(snakecase::to_snake_case) %>% 
  rename_all(gsub, pattern = "kg_|_[0-9]+$", replacement = "")
propulsion_types = c("petrol", "diesel", "hybrid", "CNG", "LPG", "Unknown", "phev", "bev")
names(cars_size)[5:36] = paste(names(cars_size[5:36]), rep(propulsion_types, each = 4), sep = "_")
cars_size_co2 = cars_size %>% 
  select(-(1:2)) %>%
  select(matches("type|unit|co_2_[d|p|h]")) %>% 
  filter(unit == "km") %>% 
  slice(1:4) %>% 
  select(-unit) %>% 
  mutate(co_2_petrol = as.numeric(co_2_petrol))
