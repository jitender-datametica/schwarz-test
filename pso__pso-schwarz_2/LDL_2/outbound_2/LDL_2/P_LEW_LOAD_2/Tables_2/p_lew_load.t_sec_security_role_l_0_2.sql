CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_sec_security_role_l_0_2 (
change_type STRING(128) COLLATE 'und:ci',
security_role_desc STRING(128) COLLATE 'und:ci',
dashboard_name STRING(128) COLLATE 'und:ci',
authorized INTEGER DEFAULT NULL,
change_dat DATE,
load_id INTEGER,
approval_user STRING(128) COLLATE 'und:ci',
entry_user STRING(128) COLLATE 'und:ci'
);