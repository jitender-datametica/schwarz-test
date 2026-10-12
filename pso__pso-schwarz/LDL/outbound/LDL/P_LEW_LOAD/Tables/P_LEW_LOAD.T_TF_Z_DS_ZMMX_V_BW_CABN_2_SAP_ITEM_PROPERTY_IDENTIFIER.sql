CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_zmmx_v_bw_cabn_2_sap_item_property_identifier (
client_id BIGNUMERIC(38),
identifier_id BIGNUMERIC(38),
identifier_name STRING(50) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000) COLLATE 'und:ci'
);