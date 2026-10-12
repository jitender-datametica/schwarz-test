CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.l_zahlungsmittel_1 (
zahlungsmittel_id STRING(4) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);