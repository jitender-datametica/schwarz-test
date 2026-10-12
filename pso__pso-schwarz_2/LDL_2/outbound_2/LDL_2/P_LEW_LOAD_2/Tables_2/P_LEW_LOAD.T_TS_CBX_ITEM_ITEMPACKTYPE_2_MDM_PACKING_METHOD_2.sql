CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_cbx_item_itempacktype_2_mdm_packing_method_2 (
record_id INTEGER,
client_id BIGNUMERIC(38),
pack_method_sid BIGNUMERIC(38),
src_assortment_cd STRING(20) COLLATE 'und:ci',
src_pack_type_cd STRING(20) COLLATE 'und:ci',
pack_assort_type STRING(100) COLLATE 'und:ci',
pack_method STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);