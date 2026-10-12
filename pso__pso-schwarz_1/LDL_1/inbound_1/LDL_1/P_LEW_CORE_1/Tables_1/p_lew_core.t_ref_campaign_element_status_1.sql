CREATE TABLE p_lew_core.t_ref_campaign_element_status_1
(
campaign_elem_status_cd CHAR(6) COLLATE 'en-ci' NOT NULL COMMENT 'Campaign Element Status_1 Code',
campaign_elem_status_descr VARCHAR(100) COLLATE 'en-ci' COMMENT 'Campaign Element Status_1 Description',
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_ref_campaign_element_status_upi PRIMARY KEY ( campaign_elem_status_cd ))
;

