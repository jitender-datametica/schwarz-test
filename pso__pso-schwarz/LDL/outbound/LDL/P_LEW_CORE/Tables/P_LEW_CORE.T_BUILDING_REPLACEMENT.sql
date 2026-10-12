CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_building_replacement (
client_id BIGNUMERIC(38,0) NOT NULL,
building_sid BIGNUMERIC(38,0) NOT NULL,
building_sid_successor BIGNUMERIC(38,0) NOT NULL,
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (building_sid, building_sid_successor) NOT ENFORCED
) CLUSTER BY client_id;