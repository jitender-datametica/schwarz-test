CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_org_einheit_bereich_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
hr_objekt_bereich_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
hr_objekt_bereich_level2_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);