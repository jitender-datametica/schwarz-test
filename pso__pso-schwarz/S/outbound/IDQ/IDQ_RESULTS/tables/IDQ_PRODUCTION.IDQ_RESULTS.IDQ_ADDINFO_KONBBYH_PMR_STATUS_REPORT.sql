CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_konbbyh_pmr_status_report (
id BIGNUMERIC(38,0) NOT NULL,
bbynr STRING(12) NOT NULL,
aktnr STRING(10),
offer_id STRING(36),
status STRING(1),
datab DATE,
zzkschl STRING(4),
zzgv_nr STRING(2),
country_code STRING(4),
country_code_mapped BIGNUMERIC(38,0) NOT NULL,
source_system_id BIGNUMERIC(38,0) NOT NULL,
calculation_time DATETIME,
PRIMARY KEY (id) NOT ENFORCED
);