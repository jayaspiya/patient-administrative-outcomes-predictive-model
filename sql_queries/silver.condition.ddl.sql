CREATE TABLE IF NOT EXISTS local.silver.condition ( 
    conditionId STRING, 
    patientId STRING, 
    encounterId STRING, 
    categoryCode STRING, 
    conditionCode STRING, 
    conditionDisplay STRING, 
    conditionSystem STRING, 
    sourceFile STRING 
) USING iceberg; 