library(shiny)

  ui = fluidPage(
   sidebarLayout(
    sidebarPanel(
     helpText("ITCR Projects, April 2023"),
     helpText("Projects are described in tables under tabs that were
used as tags at the itcr.cancer.gov/ informatics-tools-table site"),
     width=2
     ),
    mainPanel(
     tabsetPanel(
      tabPanel("-omics", DT::dataTableOutput("omics")),
      tabPanel("Clinical", DT::dataTableOutput("Clinical")),
      tabPanel("Data Standards", DT::dataTableOutput("DataStandards")),
      tabPanel("Network Biology", DT::dataTableOutput("NetworkBiology")),
      tabPanel("Imaging", DT::dataTableOutput("Imaging"))
      )
     )
    )
   )
