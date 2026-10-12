CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_ct_sec_role_acl_1 (
security_role_id BIGNUMERIC(38,0) NOT NULL,
security_role_desc STRING(128) COLLATE 'und:ci' NOT NULL,
dashboard_name STRING(128) COLLATE 'und:ci' NOT NULL,
authorized BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
entry_user STRING(128) COLLATE 'und:ci' NOT NULL,
entry_datetime DATETIME NOT NULL,
approval_user STRING(128) COLLATE 'und:ci' NOT NULL,
approval_datetime DATETIME,
approved BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
active_fg BIGNUMERIC(38,0)
);