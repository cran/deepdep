#' @title Plot download count of CRAN packages.
#'
#' @description This function uses \href{https://github.com/r-hub/cranlogs}{\bold{API}} of
#' \href{http://cran-logs.rstudio.com/}{\bold{CRAN Logs}} to scrap the download logs of the packages and
#' then plots the data. It works on objects of class \code{character} (vector),
#' \code{deepdep}, \code{package_dependencies} and \code{package_downloads}.
#'
#' @param x A \code{character} vector. Names of the packages that are on CRAN.
#' @param from A \code{Date} class object. From which date plot the data. By default it's one year back.
#' @param to A \code{Date} class object. To which date plot the data. By default it's now.
#' @param ... Ignored.
#'
#' @return A \code{ggplot2} class object.
#'
#' @examples
#'
#' \donttest{
#' library(deepdep)
#'
#' plot_downloads("htmltools")
#'
#' dd <- deepdep("ggplot2")
#' plot_downloads(dd)
#' }
#'
#' @importFrom stats time
#' @rdname plot_downloads
#' @export
plot_downloads <- function(x, ...) {
  UseMethod("plot_downloads")
}

#' @rdname plot_downloads
#' @export
plot_downloads.default <- function(x, ...) {
  stop("This type of object does not have implemented method for 'plot_downloads'")
}

#' @rdname plot_downloads
#' @export
plot_downloads.deepdep <- function(x, from = Sys.Date() - 365, to = Sys.Date(), ...) {
  
  temp <- c(attr(x, "package_name"), unique(as.character(x$name)))
  plot_downloads(temp, from, to, ...)
}

#' @rdname plot_downloads
#' @export
plot_downloads.package_dependencies <- function(x, from = Sys.Date() - 365, to = Sys.Date(), ...) {
  
  temp <- c(attr(x, "package_name"), unique(as.character(x$name)))
  plot_downloads(temp, from, to, ...)
}

#' @rdname plot_downloads
#' @export
plot_downloads.package_downloads <- function(x, from = Sys.Date() - 365, to = Sys.Date(), ...) {
  
  temp <- attr(x, "package_name")
  plot_downloads(temp, from, to, ...)
}

#' @rdname plot_downloads
#' @export
plot_downloads.character <- function(x, from = Sys.Date() - 365, to = Sys.Date(), ...) {
  # Due to NSE inside of the function, we have to declare "package_name" as NULL to prevent check fail
  package_name <- NULL
  
  if (!require_packages(c("ggplot2", "scales"),
                        use_case = "plot download statistics"))
    stop("Missing necessary packages.")
  
  # add some x check
  
  ind <- NULL
  
  for (i in seq_along(x)) {
    tryCatch(check_package_name(x[i], FALSE, FALSE),
             error = function(e) {
               warning(paste0(x[i], " is not on CRAN."))
               ind <- c(ind, i)
             }
    )
  }
  
  if (!is.null(ind)) x <- x[-ind]
  
  n <- to - from - 1
  if (n <= 0) stop("'to' argument is not greater than 'from'")
  
  data <- data.frame(matrix(NA, ncol = length(x), nrow = n))
  colnames(data) <- x
  
  for (i in seq_along(x)) {
    package <- x[[i]]
    
    downloads <- cranlogs::cran_downloads(package, from = from, to = to)
    
    # remove zeros from last two days without data
    l <- length(downloads$count)
    downloads_count <- downloads$count[-c(l, l - 1)]
    
    data[package] <- downloads_count
  }
  
  # base::reshape is hard
  data_long <- reshape(data, direction  = "long", varying = list(seq_along(x)),
                       times = names(data), timevar = "package_name",
                       v.names = "downloads", idvar = "time")
  
  data_long$time <- downloads$date[-c(l, l - 1)]
  
  ggplot2::ggplot(data_long, ggplot2::aes(time, downloads, color = package_name)) +
    ggplot2::geom_smooth(se = FALSE) +
    ggplot2::scale_x_date() +
    ggplot2::scale_y_continuous(labels = scales::comma) +
    ggplot2::xlab("date") +
    ggplot2::ylab("daily downloads") +
    ggplot2::ggtitle(paste0("Daily downloads for dependencies of the ", x[1], " package")) +
    ggplot2::theme_minimal() +
    ggplot2::theme(legend.position = "bottom",
                   legend.title = ggplot2::element_blank())
}
