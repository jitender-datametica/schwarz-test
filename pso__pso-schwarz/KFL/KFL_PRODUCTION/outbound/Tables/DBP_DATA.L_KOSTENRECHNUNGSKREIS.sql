CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_kostenrechnungskreis (
krk_id STRING(4) COLLATE 'und:ci' NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
gj_variante_id STRING(2) COLLATE 'und:ci',
krk_bez STRING(40),
krk_orig_id STRING(4) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);