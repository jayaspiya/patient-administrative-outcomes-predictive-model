SELECT
    id AS patientId,
    gender AS gender,
    to_date(birthDate) birthDate,
    CASE maritalStatus.coding[0].code
        WHEN "M" THEN "Married"
        WHEN "D" THEN "Divorced"
        WHEN "W" THEN "Widowed"
        WHEN "S" THEN "Never Married"
        ELSE "Unknown"
    END maritalStatus,
    sourceFile
FROM patient_df;