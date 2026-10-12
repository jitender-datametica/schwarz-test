CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_itm_missing_2_item_missing_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
itm_missing__slash_bic_slash_zmmi_no STRING(20),
item_missing_id NUMERIC(20,0),
src_matnr STRING(40),
src_werks STRING(40),
storage_loc_cd STRING(20),
dwh_cal_dt DATE,
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);