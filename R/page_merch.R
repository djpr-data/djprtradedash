page_merch <- function(...) {
  # djpr_tab_panel(
  selecter_height <- 325
  inner_height <- selecter_height - 44

  tabPanel(
    title = "Merchandise exports",
    tags$head(
      tags$style(paste0(".multi-wrapper {height: ", selecter_height, "px;}")),
      tags$style(paste0(
        ".multi-wrapper .non-selected-wrapper, .multi-wrapper .selected-wrapper {height: ",
        inner_height,
        "px;}"
      ))
    ),
    # ggiraph_js(),
    value = "tab-merchandise-exports",
    # toc_space = 2,
    # right_space = 1,
    br(),
    br(),
    h1("Merchandise Exports Data Explorer"),
    fluidRow(
      column(
        4,
        shinyWidgets::multiInput(
          inputId = "merch_countries",
          label = "Export destinations: ",
          choices = sort(unique(as.character(merch$country_dest))),
          selected = c("Thailand", "Malaysia"),
          width = "100%",
          options = list(
            non_selected_header = "All destinations:",
            selected_header = "Selected destinations:"
          )
        ),
        shinyWidgets::multiInput(
          inputId = "merch_sitc",
          label = "Goods",
          choices = "",
          selected = "Medicinal and pharmaceutical products (excl. medicaments of group 542)",
          width = "100%",
          options = list(
            non_selected_header = "All goods:",
            selected_header = "Selected goods:"
          )
        )
      ),
      column(
        8,
        # djpr_plot_ui("merch_explorer")
        fluidRow(
          column(
            4,
            shinyWidgets::awesomeRadio(
              inputId = "merch_explorer_sitc",
              label = "SITC Level: ",
              choices = c(
                1,
                2,
                3,
                "All"
              ),
              selected = 3,
              inline = TRUE,
              status = "primary"
            )
          ),
          column(
            4,
            shinyWidgets::awesomeRadio(
              inputId = "merch_explorer_facets",
              label = "Facet on: ",
              choices = c(
                "Destination country" = "country_dest",
                "Good type" = "sitc"
              ),
              selected = "country_dest",
              inline = TRUE,
              status = "primary"
            )
          ),
          column(
            4,
            "Smooth using:\n",
            shinyWidgets::materialSwitch("merch_explorer_smooth",
              label = "12 month rolling average",
              status = "primary",
              value = TRUE
            )
          )
        ),
        plotOutput("merch_explorer",
          height = "600px"
        ),
        fluidRow(
          column(
            8,
            sliderInput("merch_explorer_dates",
              label = "",
              min = min(merch$date),
              max = max(merch$date),
              value = c(
                min(merch$date),
                max(merch$date)
              ),
              dragRange = TRUE,
              timeFormat = "%b %Y",
              ticks = FALSE
            )
          ),
          column(
            4,
            br(),
            djprshiny::download_ui("merch_explorer_dl")
          )
        )
      )
    ),
    br(),
    centred_row(htmlOutput("merch_footnote")),
    br()
  )
}
