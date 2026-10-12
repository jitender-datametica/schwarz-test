CREATE OR REPLACE TABLE kfl_production_dbp_data.in_wg_struktur_spr_zu_2 (
in_wg_struktur_id STRING(20) COLLATE 'und:ci' NOT NULL,
spr_id INTEGER NOT NULL,
in_wg_struktur_bez STRING(50) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);