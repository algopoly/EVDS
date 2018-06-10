#'@export
#'@title Get Series
get_series <- function(series=c("TP.DK.USD.A","TP.DK.EUR.A"),start_date="01-10-2017",end_date="01-11-2017"){

  api_key = Sys.getenv("EVDS_KEY")

  series = paste(series,collapse="-")

  the_response <-
  httr::GET(paste0("https://evds2.tcmb.gov.tr/service/evds/series=",series,"&startDate=",start_date,"&endDate=",end_date,"&type=json&key=",api_key))

  json_content<-
  httr::content(the_response,as="text")

  jsonlite::fromJSON(json_content)
}

#'@export
#'@title Set API KEY
set_evds_key <- function(api_key){

  Sys.setenv(EVDS_KEY = api_key)

}

#'@export
#'@title Data Categories
get_category_list<-function(){

  api_key = Sys.getenv("EVDS_KEY")

  series = paste(series,collapse="-")

  the_response <-
  httr::GET(paste0("https://evds2.tcmb.gov.tr/service/evds/categories/type=json&key=",api_key))

  json_content<-
  httr::content(the_response,as="text")

  jsonlite::fromJSON(json_content)


}
