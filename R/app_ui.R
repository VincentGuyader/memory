#' @import shiny
#' @import nessy
app_ui <- function() {
  cartridge(
    title = "{Memory Size}",
    container_with_title(
      "Real time RAM size",
      # actionButton("prout","prout"),
      tableOutput("dt"),
      actionButton("more","+"),
      actionButton("less","-"),
      actionButton("gc","",icon = icon("trash")),
      plotOutput("dessin"),
      div(
      textOutput("count"),  numericInput(inputId = 'range','refresh',min = 1,max=500,value = 10)
    )
    )
  )
}
