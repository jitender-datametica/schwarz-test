CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_process_mstr_ref_lil_promotion_brand_2_ref_lil_promotion_brand (
record_id STRING(1000) COLLATE 'und:ci',
promotion_brand_id BIGNUMERIC(38),
promotion_brand_descr STRING(100) COLLATE 'und:ci',
liam1_srt_cd BIGNUMERIC(38),
lift1_srt_cd BIGNUMERIC(38),
active_fg BIGNUMERIC(38),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);