CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_artikelrolle (
mandant_id BIGNUMERIC(38,0) NOT NULL,
artikelrolle_id STRING(2) COLLATE 'und:ci' NOT NULL,
artikelrolle_bez STRING(30) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);