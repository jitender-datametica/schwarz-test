CREATE TABLE p_lew_core.t_channel_2 (
client_id INTEGER NOT NULL,
channel_sid INTEGER NOT NULL COMMENT 'Channel SID',
src_srcinst_cd CHAR(2) COLLATE 'en-ci' COMMENT 'Source SRCINST Code',
src_advmed_id VARCHAR(30) COLLATE 'en-ci' COMMENT 'Source Advmed ID',
src_salestype_value VARCHAR(20) COLLATE 'en-ci' COMMENT 'Source Salestype Value',
channel_type_cd CHAR(5) COLLATE 'en-ci' NOT NULL COMMENT 'Channel Type Code',
comm_channel_type_cd CHAR(5) COLLATE 'en-ci' COMMENT 'Communication_2 Channel Type Code',
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_channel_pk PRIMARY KEY ( channel_sid ),
UNIQUE ( client_id ,channel_sid)
)
;
