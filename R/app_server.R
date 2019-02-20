#' @import shiny
#' @importFrom pryr mem_used
#' @importFrom prettyunits pretty_bytes
#' @importFrom stats rnorm
#' @importFrom utils capture.output memory.limit
app_server <- function(input, output,session) {

  
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
  
  
  data <- reactiveValues(e=NULL)
  
  output$dt <- renderTable({
    invalidateLater(1000, session)
    data.frame(memory = capture.output(pryr::mem_used() )
               ,
               memory.free = memfree(),
               memory.limit = memlimit()
               
               )
    
  })
  
  observeEvent(input$more,{
    message("more")
    message(capture.output(pryr::mem_used() ))
    data$e<-append(data$e,list(matrix(rnorm(10000000),ncol=10)))
  })
  observeEvent(input$less,{
    message("less")
    message(capture.output(pryr::mem_used() ))
    
    data$e <- data$e[-length(data$e)]
  })
  observeEvent(input$gc,{
    message("gc")
    data$e<-NULL
    gc()
    message(capture.output(pryr::mem_used() ))
  })
}
