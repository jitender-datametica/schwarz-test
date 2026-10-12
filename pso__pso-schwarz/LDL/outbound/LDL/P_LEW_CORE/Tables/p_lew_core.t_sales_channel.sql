CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_sales_channel (
client_id INTEGER NOT NULL OPTIONS(description='Client ID'),
sales_channel_sid INTEGER NOT NULL OPTIONS(description='Sales Channel SID'),
sales_channel_cd STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='Sales Channel Code'),
sales_channel_name STRING(100) COLLATE 'und:ci' OPTIONS(description='Sales Channel Name'),
sales_channel_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='Sales Channel Description'),
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (sales_channel_sid) NOT ENFORCED
);