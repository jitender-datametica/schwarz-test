CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_lp_custmap_content_2_ref_ident_type (
record_id INTEGER,
context_name STRING(100) COLLATE 'und:ci' NOT NULL,
ident_type_cd STRING(20) COLLATE 'und:ci' NOT NULL,
ident_type_descr STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);