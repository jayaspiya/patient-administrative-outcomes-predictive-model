select current_database();
select version();

CREATE SCHEMA IF NOT EXISTS bronze;

CREATE TABLE IF NOT EXISTS bronze.patient_data (
    value jsonb,
    source text,
    root_id text
);

CREATE TABLE IF NOT EXISTS bronze.encounter_data (
    value jsonb,
    source text,
    root_id text
);

CREATE TABLE IF NOT EXISTS bronze.condition_data (
    value jsonb,
    source text,
    root_id text
);

select source, count(*) from bronze.encounter_data group by 1 union
select source, count(*) from bronze.condition_data group by 1 union
select source, count(*) from bronze.patient_data group by 1
order by 1;

select root_id, json_extract_path(value:: json, 'id') id from bronze.condition_data limit 4;

select * from information_schema.columns
where table_catalog  = 'fhir_project'
and table_schema = 'bronze'
and table_name = 'patient_data';


CREATE SCHEMA IF NOT EXISTS silver;

select * from silver.patient;










