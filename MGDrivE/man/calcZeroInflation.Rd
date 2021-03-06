% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MGDrivE-Auxiliary.R
\name{calcZeroInflation}
\alias{calcZeroInflation}
\title{Calculates the zero-inflation part of a hurdle exponential kernel.}
\usage{
calcZeroInflation(stayThroughLifespanProbability, adultMortality)
}
\arguments{
\item{stayThroughLifespanProbability}{Probability of a mosquito to spend its
whole lifespan in the same node}

\item{adultMortality}{Adult mortality rate}
}
\description{
Given the probability of an adult mosquito to stay in the same patch throughout
its whole lifespan, and its mortality, it calculates the height of the pulse-density
part of the hurdle kernel.
}
\examples{
# setup distance matrix
# two-column matrix with latitude/longitude, in degrees
latLong = cbind(runif(n = 5, min = 0, max = 90),
                runif(n = 5, min = 0, max = 180))

# Vincenty Ellipsoid  distance formula
distMat = calcVinEll(latLongs = latLong)

# get hurdle height
# Lets assume 80\% stay probs and adult mortality of 0.1
hHeight <- calcZeroInflation(stayThroughLifespanProbability = 0.80,
                             adultMortality = 0.1)

# calculate hurdle exponential distribution over distances
kernMat = calcHurdleExpKernel(distMat = distMat, rate = 10, p0 = hHeight)

}
