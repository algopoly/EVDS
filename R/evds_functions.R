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
#' @param series,start_date,end_date The desired series should be put in the series in a vector form.
#' @param start_date,end_date These are in form of `date_format`.
#' @param date_format Date format. If Ymd, it is transformed to dd-mm-YYYY format because of CBRT EVDS requirements. It only accepts Ymd (YYYY-mm-dd) or dmY as input. (Default format: dmY)
#' @export
#' @examples
#' get_series(series=c("TP.DK.USD.A","TP.APIFON4"), start_date = "20-05-2010", end_date = "20-05-2018")
#' @title Get Series
get_series <- function(series=c("TP.DK.USD.A","TP.DK.EUR.A"),start_date="01-10-2017",end_date="01-11-2017",date_format="dmY"){

  if(date_format=="Ymd"){
    start_date <- format(as.Date(start_date),"%d-%m-%Y")
    end_date <- format(as.Date(end_date),"%d-%m-%Y")
  }else if(date_format != "dmY"){
    stop("Wrong date format!")
  }

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
#' This function allows you to preview the category of series you want to work on from the EVDS website. You need this function to preview category names.This category name could further used in previewing the data groups.
#' @export
#' @title Data Categories
show_categories<-function(){

  the_phrase<-
  paste0("https://evds2.tcmb.gov.tr/service/evds/categories/")

  get_data_from_phrase(the_phrase)


}


#' Show Series Based on Category Function
#'
#' This function allows you to preview the series from a specific data group you want to work on from the EVDS website.You can get the name of the datagroups by using `show_categories`function.
#' @param ccode Category code
#' @export
#' @example show_serie_lists("bie_fafaiz")
#' @title List of series based on a category code or name
show_serie_lists<-function(ccode){

  the_phrase<-
  paste0("https://evds2.tcmb.gov.tr/service/evds/serieList/code=",ccode)

  get_data_from_phrase(the_phrase)


}

#' Show All Series Function
#'
#' This function allows you to preview all the series on the EVDS website.
#' @export
#' @title List of series
all_series <- function(){


  all_dg <- show_datagroups()

  the_df<- show_serie_lists(all_dg$DATAGROUP_CODE[1])

  for(i in 2:length(all_dg$DATAGROUP_CODE)){
    the_df <- bind_rows(the_df,show_serie_lists(all_dg$DATAGROUP_CODE[i]))
  }

  write_xlsx(the_df, "allSeries.xlsx")


}
