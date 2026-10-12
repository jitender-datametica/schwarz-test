CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sap_steuersatz_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
steuer_typ_id STRING(4) COLLATE 'und:ci' NOT NULL,
sap_steuer_id STRING(1) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
sap_steuer_bez STRING(20) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);