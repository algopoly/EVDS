#' Set EVDS key
#'
#' This function allows you to set your API key. You will need this key to export data from the EVDS website.
#' @param api_key Your API key from the EVDS website.
#' @export
#' @examples
#' set_evds_key("YOURAPIKEY")
#' @title Set API KEY
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

#' Get series Function
#'
#' This function allows you to get series you want to work on from the EVDS website. You can also choose the dates you want to get the data from.
#' @param series,start_date,end_date The desired series should be put in the series in a vector form. start_date and end_date are in form dd-mm-YYYY.
#' @export
#' @examples
#' get_series(series=c("",""), start_date = "dd-mm-YYYY", end_date = "dd-mm-YYYY")
#' @title Get Series
get_series <- function(series=c("TP.DK.USD.A","TP.DK.EUR.A"),start_date="01-10-2017",end_date="01-11-2017"){

  series = paste(series,collapse="-")

  the_phrase <- paste0("https://evds2.tcmb.gov.tr/service/evds/series=",series,"&startDate=",start_date,"&endDate=",end_date)

  get_data_from_phrase(the_phrase)

}

#' Show Data Groups Function
#'
#' @export
#' @title Data Groups
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


#' Show Data Categories Function
#'
#' This function allows you to preview the category of series you want to work on from the EVDS website.
#' @export
#' @title Data Categories
show_categories<-function(){

  the_phrase<-
  paste0("https://evds2.tcmb.gov.tr/service/evds/categories/")

  get_data_from_phrase(the_phrase)


}


#' Show Data Groups Function
#'
#' This function allows you to preview the series you want to work on from the EVDS website.
#' @param ccode Category code
#' @export
#' @title List of series based on a category code or name
show_serie_lists<-function(ccode){

  the_phrase<-
  paste0("https://evds2.tcmb.gov.tr/service/evds/serieList/code=",ccode)

  get_data_from_phrase(the_phrase)


}
