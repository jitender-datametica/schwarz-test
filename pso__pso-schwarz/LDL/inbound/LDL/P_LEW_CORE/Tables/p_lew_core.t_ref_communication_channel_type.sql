CREATE TABLE p_lew_core.t_ref_communication_channel_type
(
comm_channel_type_cd CHAR(5) COLLATE 'en-ci' NOT NULL COMMENT 'Communication Channel Type Code',
comm_channel_type_descr VARCHAR(100) COLLATE 'en-ci' NOT NULL COMMENT 'Communication Channel Type Description',
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_ref_communication_channel_type_upi PRIMARY KEY ( comm_channel_type_cd ))
;

