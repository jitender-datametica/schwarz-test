CREATE TABLE p_lew_core.t_campaign_element_relation_hist_2
(
client_id INTEGER NOT NULL,
campaign_elem_sid INTEGER NOT NULL COMMENT 'Campaign Element Sid',
campaign_elem_sid_rel INTEGER NOT NULL COMMENT 'Campaign Element Sid Related',
campaign_elem_rel_type_cd CHAR(5) COLLATE 'en-ci' NOT NULL COMMENT 'Campaign Element Relation Type Code',
deleted_fg BYTEINT NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_campaign_element_relation_hist_pk PRIMARY KEY ( client_id ,
campaign_elem_sid ,campaign_elem_sid_rel ,campaign_elem_rel_type_cd ,
dwh_valid_from ))
;

