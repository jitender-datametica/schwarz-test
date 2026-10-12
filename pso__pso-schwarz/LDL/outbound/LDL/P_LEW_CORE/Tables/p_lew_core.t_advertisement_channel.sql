CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_advertisement_channel (
client_id INTEGER NOT NULL,
adv_channel_sid INTEGER NOT NULL OPTIONS(description='Advertisement Channel SID'),
adv_channel_cd STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='Advertisement Channel Code'),
adv_channel_name STRING(100) COLLATE 'und:ci' OPTIONS(description='Advertisement Channel Name'),
adv_channel_short_name STRING(100) COLLATE 'und:ci' OPTIONS(description='Advertisement Channel Short Name'),
adv_channel_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='Advertisement Channel Description'),
int_std_fg INTEGER OPTIONS(description='International Standard Flag'),
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (adv_channel_sid) NOT ENFORCED
);