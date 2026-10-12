CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_campaign (
client_id INTEGER NOT NULL,
campaign_sid INTEGER NOT NULL OPTIONS(description='Campaign Sid'),
src_item_campaign_name STRING(250) COLLATE 'und:ci' OPTIONS(description='Source Item Campaign Name'),
src_theme_nat STRING(250) COLLATE 'und:ci' OPTIONS(description='Source Theme Nat'),
src_valid_from DATE OPTIONS(description='Source Valid From'),
campaign_name STRING(250) COLLATE 'und:ci' OPTIONS(description='Campaign Name'),
campaign_start_dt DATE OPTIONS(description='Campaign Start Date'),
campaign_end_dt DATE OPTIONS(description='Campaign End Date'),
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (campaign_sid) NOT ENFORCED
);