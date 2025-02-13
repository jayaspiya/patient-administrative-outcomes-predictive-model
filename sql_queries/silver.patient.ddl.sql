CREATE TABLE IF NOT EXISTS local.silver.patient (
    patientId STRING,
    gender STRING,
    birthDate DATE,
    maritalStatus STRING,
    sourceFile STRING
) USING iceberg;