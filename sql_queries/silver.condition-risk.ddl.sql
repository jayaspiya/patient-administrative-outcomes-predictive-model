CREATE TABLE IF NOT EXISTS local.silver.condition_risk ( 
    conditionId STRING, 
    encounterId STRING, 
    patientId STRING, 
    conditionCode STRING, 
    charlsonCategory STRING, 
    riskWeight INT, 
    riskLevel STRING 
) USING iceberg; 