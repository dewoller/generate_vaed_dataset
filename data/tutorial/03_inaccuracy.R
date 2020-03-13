library('tidyverse')
library(readr)
setwd("~/Desktop")

mbs <- read_csv("mbs_to_check.csv")

mbs %>%
  filter( patient_id != '00006710520') %>%
  filter( !(startsWith( provider_desc, 'Dent') 
            & startsWith( short_description, 'Physiotherapy'))) %>% 
            {.} -> mbs2

mbs2 %>% 
  count( mbs_id ) %>%
  arrange( desc( n ) ) %>%
  filter( n> 1) %>%
  {.} -> duplicated_mbs_id

mbs2 %>%
  anti_join( duplicated_mbs_id ) %>%
  { . } -> mbs3

summary( mbs3 )

mbs3 %>%
  filter(provider_category < 0 | provider_category > 650 ) %>%
  filter(provider_category != 9999 ) %>%
  
tibble::glimpse(mbs3)  


# what is the range of the mbs3 data
summary(mbs3)

# display a histogram, zooming in on 2015
mbs3 %>%
  filter( supply_date > '2014-01-01') %>%  
  filter( supply_date < '2016-12-31') %>%
  ggplot( aes( supply_date )) + geom_histogram()

# display a histogram, zooming in on 2015
mbs3 %>%
  filter( supply_date <= '2014-12-31') %>%
  ggplot( ) +
  aes( x=supply_date ) +
  geom_histogram()


ggplot(data=mbs3)+
  aes(x=benpaid)+
  aes(y= schedfee)+
  geom_point() 

ggplot(data = mbs3)+
  aes(x = benpaid)+
  aes(y = feecharged)+
  geom_point() 



mbs3%>% 
  filter(feecharged < 400000)%>%
  filter(benpaid < 400000)%>% 
  filter(schedfee < 400000)%>%
  {.}-> mbs4
  
ggplot( data=mbs4 ) +
  aes( x=benpaid ) +
  aes( y=schedfee ) +
  geom_point()


ggplot( data=mbs3 ) +
  aes( x=feecharged ) +
  aes( y=schedfee ) +
  geom_point()


mbs3 %>%
  filter( feecharged < 400000 ) %>%
  filter( schedfee < 400000 ) %>%
  filter( benpaid < 400000 )  %>%
  ggplot(  ) +
    aes( x=feecharged ) +
    aes( y=schedfee ) +
    geom_point()

mbs3 %>%
  filter( feecharged < 400000 ) %>%
  filter( schedfee < 400000 ) %>%
  filter( benpaid < 400000 )  %>%
  {.} -> mbs4



