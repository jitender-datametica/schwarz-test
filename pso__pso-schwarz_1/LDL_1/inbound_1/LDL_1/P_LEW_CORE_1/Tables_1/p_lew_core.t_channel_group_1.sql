CREATE TABLE p_lew_core.t_channel_group_1 (
client_id INTEGER NOT NULL COMMENT 'Client ID',
channel_grp_sid INTEGER NOT NULL COMMENT 'Channel Group SID',
src_adv_medium_grp_id VARCHAR(20) COLLATE 'en-ci' COMMENT 'Source ADV Medium Grp ID',
channel_grp_type_cd CHAR(5) COLLATE 'en-ci' NOT NULL COMMENT 'Channel Group Type Code',
comm_channel_grp_type_cd CHAR(5) COLLATE 'en-ci' COMMENT 'Communication_1 Channel Group Type Code',
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_channel_group_pk PRIMARY KEY ( channel_grp_sid ),
UNIQUE ( client_id ,channel_grp_sid)
)
;

