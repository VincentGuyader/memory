#' @importFrom prettyunits pretty_bytes
#' @importFrom utils capture.output memory.limit
memlimit <- function(){
  
  if (.Platform$OS.type == "windows") {
    out <-  prettyunits::pretty_bytes(memory.limit()*1000000)
  }else{
    out <-   as.numeric(system("awk '/MemTotal/ {print $2}' /proc/meminfo",intern=TRUE))  *10000
  }
  out
  
}
memfree <- function(){
  
  if (.Platform$OS.type == "windows") {
    out <-  NA
  }else{
    out <-   as.numeric(system("awk '/MemFree/ {print $2}' /proc/meminfo",intern=TRUE))  *10000
  }
  out
  
}
# memfree <- as.numeric(system("awk '/MemFree/ {print $2}' /proc/meminfo",intern=TRUE))  
