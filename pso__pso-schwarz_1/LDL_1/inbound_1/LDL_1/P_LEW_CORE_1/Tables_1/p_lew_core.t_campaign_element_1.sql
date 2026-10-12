CREATE TABLE p_lew_core.t_campaign_element_1 (
client_id INTEGER NOT NULL,
campaign_elem_sid INTEGER NOT NULL COMMENT 'Campaign Element Sid',
src_srcinst_cd CHAR(2) COLLATE 'en-ci' COMMENT 'Source SRCINST Code',
src_pvpit_id VARCHAR(30) COLLATE 'en-ci' COMMENT 'Source PVPIT ID',
campaign_sid INTEGER COMMENT 'Campaign Sid',
item_sid INTEGER NOT NULL COMMENT 'Item_1 Sid',
campaign_elem_status_cd CHAR(6) COLLATE 'en-ci' NOT NULL COMMENT 'Campaign Element Status_1 Code',
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_campaign_element_pk PRIMARY KEY ( campaign_elem_sid ),
UNIQUE ( client_id ,campaign_elem_sid)
)
;

