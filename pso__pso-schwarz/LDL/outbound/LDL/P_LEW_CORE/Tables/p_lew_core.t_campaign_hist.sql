CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_campaign_hist (
client_id INTEGER NOT NULL,
campaign_sid INTEGER NOT NULL OPTIONS(description='Campaign Sid'),
campaign_name STRING(250) COLLATE 'und:ci' OPTIONS(description='Campaign Name'),
campaign_start_dt DATE OPTIONS(description='Campaign Start Date'),
campaign_end_dt DATE OPTIONS(description='Campaign End Date'),
deleted_fg INTEGER NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (campaign_sid, dwh_valid_from) NOT ENFORCED
);