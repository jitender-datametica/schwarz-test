CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_cbx_item_relateditem_2_mdm_item_related_item_hist_2 (
record_id INTEGER,
client_id BIGNUMERIC(38),
mdm_item_sid BIGNUMERIC(38),
item_rel_type_cd STRING(20) COLLATE 'und:ci',
mdm_item_sid_related BIGNUMERIC(38),
deleted_fg BIGNUMERIC(38),
dwh_valid_from DATE,
dwh_valid_to DATE,
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);