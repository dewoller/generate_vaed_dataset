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
  filter( feecharged < 400000 ) %>%
  filter( schedfee < 400000 ) %>%
  filter( benpaid < 400000 )  %>%
  {.} -> mbs4

mbs4 %>%
  filter( is.na(provider_id))


mbs4 %>%
  filter( !is.na(provider_id)) %>%
  {.} -> mbs5
