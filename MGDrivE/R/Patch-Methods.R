###############################################################################
#        ____        __       __
#       / __ \____ _/ /______/ /_
#      / /_/ / __ `/ __/ ___/ __ \
#     / ____/ /_/ / /_/ /__/ / / /
#    /_/    \__,_/\__/\___/_/ /_/#
#
#   Patch Class Implementation
#   Original Code by: Marshall Lab
#   jared_bennett@berkeley.edu
#   December 2019
#   MODIFIED BY: ETHAN A. BROWN (JUL 9 2020)
#   ebrown23@nd.edu
###############################################################################

#' Set Initial Population
#'
#' This hidden function distributes the population at time 0 in the steady-state
#' conformation. This involves splitting adults into male and female.
#'
#' @param k Carrying capacity constant
#' @param adultRatioF Genotype specific ratio for adult females
#' @param adultRatioM Genotype specific ratio for adult males
#' @param muAd daily survival of adult stage
#' @param timeAd approximate length of adult life stage
#'

set_initialPopulation_Patch <- function(k = k, adultRatioF = adultRatioF, adultRatioM = adultRatioM,
                                        muAd = muAd, timeAd = timeAd){


  ##########
  # set male population breakdown
  ##########
  private$popMale[names(adultRatioM)] = adultRatioM * k/2

  ##########
  # set mated female population breakdown
  ##########
  # this isn't exactly correct, it mates all males to all females, ignoring
  # the genotype-specific male mating abilities
  private$popUnmated[names(adultRatioF)] = adultRatioF * k/2
  private$popFemale = private$popUnmated %o% normalise(private$popMale)


}

#' Set Initial Population Deterministic
#'
#' Calls \code{\link{set_initialPopulation_Patch}} to initialize a steady-state
#' population distribution.
#'
#' @param k Carrying capacity constant
#' @param adultRatioF Genotype specific ratio for adult females
#' @param adultRatioM Genotype specific ratio for adult males
#' @param muAd daily survival of adult stage
#' @param timeAd approximate length of adult life stage
#'
set_population_deterministic_Patch <- function(k = k, adultRatioF = adultRatioF, adultRatioM = adultRatioM,
                                               muAd = muAd, timeAd = timeAd){

  self$initialPopulation(k = k, adultRatioF = adultRatioF, adultRatioM = adultRatioM,
                         muAd = muAd, timeAd = timeAd)

}

#' Set Initial Population Stochastic
#'
#' Calls \code{\link{set_initialPopulation_Patch}} to initialize a steady-state
#' population distribution. Populations are then rounded to integer values.
#'
#' @param k Carrying capacity constant
#' @param adultRatioF Genotype specific ratio for adult females
#' @param adultRatioM Genotype specific ratio for adult males
#' @param muAd daily survival of adult stage
#' @param timeAd approximate length of adult life stage
#'
set_population_stochastic_Patch <- function(k = k, adultRatioF = adultRatioF, adultRatioM = adultRatioM,
                                            muAd = muAd, timeAd = timeAd){

  # set initial population
  self$initialPopulation(k = k, adultRatioF = adultRatioF, adultRatioM = adultRatioM,
                         muAd = muAd, timeAd = timeAd)

  ##########
  # make everything an integer
  ##########
  private$popJuvenile[] <- round(private$popJuvenile)
  private$popUnmated[] <- round(private$popUnmated)
  private$popMale[] <- round(private$popMale)
  private$popFemale[] <- round(private$popFemale)

}

#' Reset Patch to Initial Conditions
#'
#' Resets a patch to its initial configuration so that a new one does not have
#' to be created and allocated in the network (for Monte Carlo simulation).
#'
#' @param verbose Chatty? Default is TRUE
#'
reset_Patch <- function(verbose = TRUE){

  if(verbose){cat("reset patch ",private$patchID,"\n",sep="")}

  # reset population
  private$popJuvenile[] = private$popJuvenilet0
  private$popMale[] = private$popMalet0
  private$popUnmated[] = private$popUnmatedt0
  private$popFemale[] = private$popFemalet0
  private$popFemale[] = private$popFemalet0


  # Reset Mosquito Releases
  private$gestReleases = private$NetworkPointer$get_patchReleases(private$patchID,"Gest")
  private$maleReleases = private$NetworkPointer$get_patchReleases(private$patchID,"M")
  private$femaleReleases = private$NetworkPointer$get_patchReleases(private$patchID,"F")
  private$matedFemaleReleases = private$NetworkPointer$get_patchReleases(private$patchID,"mF")

}

#' Initialize Output from Focal Patch
#'
#' Writes output to the text connections specified in the enclosing \code{\link{Network}}.
#'
oneDay_initOutput_Patch <- function(){

  ##########
  # headers
  ##########
  if(private$patchID == 1){
    # males
    writeLines(text = paste0(c("Time","Patch",private$NetworkPointer$get_genotypesID()), collapse = ","),
           con = private$NetworkPointer$get_conADM(), sep = "\n")
    # females
    femaleCrosses = c(t(outer(private$NetworkPointer$get_genotypesID(),private$NetworkPointer$get_genotypesID(),FUN = paste0)))
    writeLines(text = paste0(c("Time","Patch",femaleCrosses), collapse = ","),
               con = private$NetworkPointer$get_conADF(),sep = "\n")
  }

  ##########
  # males
  ##########
  writeLines(text = paste0(c(1,private$patchID,private$popMale),collapse = ","),
             con = private$NetworkPointer$get_conADM(), sep = "\n")

  ##########
  # females
  ##########
  writeLines(text = paste0(c(1,private$patchID,c(t(private$popFemale))),collapse = ","),
             con = private$NetworkPointer$get_conADF(), sep = "\n")

}

#' Write Output from Focal Patch
#'
#' Writes output to the text connections specified in the enclosing \code{\link{Network}}.
#'
oneDay_writeOutput_Patch <- function(){

  tNow = private$NetworkPointer$get_tNow()

  # write males
  ADMout = paste0(c(tNow,private$patchID,private$popMale),collapse = ",")
  writeLines(text = ADMout,con = private$NetworkPointer$get_conADM(),sep = "\n")

  # write females
  ADFout = paste0(c(tNow,private$patchID,c(t(private$popFemale))),collapse = ",")
  writeLines(text = ADFout,con = private$NetworkPointer$get_conADF(),sep = "\n")

}
