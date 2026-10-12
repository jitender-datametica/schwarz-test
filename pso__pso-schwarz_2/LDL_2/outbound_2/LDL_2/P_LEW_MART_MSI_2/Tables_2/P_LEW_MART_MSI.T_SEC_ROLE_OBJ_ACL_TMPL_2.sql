CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_sec_role_obj_acl_tmpl_2 (
change_type STRING(128) COLLATE 'und:ci' NOT NULL,
attribute_frst STRING(128) COLLATE 'und:ci' NOT NULL,
attribute_scnd STRING(128) COLLATE 'und:ci',
change_type_value BIGNUMERIC(38,0),
change_dat DATE,
load_id BIGNUMERIC(38,0),
entry_user STRING(128) COLLATE 'und:ci',
approval_user STRING(128) COLLATE 'und:ci'
);