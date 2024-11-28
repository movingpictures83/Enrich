library(FELLA)
library(org.Mm.eg.db)
library(KEGGREST)

library(igraph)
library(magrittr)

set.seed(1)

dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")
source("RIO.R")

input <- function(inputfile) {
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
    pfix = prefix()
  if (length(pfix) != 0) {
     pfix <<- paste(pfix, "/", sep="")
  }

  fella.data <<- loadKEGGdata(
    databaseDir = paste(pfix, parameters["database", 2], sep="/"),#tmpdir,
    internalDir = FALSE,
    loadMatrix = "none"
)


}

run <- function() {}

output <- function(outputfile) {

cpd.nafld <- readSequential(paste(pfix, parameters["compounds", 2], sep="/"))

analysis.nafld <- enrich(
    compounds = cpd.nafld,
    data = fella.data,
    method = "diffusion",
    approx = "normality")

saveRDS(analysis.nafld, outputfile)

}
