CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kostenart_grp_spr_zu_2 (
kostenart_grp_id STRING(30) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
kostenart_grp_bez STRING(60),
td_insert TIMESTAMP,
td_update TIMESTAMP
);