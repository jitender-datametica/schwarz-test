CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_0info_rec_attr_2_pinfo_header_2 (
record_id INTEGER,
client_id BIGNUMERIC(38),
pinfo_sid BIGNUMERIC(38),
src_infnr STRING(20),
sup_sid BIGNUMERIC(38),
item_sid BIGNUMERIC(38),
sap_creation_dt DATE,
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);