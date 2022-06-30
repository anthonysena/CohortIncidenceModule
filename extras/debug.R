connectionDetails <- Eunomia::getEunomiaConnectionDetails()
Eunomia::createCohorts(connectionDetails)

workFolder <- tempfile("work")
dir.create(workFolder)
resultsfolder <- tempfile("results")
dir.create(resultsfolder)
jobContext <- readRDS("tests/testJobContext.rds")
jobContext$moduleExecutionSettings$workSubFolder <- workFolder
jobContext$moduleExecutionSettings$resultsSubFolder  <- resultsfolder
jobContext$moduleExecutionSettings$connectionDetails <- connectionDetails

buildOptions <- CohortIncidence::buildOptions(cohortTable = paste0(jobContext$moduleExecutionSettings$workDatabaseSchema, '.', jobContext$moduleExecutionSettings$cohortTableNames$cohortTable),
                                              cdmDatabaseSchema = jobContext$moduleExecutionSettings$cdmDatabaseSchema,
                                              sourceName = as.character(jobContext$moduleExecutionSettings$databaseId))

irDesign <- as.character(CohortIncidence::IncidenceDesign$new(jobContext$settings$irDesign)$asJSON());


analysisSql <- CohortIncidence::buildQuery(incidenceDesign =  irDesign,
                                           buildOptions = buildOptions);

analysisSql <- SqlRender::translate(analysisSql, targetDialect = "sqlite");
