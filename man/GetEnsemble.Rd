% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ClusterNumber.R
\name{GetEnsemble}
\alias{GetEnsemble}
\title{Produce consensus matrix}
\usage{
GetEnsemble(data, tol, n_comp = 3, tau, range = 2:20)
}
\arguments{
\item{data}{a symmetric nonnegative similarity matrix}

\item{tol}{cutoff for lambda zero}

\item{n_comp}{the number of similarity components to use for ensemble clustering}

\item{tau}{the drop tolerance, controlling the sparsification
(uncoupling) of the consensus matrix}

\item{range}{a vector specifying the min and max
number of clusters to iteratively test when building the
consensus matrix}
}
\value{
a truncated ensemble consensus matrix
}
\description{
Produce a truncated ensemble consensus matrix.
}
