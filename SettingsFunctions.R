createCohortIncidenceModuleSpecifications <- function(irDesign) {
  checkmate::assert_file_exists("MetaData.json")
  moduleInfo <- ParallelLogger::loadSettingsFromJson("MetaData.json")
  
  analysis <- list()
  for (name in names(formals(createCohortIncidenceModuleSpecifications))) {
    analysis[[name]] <- get(name)
  }
  
  specifications <- list(module = moduleInfo$Name,
                         version = moduleInfo$Version,
                         remoteRepo = "github.com",
                         remoteUsername = "ohdsi",
                         settings = analysis)
  
  class(specifications) <- c("CohortIncidenceModuleSpecifications", "ModuleSpecifications")
  return(specifications)
}