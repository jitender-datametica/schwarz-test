CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_cbx_program_cbxprogram_2_mdm_range_selection (
record_id INTEGER,
client_id BIGNUMERIC(38),
mdm_range_sel_sid BIGNUMERIC(38),
src_prog_doc_ref STRING(20) COLLATE 'und:ci',
range_plan_cd STRING(20) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);