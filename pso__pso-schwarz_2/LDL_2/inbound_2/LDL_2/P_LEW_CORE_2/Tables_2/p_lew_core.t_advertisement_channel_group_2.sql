CREATE TABLE p_lew_core.t_advertisement_channel_group_2 (
client_id INTEGER NOT NULL,
adv_channel_grp_sid INTEGER NOT NULL COMMENT 'Advertisement Channel Group SID',
adv_channel_grp_nr VARCHAR(20) COLLATE 'en-ci' COMMENT 'Advertisement Channel Group Number',
adv_channel_grp_name VARCHAR(100) COLLATE 'en-ci' COMMENT 'Advertisement Channel Group Name',
adv_channel_grp_descr VARCHAR(100) COLLATE 'en-ci' COMMENT 'Advertisement Channel Group Description',
dwh_load_id INTEGER NOT NULL,
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_advertisement_channel_group_pk PRIMARY KEY ( adv_channel_grp_sid ),
UNIQUE ( client_id ,
adv_channel_grp_sid)
)
;

