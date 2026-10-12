CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_project_2_mdm_ad_theme_item_hist_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_project_cbxitem_documentref STRING(250),
cbx_item_project_cbxitem_project_documentref STRING(250),
src_proj_doc_ref STRING(40),
src_item_doc_ref STRING(40),
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);