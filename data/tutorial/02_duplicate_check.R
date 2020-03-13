library('tidyverse')
library(readr)
setwd("~/mydoc/teaching/hdi/generate_data/data/tutorial")

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
  inner_join(duplicated_mbs_id) %>%
  distinct() %>%
  count(mbs_id) %>%
  filter( n == 1 )

  
# we could filter it out line by line, for example
mbs2 %>%
  filter( mbs_id != 11206 &
            mbs_id != 11530)

# but it is better to filter it out as an entire bunch
mbs2 %>%
  anti_join( duplicated_mbs_id ) %>%
  { . } -> mbs3


# Check 
mbs3 %>% 
  count( mbs_id ) %>%
  arrange( desc( n ) )
  
# Should have the same number as mbs3 records
mbs3 %>% 
  distinct( mbs_id ) 
  
