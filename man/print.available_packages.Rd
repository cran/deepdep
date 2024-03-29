% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_available_packages.R
\name{print.available_packages}
\alias{print.available_packages}
\title{Print function for an object of \code{available_packages} class}
\usage{
\method{print}{available_packages}(x, ...)
}
\arguments{
\item{x}{An object of \code{available_packages} class.}

\item{...}{other}
}
\description{
Print function for an object of \code{available_packages} class
}
\examples{
\donttest{
library(deepdep)

av <- get_available_packages()
head(av)
}

}
