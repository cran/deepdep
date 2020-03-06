## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.align = 'center', 
  fig.width = 7, 
  fig.height = 5
)

## ----DependenciesGraphs, eval = FALSE-----------------------------------------
#  #> an example from the website on github.io
#  library(devtools, quietly = TRUE)
#  install_github("datastorm-open/DependenciesGraphs")
#  library(DependenciesGraphs, quietly = TRUE)
#  
#  # you mus first loaded the target package using library
#  library(plyr,quietly = TRUE)
#  
#  dep <- Pck.load.to.vis("plyr")
#  plot(dep)
#  

## ----pkgnet, eval = FALSE-----------------------------------------------------
#  #> opens a report
#  library(pkgnet)
#  result <- CreatePackageReport('ggplot2')
#  

## ----miniCRAN-----------------------------------------------------------------
#> an example from official vignette
library(miniCRAN, quietly = TRUE)

tags <- "chron"
pkgDep(tags, availPkgs = cranJuly2014)

dg <- makeDepGraph(tags, enhances = TRUE, availPkgs = cranJuly2014)
set.seed(1)
plot(dg, legendPosition = c(-1, 1), vertex.size = 20)

## ----pkgDepTools, eval = FALSE------------------------------------------------
#  #> code not evaluated due to very long execution time
#  library(pkgDepTools)
#  library(Rgraphviz)
#  graph <- makeDepGraph("http://cran.fhcrc.org", type="source")
#  plot(graph)

