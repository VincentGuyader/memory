#' @import shiny
#' @import nessy
app_ui <- function() {
  cartridge(
    title = "{Memory Size}",
    container_with_title(
      "Real time RAM size",
      
      tableOutput("dt"),
      actionButton("more","+"),
      actionButton("less","-"),
      actionButton("gc","",icon = icon("trash"))
    )
  )
}
