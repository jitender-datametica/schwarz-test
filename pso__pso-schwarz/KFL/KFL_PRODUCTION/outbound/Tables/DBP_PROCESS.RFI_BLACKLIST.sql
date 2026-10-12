CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.rfi_blacklist (
mandant_id BIGNUMERIC(38,0) NOT NULL,
attr STRING(100) COLLATE 'und:ci' NOT NULL,
wert STRING(100) COLLATE 'und:ci' NOT NULL,
operator STRING(20) COLLATE 'und:ci' NOT NULL,
blacklist_bez STRING(200) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);