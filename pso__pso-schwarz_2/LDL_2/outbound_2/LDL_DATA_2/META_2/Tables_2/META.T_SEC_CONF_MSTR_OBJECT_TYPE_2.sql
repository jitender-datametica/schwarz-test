CREATE TABLE IF NOT EXISTS ldl_data_meta.t_sec_conf_mstr_object_type_2 (
obj_type_cd STRING(20) NOT NULL OPTIONS(description='The type of the object report or metric user group'),
obj_type_descr STRING(250) NOT NULL OPTIONS(description='The description of  microstrategy object type'),
PRIMARY KEY (obj_type_cd) NOT ENFORCED
) OPTIONS(description='The user group type, if the user group is business or techical relevant');