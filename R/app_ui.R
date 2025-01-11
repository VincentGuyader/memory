#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import nessy
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    cartridge(
      title = "{Memory Size}",
      container_with_title(
        "Real time RAM size",
        # actionButton("prout","prout"),
        tableOutput("dt"),
        actionButton("more","+"),
        actionButton("less","-"),
        actionButton("gc","",icon = icon("trash")),
        checkboxInput("automatik",label="auto increase"),
        plotOutput("dessin"),
        div(
          textOutput("count"),  numericInput(inputId = 'range','refresh',min = 1,max=500,value = 10)
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "memory"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
