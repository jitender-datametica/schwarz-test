DROP TABLE IF EXISTS ldl_production_p_lew_process_mstr.t_lil_assort_region_cat;
CREATE OR REPLACE TABLE ldl_production_p_lew_process_mstr.t_lil_assort_region_cat (
client_id INTEGER NOT NULL,
region_sid INTEGER NOT NULL,
assort_cat_sid INTEGER NOT NULL,
assort_region_cat_id STRING(27),
assort_parnt_cat_name_de STRING(100) COLLATE 'und:ci',
assort_parnt_cat_name_en STRING(100) COLLATE 'und:ci',
assort_chld_cat_name_de STRING(100) COLLATE 'und:ci',
assort_chld_cat_name_en STRING(100) COLLATE 'und:ci',
sel_srt_cd INTEGER,
data_avbl_nopromo_fg INTEGER,
data_avbl_promo_fg INTEGER,
active_fg INTEGER,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY client_id;