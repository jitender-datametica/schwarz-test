CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.org_einheit_bereich_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
hr_objekt_bereich_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
hr_objekt_bereich_bez STRING(100) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);