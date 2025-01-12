CREATE TABLE IF NOT EXISTS local.silver.condition_rollup ( 
    encounterId STRING, 
    patientID STRING, 
    riskScore INT, 
    highRiskCondition INT, 
    moderateRiskCondition INT, 
    lowRiskCondition INT 
) USING iceberg;