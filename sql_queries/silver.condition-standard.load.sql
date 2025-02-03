SELECT 
    condition.conditionId, 
    condition.encounterId, 
    condition.patientId, 
    GemMapping.icd10cm conditionCode 
FROM local.silver.condition condition 
JOIN GemMapping 
ON condition.conditionCode = GemMapping.icd9cm 
WHERE condition.conditionSystem LIKE '%icd9'

UNION

SELECT 
    conditionId, encounterId, patientId, conditionCode 
FROM local.silver.condition condition 
WHERE condition.conditionSystem LIKE '%icd10';