CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_project_cbxproject_2_mdm_advertise_theme (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_project_cbxproject_cbxproject_documentref STRING(250) COLLATE 'und:ci',
src_proj_doc_ref STRING(20) COLLATE 'und:ci',
ad_theme_name STRING(100),
ad_theme_cd STRING(20) COLLATE 'und:ci',
ad_theme_id NUMERIC(20,0),
busyear_ad_theme BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);