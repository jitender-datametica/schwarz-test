CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_store_to_store_group_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_store BIGNUMERIC(38,0) NOT NULL OPTIONS(description='LOCATION_2 SID STORE'),
store_grp_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='STORE GROUP SID'),
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
store_grp_type_cd STRING(5) COLLATE 'und:ci' NOT NULL OPTIONS(description='STORE GROUP TYPE CODE'),
campaign_store_grp_type_cd STRING(5) COLLATE 'und:ci' OPTIONS(description='CAMPAIGN STORE GROUP TYPE CODE'),
PRIMARY KEY (loc_sid_store, store_grp_sid, dwh_valid_from) NOT ENFORCED
);