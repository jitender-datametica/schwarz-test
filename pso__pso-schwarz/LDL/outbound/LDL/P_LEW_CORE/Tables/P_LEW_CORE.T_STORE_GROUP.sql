CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_store_group (
client_id INTEGER NOT NULL,
store_grp_sid INTEGER NOT NULL OPTIONS(description='Store Group Sid'),
src_wh_nr STRING(20) COLLATE 'und:ci' OPTIONS(description='Source Warehouse Number'),
src_store_grp_id STRING(20) COLLATE 'und:ci' OPTIONS(description='Source Store Group Id'),
src_storgrp_id STRING(30) COLLATE 'und:ci' OPTIONS(description='Source StorGrp Id'),
store_grp_type_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Store Group Type Code'),
campaign_store_grp_type_cd STRING COLLATE 'und:ci' OPTIONS(description='Campaign Store Group Type Code'),
store_grp_nr STRING(20) COLLATE 'und:ci' OPTIONS(description='Store Group Number'),
store_grp_name STRING(100) COLLATE 'und:ci' OPTIONS(description='Store Group Name'),
store_grp_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='Store Group Description'),
loc_sid_wh INTEGER,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (store_grp_sid) NOT ENFORCED
);