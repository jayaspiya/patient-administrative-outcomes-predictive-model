CREATE TABLE IF NOT EXISTS local.gold.encounter (
    encounterId STRING,
    patientId STRING,
    gender STRING,
    encounterTs TIMESTAMP,
    ageGroup STRING,
    maritalStatus STRING,
    stayLength INT,
    encounterStatus STRING,
    encounterClass STRING,
    admitSource STRING,
    encounterType STRING,
    priority STRING,
    riskScore INT,
    highRiskCondition INT,
    moderateRiskCondition INT,
    lowRiskCondition INT,
    readmissionStatus STRING
) USING iceberg;