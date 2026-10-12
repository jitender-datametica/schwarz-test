CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_ct_sec_role_obj_acl_move (
security_role_id BIGNUMERIC(38,0) NOT NULL,
security_role_desc STRING(128) COLLATE 'und:ci' NOT NULL,
object_name STRING(128) COLLATE 'und:ci' NOT NULL,
object_type_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
nstd_lft_id BIGNUMERIC(38,0) NOT NULL,
nstd_rgt_id BIGNUMERIC(38,0) NOT NULL,
authorized BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
entry_user STRING(128) COLLATE 'und:ci' NOT NULL,
entry_datetime DATETIME NOT NULL,
approval_user STRING(128) COLLATE 'und:ci' NOT NULL,
approval_datetime DATETIME,
approved BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
active_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
zero_val BIGNUMERIC(38,0) DEFAULT 0
);