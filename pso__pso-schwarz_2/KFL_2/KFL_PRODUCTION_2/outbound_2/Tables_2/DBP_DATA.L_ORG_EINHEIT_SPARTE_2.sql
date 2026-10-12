CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_org_einheit_sparte_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
hr_objekt_ebene11_id INTEGER NOT NULL,
sparte_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);