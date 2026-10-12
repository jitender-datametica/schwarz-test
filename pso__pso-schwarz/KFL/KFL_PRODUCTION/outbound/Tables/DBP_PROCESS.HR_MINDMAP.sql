CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.hr_mindmap (
mandant_id BIGNUMERIC(38,0) NOT NULL,
gen_key STRING(25) NOT NULL,
hr_objekt_id INTEGER NOT NULL,
hr_objekt_id_zu STRING(10) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);