CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.leistung_psp_wg_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
in_wg_id STRING(10) COLLATE 'und:ci' NOT NULL,
bvv_leist_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);