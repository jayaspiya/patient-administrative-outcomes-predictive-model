with charlsonCategoryCondition as ( 
select 
    conditionID, 
    encounterID, patientID, 
    conditionCode, 
    CASE 
        WHEN substring(conditionCode, 0, 4) IN ("1252") 
            OR substring(conditionCode, 0, 4) like 'I21%' 
            OR substring(conditionCode, 0, 4) like 'I22%' 
        THEN 'Myocardial infarction' 
        WHEN substring(conditionCode, 0, 4) IN ("I099","I110","I130","I132","I255","I420","I425","I426","I427","I428","I429","P290") 
            OR substring(conditionCode, 0, 4) like 'I43%' 
            OR substring(conditionCode, 0, 4) like 'I50%' 
        THEN 'Congestive heart failure' 
        WHEN substring(conditionCode, 0, 4) IN ("I731","I738","I739","I771","I790","I792","K551","K558","K559","Z958","Z959") 
            OR substring(conditionCode, 0, 4) like 'I70%' 
            OR substring(conditionCode, 0, 4) like 'I71%' 
        THEN 'Peripheral vascular disease' 
        WHEN substring(conditionCode, 0, 4) IN ("F051","G311") 
            OR substring(conditionCode, 0, 4) like "F00%" 
            OR substring(conditionCode, 0, 4) like "F01%" 
            OR substring(conditionCode, 0, 4) like "F02%" 
            OR substring(conditionCode, 0, 4) like "F03%" 
            OR substring(conditionCode, 0, 4) like "G30%" 
        THEN 'Cerebrovascular disease' 
        WHEN substring(conditionCode, 0, 4) IN ("I278","I279","J684","J701","J703") 
            OR substring(conditionCode, 0, 4) like "J40%" 
            OR substring(conditionCode, 0, 4) like "J41%" 
            OR substring(conditionCode, 0, 4) like "J42%" 
            OR substring(conditionCode, 0, 4) like "J43%" 
            OR substring(conditionCode, 0, 4) like "J44%" 
            OR substring(conditionCode, 0, 4) like "J45%" 
            OR substring(conditionCode, 0, 4) like "J46%" 
            OR substring(conditionCode, 0, 4) like "J47%" 
            OR substring(conditionCode, 0, 4) like "J60%" 
            OR substring(conditionCode, 0, 4) like "J61%" 
            OR substring(conditionCode, 0, 4) like "J62%" 
            OR substring(conditionCode, 0, 4) like "J63%" 
            OR substring(conditionCode, 0, 4) like "J64%" 
            OR substring(conditionCode, 0, 4) like "J65%" 
            OR substring(conditionCode, 0, 4) like "J66%" 
            OR substring(conditionCode, 0, 4) like "J67%" 
        THEN 'Chronic pulmonary disease' 
        WHEN substring(conditionCode, 0, 4) IN ("M315", "M351","M353","M360") 
            OR substring(conditionCode, 0, 4) like "M05%" 
            OR substring(conditionCode, 0, 4) like "M06%" 
            OR substring(conditionCode, 0, 4) like "M32%" 
            OR substring(conditionCode, 0, 4) like "M32%" 
            OR substring(conditionCode, 0, 4) like "M34%" 
        THEN "Rheumatic disease" 
        WHEN substring(conditionCode, 0, 4) like "K25%" 
            OR substring(conditionCode, 0, 4) like "K26%" 
            OR substring(conditionCode, 0, 4) like "K27%" 
            OR substring(conditionCode, 0, 4) like "K28%" 
        THEN "Peptic ulcer disease" 
        WHEN substring(conditionCode, 0, 4) IN ("K700","K701","K702","K703","K709","K713","K714","K715","K717","K760","K762","K763","K764","K768","K769","Z944") 
            OR substring(conditionCode, 0, 4) like 'B18%' 
            OR substring(conditionCode, 0, 4) like 'K73%' 
            OR substring(conditionCode, 0, 4) like 'K74%' 
        THEN 'Mild liver disease' 
        WHEN substring(conditionCode, 0, 4) IN ("E100","E101","E106","E108","E109","E110","E111","E116","E118","E119","E120","E121","E126","E128","E129","E130","E131","E136","E138","E139","E140","E141","E146","E148","E149") 
        THEN 'Diabetes without chronic complication' 
        WHEN substring(conditionCode, 0, 4) IN ("E102","E103","E104","E105","E107","E112","E113","E114","E115","E117","E122","E123","E124","E125","E127","E132","E133","E134","E135","E137","E142","E143","E144","E145","E147") 
        THEN 'Diabetes with chronic complication' 
        WHEN substring(conditionCode, 0, 4) IN ("G041","G114","G801","G802","G830","G831","G832","G833","G834","G839") 
            OR substring(conditionCode, 0, 4) like 'G81%' 
            OR substring(conditionCode, 0, 4) like 'G82%' 
        THEN 'Hemiplegia or paraplegia' 
        WHEN substring(conditionCode, 0, 4) IN ("I120","I131","N032","N033","N034","N035","N036","N037","N052","N053","N054","N055","N056","N057","N250","Z490","Z491","Z492","Z940","Z992") 
            OR substring(conditionCode, 0, 4) like 'N18%' 
            OR substring(conditionCode, 0, 4) like 'N19%' 
        THEN 'Renal disease' 
        WHEN substring(conditionCode, 0, 4) like "C0%" 
            OR substring(conditionCode, 0, 4) like "C1%" 
            OR substring(conditionCode, 0, 4) like "C20%" 
            OR substring(conditionCode, 0, 4) like "C21%" 
            OR substring(conditionCode, 0, 4) like "C22%" 
            OR substring(conditionCode, 0, 4) like "C23%" 
            OR substring(conditionCode, 0, 4) like "C24%" 
            OR substring(conditionCode, 0, 4) like "C25%" 
            OR substring(conditionCode, 0, 4) like "C26%" 
            OR substring(conditionCode, 0, 4) like "C30%" 
            OR substring(conditionCode, 0, 4) like "C31%" 
            OR substring(conditionCode, 0, 4) like "C32%" 
            OR substring(conditionCode, 0, 4) like "C33%" 
            OR substring(conditionCode, 0, 4) like "C34%" 
            OR substring(conditionCode, 0, 4) like "C37%" 
            OR substring(conditionCode, 0, 4) like "C38%" 
            OR substring(conditionCode, 0, 4) like "C39%" 
            OR substring(conditionCode, 0, 4) like "C40%" 
            OR substring(conditionCode, 0, 4) like "C41%" 
            OR substring(conditionCode, 0, 4) like "C43%" 
            OR substring(conditionCode, 0, 4) like "C45%" 
            OR substring(conditionCode, 0, 4) like "C46%" 
            OR substring(conditionCode, 0, 4) like "C47%" 
            OR substring(conditionCode, 0, 4) like "C48%" 
            OR substring(conditionCode, 0, 4) like "C49%" 
            OR substring(conditionCode, 0, 4) like "C50%" 
            OR substring(conditionCode, 0, 4) like "C51%" 
            OR substring(conditionCode, 0, 4) like "C52%" 
            OR substring(conditionCode, 0, 4) like "C53%" 
            OR substring(conditionCode, 0, 4) like "C54%" 
            OR substring(conditionCode, 0, 4) like "C55%" 
            OR substring(conditionCode, 0, 4) like "C56%" 
            OR substring(conditionCode, 0, 4) like "C57%" 
            OR substring(conditionCode, 0, 4) like "C58%" 
            OR substring(conditionCode, 0, 4) like "C60%" 
            OR substring(conditionCode, 0, 4) like "C61%" 
            OR substring(conditionCode, 0, 4) like "C62%" 
            OR substring(conditionCode, 0, 4) like "C63%" 
            OR substring(conditionCode, 0, 4) like "C64%" 
            OR substring(conditionCode, 0, 4) like "C65%" 
            OR substring(conditionCode, 0, 4) like "C66%" 
            OR substring(conditionCode, 0, 4) like "C67%" 
            OR substring(conditionCode, 0, 4) like "C68%" 
            OR substring(conditionCode, 0, 4) like "C69%" 
            OR substring(conditionCode, 0, 4) like "C70%" 
            OR substring(conditionCode, 0, 4) like "C71%" 
            OR substring(conditionCode, 0, 4) like "C72%" 
            OR substring(conditionCode, 0, 4) like "C73%" 
            OR substring(conditionCode, 0, 4) like "C74%" 
            OR substring(conditionCode, 0, 4) like "C75%" 
            OR substring(conditionCode, 0, 4) like "C76%" 
            OR substring(conditionCode, 0, 4) like "C81%" 
            OR substring(conditionCode, 0, 4) like "C82%" 
            OR substring(conditionCode, 0, 4) like "C83%" 
            OR substring(conditionCode, 0, 4) like "C84%" 
            OR substring(conditionCode, 0, 4) like "C85%" 
            OR substring(conditionCode, 0, 4) like "C88%" 
            OR substring(conditionCode, 0, 4) like "C90%" 
            OR substring(conditionCode, 0, 4) like "C91%" 
            OR substring(conditionCode, 0, 4) like "C92%" 
            OR substring(conditionCode, 0, 4) like "C93%" 
            OR substring(conditionCode, 0, 4) like "C94%" 
            OR substring(conditionCode, 0, 4) like "C95%" 
            OR substring(conditionCode, 0, 4) like "C96%" 
            OR substring(conditionCode, 0, 4) like "C97%" 
        THEN 'Malignancy' 
        WHEN substring(conditionCode, 0, 4) IN ("I850","I859","I864","I982","K704","K711","K721","K729","K765","K766","K767") 
        THEN 'Moderate or severe liver disease' 
        WHEN substring(conditionCode, 0, 4) like 'C77%' 
            OR substring(conditionCode, 0, 4) like 'C78%' 
            OR substring(conditionCode, 0, 4) like 'C79%' 
            OR substring(conditionCode, 0, 4) like 'C80%' 
        THEN "Metastatic solid tumour" 
        WHEN substring(conditionCode, 0, 4) like 'B20%' 
            OR substring(conditionCode, 0, 4) like 'B21%' 
            OR substring(conditionCode, 0, 4) like 'B22%' 
            OR substring(conditionCode, 0, 4) like 'B24%' 
        THEN "AIDS/HIV" 
    END AS charlsonCategory 
from local.silver.condition_standard 
) 
select 
    conditionID, 
    encounterID, patientID, 
    conditionCode, charlsonCategory, 
    CASE 
        WHEN charlsonCategory IN ("Peripheral vascular disease", "Cerebrovascular disease", "Chronic pulmonary disease", "Congestive heart failure", "Rheumatic disease", "Diabetes without chronic complication", "Mild liver disease", "Peptic ulcer disease", "Renal disease") 
        THEN 1 
        WHEN charlsonCategory IN ("Myocardial infarction", "Hemiplegia or paraplegia", "Malignancy", "Diabetes with chronic complication") 
        THEN 2 
        WHEN charlsonCategory IN ("Moderate or severe liver disease") 
        THEN 3 
        WHEN charlsonCategory IN ("Metastatic solid tumour", "AIDS/HIV") 
        THEN 6 
        ELSE 0 
    END riskWeight, 
    CASE 
        WHEN charlsonCategory IN ("Peripheral vascular disease", "Cerebrovascular disease", "Chronic pulmonary disease", "Congestive heart failure", "Rheumatic disease", "Diabetes without chronic complication", "Mild liver disease", "Peptic ulcer disease", "Renal disease") 
        THEN "Low" 
        WHEN charlsonCategory IN ("Myocardial infarction", "Hemiplegia or paraplegia", "Malignancy", "Diabetes with chronic complication") 
        THEN "Moderate" 
        WHEN charlsonCategory IN ("Moderate or severe liver disease", "Metastatic solid tumour", "AIDS/HIV") 
        THEN "High" 
        ELSE charlsonCategory 
    END riskLevel 
from charlsonCategoryCondition;