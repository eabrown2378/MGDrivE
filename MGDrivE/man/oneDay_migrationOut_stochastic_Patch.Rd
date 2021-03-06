% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Patch-Migration.R
\name{oneDay_migrationOut_stochastic_Patch}
\alias{oneDay_migrationOut_stochastic_Patch}
\title{Stochastic Outbound Migration}
\usage{
oneDay_migrationOut_stochastic_Patch()
}
\description{
Stochastic model of outbound migration from each patch for \code{\link{oneDay_Migration_Network}}.
\code{popFemale} from each patch is stored in the \code{fMig} array, and \code{popMale}
are stored in the \code{mMig} matrix. Migration is modeled as a Dirichlet-Multinomial
process parameterized by \code{moveVar} multiplied by the migration location
probabilities corresponding to this patch (\code{\link{get_migrationFemaleRow_Network}}
and \code{\link{get_migrationMaleRow_Network}}). A Dirichlet distributed random
variate is sampled from \code{rDirichlet} according to that parameter vector
and then movement is sampled from \code{\link[stats]{rmultinom}}. \cr
Batch migration begins as a \code{\link[stats]{rbinom}} sampled from \code{\link{get_batchProbs_Network}}.
If there is batch migration, the location of migration is sampled uniformly (see \code{\link[base]{sample}}),
parameterized by \code{\link{get_batchLocRow_Network}}. The amount of each sex
that migrations is sampled from \code{\link[stats]{rbinom}}, parameterized by
\code{\link{get_batchSex_Network}}.
}
