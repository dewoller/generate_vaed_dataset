library('tidyverse')
library(readr)
#setwd("~/Desktop")

mbs <- read_csv("mbs_to_check.csv")


summary( mbs)

mbs %>% 
  mutate( supply_date = if_else( 
    supply_date >= '2015-01-01', supply_date - 36500, supply_date
    )) %>%  write_csv("mbs_to_check.csv")

# Is the patient column consistent

mbs %>%
  select( patient_id ) %>%
  distinct( patient_id )


patient <- read_csv("patient.csv")


mbs %>%
  select( patient_id ) %>%
  distinct( patient_id ) %>%
  inner_join( patient )


mbs %>%
  select( patient_id ) %>%
  distinct( patient_id ) %>%
  anti_join( patient )


#keep mbs records which have corresponding patients, drop extra fields, save results
mbs %>%
  inner_join( patient , by='patient_id') %>%
  select(-yob, -sex,-state ) %>%
  {.} -> mbs1


# to check if all mismatch values are removed from mbs1
mbs1 %>%
  anti_join(patient)

mbs %>% count()
mbs1 %>% count()


mbs %>% distinct(patient_id) %>% count()
mbs1 %>% distinct(patient_id) %>% count()

mbs1 %>%
  filter(startsWith(provider_desc,'Dent') & startsWith(short_description,'Physio'))

#Repair short descriptions for 'Dent's doing 'Physio'
mbs1 %>%
  filter(startsWith(provider_desc,'Dent') & startsWith(short_description,'Physio')) %>%
  mutate( short_description = "Unknown Service")
        

#Repair short descriptions for 'Dent's doing 'Physio'
mbs1 %>%
  filter(startsWith(provider_desc,'Dent') & 
           startsWith(short_description,'Physio')) %>%
  mutate( short_description = "Unknown Service")


#Store corrected short descriptions
#Store corrected short descriptions
mbs1 %>%
  filter(startsWith(provider_desc,'Dent') & 
           startsWith(short_description,'Physio')) %>%
  mutate( short_description = "Unknown Service") %>%
  {.} -> mbs1_corrected_short_desc


# Combine originally correct with newly corrected
mbs1 %>%
  filter(! (startsWith(provider_desc,'Dent') & 
              startsWith(short_description,'Physio'))) %>%
  bind_rows(mbs1_corrected_short_desc ) %>%
  {.} -> mbs1_corrected

#Filter out rows with provider descriptions starting with ‘Dent’ that also have a short description starting with ‘Physiotherapy’
mbs1 %>%
  filter( startsWith(  provider_desc,'Dent')) %>%
  filter( startsWith(short_description,'Physio'))

#Filter and display provider descriptions starting with the initials ‘Dent’
mbs1 %>%
  distinct(provider_desc) %>% 
  arrange(provider_desc) %>%
  filter( str_detect( provider_desc,'^Dent'))


#Select Dent's doing 'Physio'
mbs1 %>%
  filter( str_detect( provider_desc,'^Dent') & 
            str_detect(short_description,'^Physio'))


#Repair short descriptions for 'Dent's doing 'Physio'
mbs1 %>%
  filter( str_detect( provider_desc,'^Dent') & 
            str_detect(short_description,'^Physio')) %>%
  mutate( short_description = "Unknown Service")


# Combine originally correct with newly corrected, store in mbs1_corrected
mbs1 %>%
  filter( !( str_detect( provider_desc,'^Dent') & 
               str_detect(short_description,'^Physio') )) %>%
  bind_rows(mbs1_corrected_short_desc ) %>%
  {.} -> mbs1_corrected

#Filter out rows with provider descriptions starting with ‘Dent’ that also have a short description starting with ‘Physiotherapy’
mbs1 %>%
  filter( str_detect( provider_desc,'^Dent') & 
            str_detect(short_description,'^Physio')) 

mbs1 %>% distinct( provider_desc )
