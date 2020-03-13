library('tidyverse')
library(readr)
setwd("~/Desktop")

mbs <- read_csv("mbs_to_check.csv")

mbs %>%
  filter( patient_id != '00006710520') %>%
  {.} -> mbs1


mbs1 %>%
  distinct( provider_desc ) %>% 
  arrange( provider_desc ) %>% 
  filter( startsWith( provider_desc, 'Dent'))



mbs1 %>%
  filter( startsWith( provider_desc, 'Dent'))  %>% 
  distinct( short_description ) %>% 
  filter( startsWith( short_description, 'Physiotherapy'))



mbs1 %>%
  filter( startsWith( provider_desc, 'Dent'))  %>% 
  filter( startsWith( short_description, 'Physiotherapy'))


mbs1 %>%
  filter( !(startsWith( provider_desc, 'Dent') 
          & startsWith( short_description, 'Physiotherapy'))
          ) %>%
          {.} -> mbs2
