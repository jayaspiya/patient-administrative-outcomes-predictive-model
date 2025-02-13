CREATE TABLE IF NOT EXISTS local.silver.encounter (
    encounterId STRING,
    patientId STRING,
    ref_encounterId STRING,
    periodStart TIMESTAMP,
    periodEnd TIMESTAMP,
    duration INT,
    status STRING,
    encounterClass STRING,
    displayType STRING,
    admitSource STRING,
    dischargeDisposition STRING,
    priority STRING,
    nextEncounterId STRING,
    readmissionStatus STRING,
    sourceFile STRING
) USING iceberg;