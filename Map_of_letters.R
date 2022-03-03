library(tidyverse)
library(leaflet)


#install.packages("parzer")
library(parzer)

#install.packages("maps")
#install.packages("mapdata")
#library(maps)       
#library(mapdata)


cities <- read_csv2('Final_Coordinates.csv', )
#cities


cities.dd = cities %>%
  mutate(Lon = parzer::parse_lon(Longitude),
         Lat = parzer::parse_lat(Latitude))

pal_cat <- colorFactor("Spectral", domain = cities.dd$Comment)


cities.dd %>%
  leaflet() %>%
  addProviderTiles(providers$Stamen.Toner)%>%
  addCircles(lng = ~Lon,
             lat = ~Lat, 
             label = ~Count,
             popup = ~City,
             color  = ~pal_cat(Comment),
             opacity = 0.9,
             weight= ~Weight*0.1)%>%
  addLegend(position = "bottomleft",
            title = 'Weight of the cities',
            pal = pal_cat,
            values = ~Comment
            )
