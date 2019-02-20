#' @import shiny
#' @importFrom pryr mem_used
#' @importFrom stats rnorm
#' @importFrom utils capture.output
#' @importFrom dplyr bind_rows
#' 
app_server <- function(input, output,session) {

  
  history <- reactiveValues(v=data.frame(time=as.POSIXct(numeric(0),origin=Sys.Date()),mem_used = numeric(0),stringsAsFactors = FALSE))
  
  data <- reactiveValues(e=NULL)
  
  used <-  reactive({
    invalidateLater(1000)
    pryr::mem_used() })
  
  observe({
    history$v <- dplyr::bind_rows(isolate(history$v),
              data.frame(time=Sys.time(),
              mem_used = as.numeric(used()),
              stringsAsFactors = FALSE)
    )
  })
  
  output$count <- renderText({
    nrow(history$v)
  })
  output$dt <- renderTable({
    data.frame(memory = capture.output(used()),
               memory.free = memfree(),
               memory.limit = memlimit()
               )
  })
  
  output$dessin <- renderPlot({
    invalidateLater(input$range*1000)
    # input$prout
    isolate(mem_history(history$v))
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
