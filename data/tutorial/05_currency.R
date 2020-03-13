
mbs <- read_csv("mbs5.csv")

summary(mbs5)

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
  filter( !is.na(provider_id)) %>%
  {.} -> mbs5

summary( mbs5 )


mbs5 %>%
  filter( supply_date < '2015-01-01' ) %>%
  {.} -> mbs6

summary( mbs6 )

ggplot( mbs5 ) +
  aes( x= supply_date ) +
  geom_bar()

ggplot( mbs5 ) +
  aes( x= substr( supply_date, 1, 7 ) ) +
  geom_bar()


mbs5 %>% 
  filter( as.character( supply_date ) >= '2014') %>%
  ggplot( ) +
    aes( x= substr( supply_date, 1, 7 ) ) +
    geom_bar()

mbs5 %>% 
  filter( as.character( supply_date ) >= '2004') %>%
  ggplot( ) +
  aes( x= substr( supply_date, 1, 4 ) ) +
  geom_bar()

