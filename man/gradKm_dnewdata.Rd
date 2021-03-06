% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gradKm.R
\name{gradKm_dnewdata}
\alias{gradKm_dnewdata}
\title{Gradient of posterior mean and variance}
\usage{
gradKm_dnewdata(object, newdata, type, se.compute = TRUE,
  light.return = FALSE, bias.correct = FALSE)
}
\arguments{
\item{object}{a \link[DiceKriging]{km} object}

\item{newdata}{a vector, matrix or data frame containing the points where to perform predictions.}

\item{type}{a character corresponding to the type of kriging family (\code{"SK"} or \code{"UK"}).}

\item{se.compute}{an optional boolean indicating whether to compute the posterior variance or not. Default is TRUE.}

\item{light.return}{an optional boolean indicating whether to return additional variables. Default is FALSE.}

\item{bias.correct}{an optional boolean to correct bias in the UK variance. Default is FALSE.}
}
\value{
Returns a list containing \itemize{
\item{\code{mean:}}{ the gradient of the posterior mean at \code{newdata}.}
\item{\code{trend:}}{ the gradient of the trend at \code{newdata}.}
\item{\code{s2:}}{ the gradient of the posterior variance at \code{newdata}.}
}
}
\description{
Computes the gradient of the posterior mean and variance of the kriging model in \code{object} at the points \code{newdata}.
}
\author{
Dario Azzimonti
}
