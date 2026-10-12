CREATE TABLE p_lew_core.t_ref_channel_group_type_2
(
channel_grp_type_cd CHAR(5) COLLATE 'en-ci' NOT NULL COMMENT 'Channel Group Type Code',
channel_grp_type_descr VARCHAR(100) COLLATE 'en-ci' NOT NULL COMMENT 'Channel Group Type Description',
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_ref_channel_group_type_upi PRIMARY KEY ( channel_grp_type_cd ))
;

