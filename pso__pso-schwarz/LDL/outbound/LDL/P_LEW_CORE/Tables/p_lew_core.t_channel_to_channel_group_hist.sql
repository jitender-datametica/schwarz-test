CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_channel_to_channel_group_hist (
client_id INTEGER NOT NULL OPTIONS(description='Client ID'),
channel_sid INTEGER NOT NULL OPTIONS(description='Channel SID'),
channel_grp_sid INTEGER NOT NULL OPTIONS(description='Channel Group SID'),
channel_grp_type_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Channel Group Type Code'),
comm_channel_grp_type_cd STRING COLLATE 'und:ci' OPTIONS(description='Communication Channel Group Type Code'),
display_order_seq INTEGER OPTIONS(description='Display Order Sequence'),
deleted_fg INTEGER NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (channel_sid, channel_grp_sid, dwh_valid_from) NOT ENFORCED
);