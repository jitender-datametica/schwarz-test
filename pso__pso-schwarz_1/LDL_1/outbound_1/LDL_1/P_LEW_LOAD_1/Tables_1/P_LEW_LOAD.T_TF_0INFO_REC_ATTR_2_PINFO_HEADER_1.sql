CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_0info_rec_attr_2_pinfo_header_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
info_rec_attr_infnr STRING(20),
src_infnr STRING(20),
src_lifnr STRING(40),
src_matnr STRING(40),
sap_creation_dt DATE,
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);