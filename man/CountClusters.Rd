% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ClusterNumber.R
\name{CountClusters}
\alias{CountClusters}
\title{Use clustering consensus to infer cluster number}
\usage{
CountClusters(data, tol = 0.01, range = 1:20, eigengap = TRUE)
}
\arguments{
\item{data}{a symmetric nonnegative similarity matrix}

\item{tol}{cutoff for lambda zero}

\item{range}{a vector specifying the min and max
number of clusters to iteratively test when building the
consensus matrix}

\item{eigengap}{whether or not to use the max
eigengap (upper bound) cluster count}
}
\value{
the number of clusters
}
\description{
Use clustering consensus to infer cluster number
}