CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_building (
client_id BIGNUMERIC(38,0) NOT NULL,
building_sid BIGNUMERIC(38,0) NOT NULL,
src_object_no STRING(20) COLLATE 'und:ci',
building_type_id BIGNUMERIC(38,0),
building_name STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (building_sid) NOT ENFORCED
) CLUSTER BY client_id;