CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_campaign_element_2 (
client_id INTEGER NOT NULL,
campaign_elem_sid INTEGER NOT NULL OPTIONS(description='Campaign Element Sid'),
src_srcinst_cd STRING COLLATE 'und:ci' OPTIONS(description='Source SRCINST Code'),
src_pvpit_id STRING(30) COLLATE 'und:ci' OPTIONS(description='Source PVPIT ID'),
campaign_sid INTEGER OPTIONS(description='Campaign Sid'),
item_sid INTEGER NOT NULL OPTIONS(description='Item_2 Sid'),
campaign_elem_status_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Campaign Element Status_2 Code'),
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (campaign_elem_sid) NOT ENFORCED
);