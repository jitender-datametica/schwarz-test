CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_saule_config_requests_1 (
req_id BIGNUMERIC(38,0),
status_id BIGNUMERIC(38,0),
req_date DATE,
requestor STRING(50) COLLATE 'und:ci',
approver STRING(50) COLLATE 'und:ci',
status_desc STRING(80) COLLATE 'und:ci'
);