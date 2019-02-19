#' @import shiny
#' @importFrom pryr mem_used
app_server <- function(input, output,session) {
  # List the first level callModules here
  
  data <- reactiveValues(e=NULL)
  
  output$dt <- renderTable({
    invalidateLater(1000, session)
    data.frame(memory = capture.output(pryr::mem_used() ))
    
  })
  
  observeEvent(input$more,{
    message("more")
    data$e<-append(data$e,list(matrix(rnorm(10000000),ncol=10)))
  })
  observeEvent(input$less,{
    message("less")
    data$e <- data$e[-length(data$e)]
  })
  observeEvent(input$gc,{
    message("gc")
    data$e<-NULL
    gc()
  })
}
