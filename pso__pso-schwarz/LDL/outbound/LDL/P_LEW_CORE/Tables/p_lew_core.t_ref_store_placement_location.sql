CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_store_placement_location (
client_id INTEGER NOT NULL,
store_placement_loc_cd STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='Store Placement Location Code'),
store_placement_loc_descr STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Store Placement Location Description'),
int_std_fg INTEGER OPTIONS(description='International Standard Flag'),
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id) NOT ENFORCED
);