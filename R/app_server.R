#' The application server-side

#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom pryr mem_used
#' @importFrom stats rnorm
#' @importFrom utils capture.output
#' @importFrom dplyr bind_rows
#' @noRd
app_server <- function(input, output, session) {


  history <- reactiveValues(v=data.frame(time=as.POSIXct(numeric(0),origin=Sys.Date()),mem_used = numeric(0),stringsAsFactors = FALSE))
  step_mo <- 500
  data <- reactiveValues(e=NULL)


  memory_info <-  reactive({
    invalidateLater(1000)
    mem_info() })

  observe({
    invalidateLater(2000)
    # browser()
    isolate({
      if (is.null(data$auto)) {
        data$auto <- 0
      }
      if (input$automatik) {
        data$auto <- data$auto + 1
      }
    })
  })
    
    
    
  
  
  observe({
    history$v <- dplyr::bind_rows(isolate(history$v),
                                  data.frame(time=Sys.time(),
                                             mem_used = as.numeric(memory_info()$used),
                                             stringsAsFactors = FALSE)
    )
  })

  output$count <- renderText({
    nrow(history$v)
  })
  output$dt <- renderTable({
    data.frame(memory = memory_info()$used,
               memory.free = memory_info()$free,
               memory.limit = memory_info()$total
    ) %>% mutate_all(nice_units)
  })

  output$dessin <- renderPlot({
    invalidateLater(input$range*1000)
    # input$prout
    isolate(mem_history(history$v))
  })
  observeEvent(c(input$more,data$auto),{
    message("more")
    message(capture.output(memory_info()$used))

    data$e<-append(data$e,list(rep(5,step_mo * 250 * 1000)))
  })
  observeEvent(input$less,{
    message("less")
    message(capture.output(memory_info()$used ))

    data$e <- data$e[-length(data$e)]
    gc()
  })
  observeEvent(input$gc,{
    message("gc")
    rm(list=ls())
    data$e<-NULL
    gc()
    message(capture.output(memory_info()$used ))
  })
}
