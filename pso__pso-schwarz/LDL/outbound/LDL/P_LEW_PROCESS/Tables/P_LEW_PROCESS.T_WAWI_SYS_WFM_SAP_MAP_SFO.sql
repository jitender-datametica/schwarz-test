CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_wawi_sys_wfm_sap_map_sfo (
interface_name STRING(255) NOT NULL,
mov_type_cd STRING(3) COLLATE 'und:ci',
mov_reason_cd BIGNUMERIC(38,0),
order_type_cd STRING(4),
mis_sfo_type_id BIGNUMERIC(38,0),
cmpnt_area_cd BIGNUMERIC(38,0),
cmpnt_reason_cd BIGNUMERIC(38,0),
mov_type_descr STRING(255),
mis_sfo_type_descr STRING(255),
mov_reason_descr STRING(255),
order_type_descr STRING(255),
writeoff_zero BIGNUMERIC(38,0),
status STRING(30) COLLATE 'und:ci',
active_fg BIGNUMERIC(38,0)
);