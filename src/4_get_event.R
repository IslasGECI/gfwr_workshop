# port visits
# vamos a continuar con el ejemplo que teníamos antes

library(gfwr)
library(tidyr)
library(dplyr)

info_vessel <- gfw_vessel_info(query = 431782000, # puede ser un elemento o un vector
                               search_type = "search",
                               key = gfw_auth())

id_test2 <- info_vessel$selfReportedInfo$vesselId[1]

id_test2

visitas_puerto <- gfw_event(event_type = "PORT_VISIT",
          vessels = "2ca1c3012-2271-15cd-ea08-2e536333f615",
          start_date = "2017-01-26",
          end_date = "2022-12-31",
          key = gfw_auth())
names(visitas_puerto)

visitas_puerto %>% tidyr::unnest_wider(event_info)

# se puede filtrar por nivel de confianza
gfw_event(event_type = "PORT_VISIT",
          vessels = "2ca1c3012-2271-15cd-ea08-2e536333f615",
          start_date = "2017-01-26",
          end_date = "2022-12-31",
          confidence = c(4), # only for port visits
          key = gfw_auth())


gfw_event(event_type = "PORT_VISIT",
          vessels = c("2ca1c3012-2271-15cd-ea08-2e536333f615"),
          start_date = "2017-01-26",
          end_date = "2022-12-31",
          confidence = c(3), # only for port visits
          key = gfw_auth())


# GAPS - interrupciones en la transmisión

gaps <- gfw_event(event_type = "GAP",
          vessels = c("e0c9823749264a129d6b47a7aabce377",
                      "8c7304226-6c71-edbe-0b63-c246734b3c01"),
          start_date = "2017-01-26",
          end_date = "2023-02-04",
          key = gfw_auth())
gaps %>% unnest_wider(event_info) # para ver la información de cada evento

# da para filtrar por gaps intencionales
gfw_event(event_type = "GAP",
          vessels = c("e0c9823749264a129d6b47a7aabce377",
                      "8c7304226-6c71-edbe-0b63-c246734b3c01"),
          start_date = "2017-01-26",
          end_date = "2023-02-04",
          key = gfw_auth()) %>%
  unnest_wider(event_info)


