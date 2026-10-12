CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_assort_region_cat (
client_id BIGNUMERIC(38,0) NOT NULL,
region_sid BIGNUMERIC(38,0) NOT NULL,
assort_cat_sid BIGNUMERIC(38,0) NOT NULL,
assort_region_cat_id STRING(27),
assort_parnt_cat_name_de STRING(100) COLLATE 'und:ci',
assort_parnt_cat_name_en STRING(100) COLLATE 'und:ci',
assort_chld_cat_name_de STRING(100) COLLATE 'und:ci',
assort_chld_cat_name_en STRING(100) COLLATE 'und:ci',
sel_srt_cd BIGNUMERIC(38,0),
data_avbl_nopromo_fg BIGNUMERIC(38,0),
data_avbl_promo_fg BIGNUMERIC(38,0),
active_fg BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY client_id;