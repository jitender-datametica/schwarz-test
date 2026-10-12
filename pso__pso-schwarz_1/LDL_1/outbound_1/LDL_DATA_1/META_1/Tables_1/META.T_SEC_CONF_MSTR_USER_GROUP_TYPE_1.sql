CREATE TABLE IF NOT EXISTS ldl_data_meta.t_sec_conf_mstr_user_group_type_1 (
user_grp_type_cd STRING(20) NOT NULL OPTIONS(description='The type of the user group technical or business is'),
user_grp_type_descr STRING(250) NOT NULL OPTIONS(description='The description of  user group type'),
PRIMARY KEY (user_grp_type_cd) NOT ENFORCED
) OPTIONS(description='The user group type, if the user group is business or techical relevant');