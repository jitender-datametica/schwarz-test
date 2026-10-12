CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_wfm_last_export_2 (
process_name STRING(100),
process_specification STRING(100),
export_specification STRING(100),
last_export_tmsp DATETIME,
last_export_load_id BIGNUMERIC(38,0),
dwh_created DATETIME,
dwh_updated DATETIME
);