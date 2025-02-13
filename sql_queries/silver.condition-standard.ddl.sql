CREATE TABLE IF NOT EXISTS local.silver.condition_standard ( 
    conditionId STRING, 
    encounterId STRING, 
    patientId STRING, 
    conditionCode STRING 
) USING iceberg; 