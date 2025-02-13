SELECT 
    encounterId, 
    patientID, 
    SUM(riskWeight) riskScore, 
    SUM(CASE WHEN riskLevel = 'High' THEN 1 ELSE 0 END) AS highRiskCondition, 
    SUM(CASE WHEN riskLevel = 'Moderate' THEN 1 ELSE 0 END) AS moderateRiskCondition, 
    SUM(CASE WHEN riskLevel = 'Low' THEN 1 ELSE 0 END) AS lowRiskCondition 
FROM local.silver.condition_risk 
GROUP BY encounterId, patientID;