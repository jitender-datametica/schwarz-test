CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.zahlungsmittel_spr_zu (
zahlungsmittel_id STRING(4) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
zahlungsmittel_bez STRING(50) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);