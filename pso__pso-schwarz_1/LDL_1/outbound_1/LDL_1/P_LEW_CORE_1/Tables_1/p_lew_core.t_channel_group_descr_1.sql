CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_channel_group_descr_1 (
client_id INTEGER NOT NULL,
channel_grp_sid INTEGER NOT NULL OPTIONS(description='Channel Group SID'),
lang_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Language Code'),
channel_grp_name STRING(100) COLLATE 'und:ci' OPTIONS(description='Channel Group Name'),
channel_grp_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='Channel Group Description'),
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (channel_grp_sid) NOT ENFORCED
);