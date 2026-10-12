CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_store_group_hist (
client_id BIGNUMERIC(38,0) NOT NULL,
store_grp_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store Group Sid'),
store_grp_nr STRING(20) COLLATE 'und:ci' OPTIONS(description='Store Group Number'),
store_grp_name STRING(100) COLLATE 'und:ci' OPTIONS(description='Store Group Name'),
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
store_grp_type_cd STRING(5) COLLATE 'und:ci' NOT NULL OPTIONS(description='Store Group Type Code'),
campaign_store_grp_type_cd STRING(3) COLLATE 'und:ci' OPTIONS(description='Campaign Store Group Type Code'),
store_grp_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='Store Group Description'),
PRIMARY KEY (store_grp_sid, dwh_valid_from) NOT ENFORCED
);