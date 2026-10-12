CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_z_ds_zmmx_v_mast_stpo_2_item_bom_hist_1 (
record_id INTEGER,
client_id BIGNUMERIC(38),
item_bom_sid BIGNUMERIC(38),
bom_alternative_cd STRING(20),
version_counter BIGNUMERIC(38),
active_from_dt DATE,
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