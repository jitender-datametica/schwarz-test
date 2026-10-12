CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mitarbeiter_gruppe_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
mitarbeiter_gruppe_id STRING(1) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
mitarbeiter_gruppe_bez STRING(20) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);