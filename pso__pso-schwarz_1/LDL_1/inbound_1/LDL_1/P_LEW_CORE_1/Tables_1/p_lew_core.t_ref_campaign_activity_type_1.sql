CREATE TABLE p_lew_core.t_ref_campaign_activity_type_1
(
campaign_activity_type_cd CHAR(5) COLLATE 'en-ci' NOT NULL COMMENT 'Campaign Activity Type Code',
campaign_activity_type_descr VARCHAR(100) COLLATE 'en-ci' COMMENT 'Campaign Activity Type Description',
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_ref_campaign_activity_type_upi PRIMARY KEY ( campaign_activity_type_cd ))
;

