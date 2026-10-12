CREATE TABLE p_lew_core.t_campaign_hist
(
client_id INTEGER NOT NULL,
campaign_sid INTEGER NOT NULL COMMENT 'Campaign Sid',
campaign_name VARCHAR(250) COLLATE 'en-ci' COMMENT 'Campaign Name',
campaign_start_dt DATE COMMENT 'Campaign Start Date',
campaign_end_dt DATE COMMENT 'Campaign End Date',
deleted_fg BYTEINT NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_campaign_hist_pk PRIMARY KEY ( campaign_sid ,dwh_valid_from ))
;