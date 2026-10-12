CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_item_type_ignore_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
item_type_sid BIGNUMERIC(38,0) NOT NULL,
item_type_cd STRING(20) NOT NULL,
item_type_grp_cd STRING(20) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (item_type_sid, item_type_grp_cd) NOT ENFORCED
) CLUSTER BY client_id;