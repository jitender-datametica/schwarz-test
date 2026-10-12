CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.user_vis_benchmark_zu_2 (
user_id STRING(30) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
hierarchie_element_id BIGNUMERIC(38,0) NOT NULL,
hierarchie_ebene_id STRING(10) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);