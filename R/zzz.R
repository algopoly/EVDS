# .onAttach <- function(...) {
#       cat("message from .onAttach via cat\n")
#       message("message from .onAttach via message")
#       packageStartupMessage("message from .onAttach via
# packageStartupMessage\n")
#   }
.onLoad <- function(...){
      # cat("message from .onLoad via cat\n")
      # message("message from .onLoad via message")
      packageStartupMessage("EVDS requires an API key from CBRT. Get yours from https://evds2.tcmb.gov.tr/index.php?/evds/editProfile \n
      All functions require an API key so you should set your key with set_evds_key(\"YOURAPIKEY\") function.")
}
