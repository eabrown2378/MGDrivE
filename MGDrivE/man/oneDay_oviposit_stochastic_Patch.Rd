% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Patch-Simulation.R
\name{oneDay_oviposit_stochastic_Patch}
\alias{oneDay_oviposit_stochastic_Patch}
\title{Stochastic Oviposition}
\usage{
oneDay_oviposit_stochastic_Patch()
}
\description{
Calculate the number of eggs oviposited by female mosquitoes following:
\deqn{\overline{O(T_x)} = \sum_{j=1}^{n} \Bigg( \bigg( (\beta*\overline{s} * \overline{ \overline{Af_{[t]}}}) * \overline{\overline{\overline{Ih}}} \bigg) * \Lambda  \Bigg)^{\top}_{ij}}
The deterministic result for number of pups is used as the rate parameter of a Poisson-distributed
number of actual pups conceived.
}
