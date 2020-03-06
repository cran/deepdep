## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(deepdep)

## ----use_case, eval=FALSE-----------------------------------------------------
#  plot_deepdep("YourPackageName")

## ----get_ava_pkg1-------------------------------------------------------------
t <- get_available_packages()
head(t, 100)

## ----get_ava_pkg2-------------------------------------------------------------
t <- get_available_packages(bioc = TRUE)
head(t, 100)

## ----get_ava_pkg3-------------------------------------------------------------
t <- get_available_packages(local = TRUE)
head(t, 100)

## ----get_description1---------------------------------------------------------
get_description("DALEXtra")

## ----get_description2---------------------------------------------------------
get_description("a4")
get_description("a4", bioc = TRUE)

## ----get_downloads------------------------------------------------------------
get_downloads("ggplot2")

## ----get_dependencies1--------------------------------------------------------
get_dependencies("ggplot2")

## ----get_dependencies2--------------------------------------------------------
get_dependencies("ggplot2", downloads = FALSE, dependency_type = c("Imports", "Suggests", "Enhances"))

## ----deepdep------------------------------------------------------------------
deepdep("ggplot2", depth = 2)

## ----plot_dependencies1, fig.align='center', fig.width=7, fig.height=6--------
dd <- deepdep("tibble", 2)
plot_dependencies(dd)
plot_dependencies("DT", depth = 2, dependency_type = c("Imports", "Depends", "Suggests"))

## ----plot_dependencies2, fig.align='center', fig.width=7, fig.height=6--------
plot_dependencies(dd, type = "tree")

## ----plot_dependencies3, fig.align='center', fig.width=7, fig.height=6--------
plot_dependencies(dd, same_level = TRUE)

## ----plot_dependencies4, fig.align='center', fig.width=7, fig.height=6, warning=FALSE----
plot_dependencies("tidyverse", type = "circular", label_percentage = 0.2, downloads = TRUE, depth = 3)

## ----plot_dependencies5, fig.align='center', fig.width=7, fig.height=6--------
plot_dependencies(dd) +
  ggplot2::scale_fill_manual(values = c("#462CF8", "#F23A90", "#AF1023")) +
  ggraph::scale_edge_color_manual(values = "black") 

## ----caches, eval=FALSE-------------------------------------------------------
#  get_available_packages(reset_cache = TRUE)

