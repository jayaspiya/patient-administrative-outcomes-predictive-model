SELECT 
    id AS encounterId, 
    replace(subject.reference, "Patient/", "") AS patientId, 
    replace(partOf.reference, "Encounter/", "") AS ref_encounterId, 
    CAST(period.start AS timestamp) periodStart, 
    CAST(period.end AS timestamp) periodEnd, 
    date_diff(day, periodStart, periodEnd) duration, 
    status AS status, 
    CASE class.code 
        WHEN "AMB" THEN "Ambulatory" 
        WHEN "OBSENC" THEN "Observation Encounter" 
        WHEN "ACUTE" THEN "Inpatient Acute" 
        WHEN "EMER" THEN "Emergency" 
        WHEN "SS" THEN "Short Stay" 
    END AS encounterClass, 
    type[0].coding[0].display AS displayType, 
    hospitalization.admitSource.coding[0].code admitSource, 
    hospitalization.dischargeDisposition.coding[0].code dischargeDisposition, 
    nvl(priority.coding[0].display, 'emergency') AS priority, 
    -- Next EncounterID & Readmission Status 
    LEAD(id) OVER (PARTITION BY subject.reference ORDER BY period.start) AS nextEncounterId, 
    CASE 
        WHEN DATEDIFF(day, period.end, LEAD(period.start) OVER (PARTITION BY subject.reference ORDER BY period.start)) <= 30 THEN 'Readmission' 
        ELSE 'No Readmission' 
    END AS readmissionStatus, 
    sourceFile 
FROM encounter_df;