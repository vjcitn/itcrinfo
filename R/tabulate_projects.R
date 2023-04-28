#' produce a quick table of projects and annotations
#' @param url character(1) itcr.cancer.gov URL for tabular form of project descriptions
#' @return a data.frame with 3 variables: title, description, and tag
#' @note Table was read on 28 April 2023.  A serialization from that date is in the data folder.
#' @export
tabulate_projects = function(url = 
    "https://itcr.cancer.gov/informatics-tools-table") {
  basic = rvest::read_html("https://itcr.cancer.gov/informatics-tools-table")
  mat = basic %>% html_elements("td") %>% html_text2()
  mat = matrix(mat, nrow=4)
  dat = t(mat[1:3,])
  ans = data.frame(dat)
  names(ans) = c("title", "description", "tag")
  ans
}

itcrtags = function() c("-omics", "Clinical", "Data Standards", "Network Biology", 
"Imaging")

allocate_projects = function(table, tags = itcrtags()) {
  mytabs = vector("list", length(tags))
  names(mytabs) = tags
  for (i in tags) 
   mytabs[[i]] = table[grep(i, table$tag),]
  mytabs
}

#' tabbed tables for ITCR projects
#' @rawNamespace import(shiny, except=c("renderDataTable", "dataTableOutput"))
#' @import DT
#' @return just shiny app operation
#' @export
itcr_projects = function() {
  data("itcrtab_2023.04.27", package="itcrinfo")
  datl = allocate_projects(itcrtab_2023.04.27)
  server = function(input, output) {
    output$omics = DT::renderDataTable({
      datl$`-omics`
    })
    output$Clinical = DT::renderDataTable({
      datl$Clinical
    })
    output$DataStandards = DT::renderDataTable({
      datl$`Data Standards`
    })
    output$NetworkBiology = DT::renderDataTable({
      datl$`Network Biology`
    })
    output$Imaging = DT::renderDataTable({
      datl$Imaging
    })
  }
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
  runApp(list(ui=ui, server=server))
}
