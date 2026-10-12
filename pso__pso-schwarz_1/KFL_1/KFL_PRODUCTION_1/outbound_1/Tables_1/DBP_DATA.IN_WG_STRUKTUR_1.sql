CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_wg_struktur_1 (
in_wg_struktur_id STRING(20) COLLATE 'und:ci' NOT NULL,
in_wg_struktur_ebene_id BIGNUMERIC(38,0) NOT NULL,
in_wg_struktur_mutter_id STRING(20) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);