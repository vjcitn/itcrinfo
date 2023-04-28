
  library(itcrinfo)
  data("itcrtab_2023.04.27", package="itcrinfo")
  datl = itcrinfo:::allocate_projects(itcrtab_2023.04.27)
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
