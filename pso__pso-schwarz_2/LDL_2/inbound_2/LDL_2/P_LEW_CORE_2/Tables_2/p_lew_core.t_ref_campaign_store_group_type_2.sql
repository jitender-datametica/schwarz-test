CREATE TABLE p_lew_core.t_ref_campaign_store_group_type_2
(
campaign_store_grp_type_cd CHAR(5) COLLATE 'en-ci' NOT NULL COMMENT 'Campaign Store Group Type Code',
campaign_store_grp_type_descr VARCHAR(100) COLLATE 'en-ci' COMMENT 'Campaign Store Group Type Description',
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_ref_campaign_store_group_type_upi PRIMARY KEY ( campaign_store_grp_type_cd ))
;

