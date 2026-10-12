CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ims_psp_ele_anwenderstat_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
psp_id BIGNUMERIC(38,0) NOT NULL,
anwenderstatus_id STRING(5) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);