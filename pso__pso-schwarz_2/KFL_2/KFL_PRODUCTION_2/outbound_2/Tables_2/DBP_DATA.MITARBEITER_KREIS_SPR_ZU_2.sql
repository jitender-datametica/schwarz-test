CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mitarbeiter_kreis_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
mitarbeiter_kreis_id STRING(2) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
mitarbeiterkreis_bez STRING(20) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);