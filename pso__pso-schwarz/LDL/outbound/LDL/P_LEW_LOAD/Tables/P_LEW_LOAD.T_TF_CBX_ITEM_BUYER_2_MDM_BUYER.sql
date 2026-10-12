CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_buyer_2_mdm_buyer (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_buyer_cbxitem_buyer_documentref STRING(250),
src_user_doc_ref STRING(100) COLLATE 'und:ci',
cbx_user_version_nr BIGNUMERIC(38),
buyer_cd STRING(20),
buyer_forename STRING(100) COLLATE 'und:ci',
buyer_surname STRING(100) COLLATE 'und:ci',
buyer_email STRING(100) COLLATE 'und:ci',
buyer_notes STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);