CREATE TABLE p_lew_core.t_channel_to_channel_group_hist
(
client_id INTEGER NOT NULL COMMENT 'Client ID',
channel_sid INTEGER NOT NULL COMMENT 'Channel SID',
channel_grp_sid INTEGER NOT NULL COMMENT 'Channel Group SID',
channel_grp_type_cd CHAR(5) COLLATE 'en-ci' NOT NULL COMMENT 'Channel Group Type Code',
comm_channel_grp_type_cd CHAR(5) COLLATE 'en-ci' COMMENT 'Communication Channel Group Type Code',
display_order_seq INTEGER COMMENT 'Display Order Sequence',
deleted_fg BYTEINT NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_channel_to_channel_group_hist_pk PRIMARY KEY ( channel_sid ,
channel_grp_sid ,dwh_valid_from ));

