SELECT 
    id AS conditionId, 
    replace(subject.reference, "Patient/", "") AS patientId, 
    replace(encounter.reference, "Encounter/", "") AS encounterId, 
    category[0].coding[0].code categoryCode, 
    code.coding[0].code AS conditionCode, 
    code.coding[0].display AS conditionDisplay, 
    code.coding[0].system AS conditionSystem, 
    sourceFile 
FROM condition_df;