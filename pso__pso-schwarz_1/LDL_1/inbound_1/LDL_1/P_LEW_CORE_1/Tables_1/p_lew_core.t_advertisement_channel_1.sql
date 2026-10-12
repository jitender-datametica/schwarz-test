CREATE TABLE p_lew_core.t_advertisement_channel_1 (
client_id INTEGER NOT NULL,
adv_channel_sid INTEGER NOT NULL COMMENT 'Advertisement Channel SID',
adv_channel_cd VARCHAR(30) COLLATE 'en-ci' NOT NULL COMMENT 'Advertisement Channel Code',
adv_channel_name VARCHAR(100) COLLATE 'en-ci' COMMENT 'Advertisement Channel Name',
adv_channel_short_name VARCHAR(100) COLLATE 'en-ci' COMMENT 'Advertisement Channel Short Name',
adv_channel_descr VARCHAR(100) COLLATE 'en-ci' COMMENT 'Advertisement Channel Description',
int_std_fg BYTEINT COMMENT 'International Standard Flag',
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_advertisement_channel_pk PRIMARY KEY ( adv_channel_sid ),
UNIQUE ( client_id ,
adv_channel_sid)
)
;

