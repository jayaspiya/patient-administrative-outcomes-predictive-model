with encounter_count as (
    SELECT 
        e1.encounterId, e1.patientId, e1.encounterTs,
        COUNT(e2.encounterId) AS num_emer_encounter_6_month
    FROM local.gold.encounter e1
    JOIN local.gold.encounter e2 
        ON e1.patientId = e2.patientId 
        AND e2.encounterTs BETWEEN DATEADD(MONTH, -6, e1.encounterTs) AND e1.encounterTs
        AND e2.encounterClass='Emergency'
    GROUP BY e1.encounterId, e1.patientId, e1.encounterTs
),
encounter_cal as (
    SELECT
        e.*,
        ec.num_emer_encounter_6_month,
        case 
            when e.stayLength <= 1 then 1
            when e.stayLength = 2 then 1
            when e.stayLength = 3 then 2
            when e.stayLength <=6 then 3
            when e.stayLength <=13 then 4
            else 5
        end losScore,
        case e.riskScore
            when 0 then 0
            when 1 then 1
            when 2 then 2
            else 3
        end CciScore,
        if(e.encounterClass='Emergency', 3, 0) acutenessScore,
        case ec.num_emer_encounter_6_month
            when 0 then 0 
            when 1 then 1 
            when 2 then 2 
            when 3 then 3 
            else 4
        end emerVisitScore
    FROM local.gold.encounter e
    left join encounter_count ec
    on e.encounterId = ec.encounterId
)
select
    encounterId,
    patientId,
    gender,
    encounterTs,
    ageGroup,
    maritalStatus,
    encounterStatus,
    admitSource,
    encounterType,
    priority,
    highRiskCondition,
    moderateRiskCondition,
    lowRiskCondition,
    stayLength,
    losScore,
    riskScore,
    CciScore,
    encounterClass,
    acutenessScore,
    num_emer_encounter_6_month,
    emerVisitScore,
    readmissionStatus,
    (losScore+CciScore+acutenessScore+emerVisitScore) calcScore
from encounter_cal