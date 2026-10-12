CREATE TABLE p_lew_core.t_ref_campaign_element_relation_type_1
(
campaign_elem_rel_type_cd CHAR(5) COLLATE 'en-ci' NOT NULL COMMENT 'Campaign Element Relation Type Code',
campaign_elem_rel_type_descr VARCHAR(100) COLLATE 'en-ci' COMMENT 'Campaign Element Relation Type Description',
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_ref_campaign_element_relation_type_upi PRIMARY KEY ( campaign_elem_rel_type_cd ))
;

