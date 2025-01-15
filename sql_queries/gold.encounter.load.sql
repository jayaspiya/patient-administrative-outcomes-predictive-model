SELECT 
    encounter.encounterId, 
    encounter.patientId, 
    patient.gender, 
    encounter.periodStart encounterTs,
    CASE 
        WHEN date_diff(year, patient.birthDate, encounter.periodStart) BETWEEN 18 AND 29 THEN 'young adults' 
        WHEN date_diff(year, patient.birthDate, encounter.periodStart) BETWEEN 30 AND 39 THEN 'young adulthood' 
        WHEN date_diff(year, patient.birthDate, encounter.periodStart) BETWEEN 40 AND 49 THEN 'early-middle age' 
        WHEN date_diff(year, patient.birthDate, encounter.periodStart) BETWEEN 50 AND 59 THEN 'late-middle age' 
        WHEN date_diff(year, patient.birthDate, encounter.periodStart) BETWEEN 60 AND 69 THEN 'mid-old age' 
        WHEN date_diff(year, patient.birthDate, encounter.periodStart) BETWEEN 70 AND 79 THEN 'senior-old age' 
        WHEN date_diff(year, patient.birthDate, encounter.periodStart) BETWEEN 80 AND 89 THEN 'very senior-old' 
        WHEN date_diff(year, patient.birthDate, encounter.periodStart) BETWEEN 90 AND 115 THEN 'centenarians' 
        ELSE 'other age groups' 
    END AS ageGroup, 
    patient.maritalStatus, 
    encounter.duration stayLength, 
    encounter.status encounterStatus, 
    encounter.encounterClass, 
    encounter.admitSource, 
    encounter.dischargeDisposition, 
    encounter.displayType encounterType, 
    encounter.priority, 
    IFNULL(condition.riskScore, 0) riskScore, 
    IFNULL(condition.highRiskCondition, 0) highRiskCondition, 
    IFNULL(condition.moderateRiskCondition, 0) moderateRiskCondition, 
    IFNULL(condition.lowRiskCondition, 0) lowRiskCondition, 
    encounter.readmissionStatus 
FROM local.silver.encounter 
LEFT JOIN local.silver.patient 
    ON encounter.patientId = patient.patientID 
LEFT JOIN local.silver.condition_rollup condition 
    ON encounter.encounterId = condition.encounterId 
    AND encounter.patientID = condition.patientID