.onLoad <- function(...){
      packageStartupMessage("EVDS requires an API key from CBRT. Get yours from https://evds2.tcmb.gov.tr/index.php?/evds/editProfile \n
      All functions require an API key so you should set your key with set_evds_key(\"YOURAPIKEY\") function.")
}
