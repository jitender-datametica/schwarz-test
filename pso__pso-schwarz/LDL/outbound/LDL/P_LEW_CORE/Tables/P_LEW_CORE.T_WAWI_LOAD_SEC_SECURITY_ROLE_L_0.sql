CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_load_sec_security_role_l_0 (
change_type STRING(128) COLLATE 'und:ci',
security_role_desc STRING(128) COLLATE 'und:ci',
dashboard_name STRING(128) COLLATE 'und:ci',
authorized BIGNUMERIC(38,0),
change_dat DATE,
load_id BIGNUMERIC(38,0),
approval_user STRING(128) COLLATE 'und:ci',
entry_user STRING(128) COLLATE 'und:ci'
);