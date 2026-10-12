CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.vis_struktur_ker_1 (
ker_lv BIGNUMERIC(38,0) NOT NULL,
ker_id STRING(10) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
ker_bez STRING(60) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);