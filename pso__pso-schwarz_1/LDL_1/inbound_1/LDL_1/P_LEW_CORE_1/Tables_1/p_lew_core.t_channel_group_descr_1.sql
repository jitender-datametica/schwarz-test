CREATE TABLE p_lew_core.t_channel_group_descr_1
(
client_id INTEGER NOT NULL,
channel_grp_sid INTEGER NOT NULL COMMENT 'Channel Group SID',
lang_cd CHAR(2) COLLATE 'en-ci' NOT NULL COMMENT 'Language Code',
channel_grp_name VARCHAR(100) COLLATE 'en-ci' COMMENT 'Channel Group Name',
channel_grp_descr VARCHAR(100) COLLATE 'en-ci' COMMENT 'Channel Group Description',
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_channel_group_descr_pk PRIMARY KEY ( channel_grp_sid ,
lang_cd ))
;

