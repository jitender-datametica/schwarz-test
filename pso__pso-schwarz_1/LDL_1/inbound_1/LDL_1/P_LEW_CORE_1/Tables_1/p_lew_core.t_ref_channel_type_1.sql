CREATE TABLE p_lew_core.t_ref_channel_type_1
(
channel_type_cd CHAR(5) COLLATE 'en-ci' NOT NULL COMMENT 'Channel Type Code',
channel_type_descr VARCHAR(100) COLLATE 'en-ci' NOT NULL COMMENT 'Channel Type Description',
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_ref_channel_type_upi PRIMARY KEY ( channel_type_cd ))
;

