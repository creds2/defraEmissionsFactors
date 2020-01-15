library(geofabric)
library(tidyverse)
west_yorks_data = get_geofabric("west-yorkshire")
table(west_yorks_data$highway)

west_yorks_motorways = west_yorks_data %>% 
  filter(highway == "motorway")

mapview::mapview(west_yorks_motorways)
