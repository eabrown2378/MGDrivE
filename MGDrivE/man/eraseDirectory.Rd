% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MGDrivE-Auxiliary.R
\name{eraseDirectory}
\alias{eraseDirectory}
\title{Erase all files in a directory}
\usage{
eraseDirectory(directory, verbose = TRUE)
}
\arguments{
\item{directory}{Directory whose contents will be deleted}

\item{verbose}{Chatty? Default is TRUE}
}
\description{
Given a directory path, check that it exists, and if so, delete all its contents.
}
\examples{
\dontrun{
# Path to directory, can tilde expand
myPath <- "~/path/to/write/output"

# Erase directory
#  No return value
eraseDirectory(directory = myPath)
}

}
