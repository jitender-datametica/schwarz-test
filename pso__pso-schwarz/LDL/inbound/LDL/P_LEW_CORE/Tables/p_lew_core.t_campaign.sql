CREATE TABLE p_lew_core.t_campaign (
client_id INTEGER NOT NULL,
campaign_sid INTEGER NOT NULL COMMENT 'Campaign Sid',
src_item_campaign_name VARCHAR(250) COLLATE 'en-ci' COMMENT 'Source Item Campaign Name',
src_theme_nat VARCHAR(250) COLLATE 'en-ci' COMMENT 'Source Theme Nat',
src_valid_from DATE COMMENT 'Source Valid From',
campaign_name VARCHAR(250) COLLATE 'en-ci' COMMENT 'Campaign Name',
campaign_start_dt DATE COMMENT 'Campaign Start Date',
campaign_end_dt DATE COMMENT 'Campaign End Date',
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_campaign_pk PRIMARY KEY ( campaign_sid ),
UNIQUE ( client_id ,campaign_sid)
)
;



