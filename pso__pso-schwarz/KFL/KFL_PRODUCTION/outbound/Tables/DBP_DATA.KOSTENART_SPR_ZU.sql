CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kostenart_spr_zu (
kostenart_id STRING(10) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
krk_id STRING(4) COLLATE 'und:ci' NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
kostenart_bez STRING(40),
td_update TIMESTAMP,
td_insert TIMESTAMP
);