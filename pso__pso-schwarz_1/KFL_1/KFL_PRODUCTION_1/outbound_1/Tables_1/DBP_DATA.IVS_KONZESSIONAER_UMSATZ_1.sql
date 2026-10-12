CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_konzessionaer_umsatz_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
konzessionaer_id STRING(20) COLLATE 'und:ci' NOT NULL,
immo_objekt_id STRING(20) COLLATE 'und:ci' NOT NULL,
mietvertrag_id STRING(20) COLLATE 'und:ci' NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
betrag_umsatz NUMERIC(18,4) DEFAULT 0 NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
system_id BIGNUMERIC(38,0),
buchungskreis_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);