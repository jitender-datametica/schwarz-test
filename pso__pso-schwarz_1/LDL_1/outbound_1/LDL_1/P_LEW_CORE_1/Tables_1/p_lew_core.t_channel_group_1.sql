CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_channel_group_1 (
client_id INTEGER NOT NULL OPTIONS(description='Client ID'),
channel_grp_sid INTEGER NOT NULL OPTIONS(description='Channel Group SID'),
src_adv_medium_grp_id STRING(20) COLLATE 'und:ci' OPTIONS(description='Source ADV Medium Grp ID'),
channel_grp_type_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Channel Group Type Code'),
comm_channel_grp_type_cd STRING COLLATE 'und:ci' OPTIONS(description='Communication_1 Channel Group Type Code'),
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (channel_grp_sid) NOT ENFORCED
);