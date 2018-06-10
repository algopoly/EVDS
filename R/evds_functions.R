#'@export
#'@title Set API KEY
set_evds_key <- function(api_key){

  Sys.setenv(EVDS_KEY = api_key)

}

#'@title Common Wrapper for Data Parsing
get_data_from_phrase <- function(the_phrase){

  api_key = Sys.getenv("EVDS_KEY")

  if(api_key == ""){
    stop("You should set your API key. See ?set_evds_key function.")
  }

  the_phrase <- paste0(the_phrase,"&type=json&key=",api_key)

  the_response <-
  httr::GET(the_phrase)

  if(the_response$status == 500){
    stop("Status 500. Check API Key.")
  }

  json_content<-
  httr::content(the_response,as="text",encoding="UTF-8")

  jsonlite::fromJSON(json_content)

}

#'@export
#'@title Get Series
get_series <- function(series=c("TP.DK.USD.A","TP.DK.EUR.A"),start_date="01-10-2017",end_date="01-11-2017"){

  series = paste(series,collapse="-")

  the_phrase <- paste0("https://evds2.tcmb.gov.tr/service/evds/series=",series,"&startDate=",start_date,"&endDate=",end_date)

  get_data_from_phrase(the_phrase)

}


#'@export
#'@title Data Groups
show_datagroups<-function(data_mode="all"){

  if(data_mode=="all"){
    data_mode <- 0
  }else{
    stop("This part is not yet finished.")
  }

  the_phrase<-
  paste0("https://evds2.tcmb.gov.tr/service/evds/datagroups/mode=",data_mode)

  get_data_from_phrase(the_phrase)


}


#'@export
#'@title Data Categories
show_categories<-function(){

  the_phrase<-
  paste0("https://evds2.tcmb.gov.tr/service/evds/categories/")

  get_data_from_phrase(the_phrase)


}

#'@export
#'@title List of series based on a category code or name
show_serie_lists<-function(ccode){

  the_phrase<-
  paste0("https://evds2.tcmb.gov.tr/service/evds/serieList/code=",ccode)

  get_data_from_phrase(the_phrase)


}
