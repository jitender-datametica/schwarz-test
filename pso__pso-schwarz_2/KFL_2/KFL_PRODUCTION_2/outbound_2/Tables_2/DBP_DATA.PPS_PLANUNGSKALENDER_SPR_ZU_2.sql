CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.pps_planungskalender_spr_zu_2 (
pps_plan_kalender_id STRING(3) COLLATE 'und:ci' NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
pps_plan_kalender_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);