% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Cube-RIDL.R
\name{cubeRIDL}
\alias{cubeRIDL}
\title{Inheritance Cube: RIDL (Release of Insects with Dominant Lethality)}
\usage{
cubeRIDL(
  eta = NULL,
  phi = NULL,
  omega = NULL,
  xiF = NULL,
  xiM = NULL,
  s = NULL
)
}
\arguments{
\item{eta}{Genotype-specific mating fitness}

\item{phi}{Genotype-specific sex ratio at emergence}

\item{omega}{Genotype-specific multiplicative modifier of adult mortality}

\item{xiF}{Genotype-specific female pupatory success}

\item{xiM}{Genotype-specific male pupatory success}

\item{s}{Genotype-specific fractional reduction(increase) in fertility}
}
\value{
Named list containing the inheritance cube, transition matrix, genotypes, wild-type allele,
and all genotype-specific parameters.
}
\description{
This function creates a RIDL system.
RIDL (Release of Insects with Dominant Lethality), is a form of SIT.
Created by Oxitec, this is based on a positive feedback loop using the
toxic tTAV gene, controlled under lab conditions by the TetO promoter.
This has 2 alleles at 1 locus
\itemize{
\item W: Wild-type allele
\item R: OX513 RIDL allele
}
}
