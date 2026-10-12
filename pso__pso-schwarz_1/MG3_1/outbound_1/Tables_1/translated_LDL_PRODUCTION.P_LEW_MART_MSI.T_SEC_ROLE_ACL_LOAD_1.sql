CREATE OR REPLACE TABLE p_lew_mart_msi.t_sec_role_acl_load_1 (
change_type STRING(128) COLLATE 'und:ci',
security_role_desc STRING(128) COLLATE 'und:ci',
dashboard_name STRING(128) COLLATE 'und:ci',
authorized BIGNUMERIC(38,0),
change_dat DATE,
load_id BIGNUMERIC(38,0),
approval_user STRING(128) COLLATE 'und:ci',
entry_user STRING(128) COLLATE 'und:ci',
dashboard_disp_name STRING(128) COLLATE 'und:ci'
);