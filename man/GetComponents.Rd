% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ClusterNumber.R
\name{GetComponents}
\alias{GetComponents}
\title{Get graph components}
\usage{
GetComponents(data, tol = 0.01)
}
\arguments{
\item{data}{a symmetric nonnegative similarity matrix}

\item{tol}{cutoff for lambda zero}
}
\value{
the number of components
}
\description{
Use the graph laplacian to get the number of graph components.
}
