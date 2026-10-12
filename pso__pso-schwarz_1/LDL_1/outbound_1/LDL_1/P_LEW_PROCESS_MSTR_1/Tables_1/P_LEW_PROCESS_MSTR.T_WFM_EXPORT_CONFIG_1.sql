CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_wfm_export_config_1 (
interface_name STRING(300) NOT NULL,
move_type_cd STRING(20),
move_reason_cd STRING(20),
order_type_cd STRING(20),
mis_sfo_type_id BIGNUMERIC(38,0),
complaint_area_mark STRING(20),
complaint_reason_mark STRING(20),
move_type_descr STRING(300) COLLATE 'und:ci',
mis_sfo_type_descr STRING(300) COLLATE 'und:ci',
move_reason_descr STRING(300) COLLATE 'und:ci',
order_type_descr STRING(300) COLLATE 'und:ci',
writeoff_zero_fg BIGNUMERIC(38,0),
item_status_cd STRING(20),
active_fg BIGNUMERIC(38,0),
row_id BIGNUMERIC(38,0),
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);