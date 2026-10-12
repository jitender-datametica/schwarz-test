CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_cbx_project_cbxproject_2_mdm_advertise_theme (
record_id INTEGER,
client_id BIGNUMERIC(38),
mdm_ad_theme_sid BIGNUMERIC(38),
src_proj_doc_ref STRING(20) COLLATE 'und:ci',
ad_theme_name STRING(100),
ad_theme_cd STRING(20) COLLATE 'und:ci',
ad_theme_id NUMERIC(20,0),
busyear_ad_theme BIGNUMERIC(38),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);