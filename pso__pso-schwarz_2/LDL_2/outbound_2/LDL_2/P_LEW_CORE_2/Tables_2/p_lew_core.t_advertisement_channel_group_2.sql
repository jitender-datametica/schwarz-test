CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_advertisement_channel_group_2 (
client_id INTEGER NOT NULL,
adv_channel_grp_sid INTEGER NOT NULL OPTIONS(description='Advertisement Channel Group SID'),
adv_channel_grp_nr STRING(20) COLLATE 'und:ci' OPTIONS(description='Advertisement Channel Group Number'),
adv_channel_grp_name STRING(100) COLLATE 'und:ci' OPTIONS(description='Advertisement Channel Group Name'),
adv_channel_grp_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='Advertisement Channel Group Description'),
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (adv_channel_grp_sid) NOT ENFORCED
);