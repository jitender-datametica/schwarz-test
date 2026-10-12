CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_channel_2 (
client_id INTEGER NOT NULL,
channel_sid INTEGER NOT NULL OPTIONS(description='Channel SID'),
src_srcinst_cd STRING COLLATE 'und:ci' OPTIONS(description='Source SRCINST Code'),
src_advmed_id STRING(30) COLLATE 'und:ci' OPTIONS(description='Source Advmed ID'),
src_salestype_value STRING(20) COLLATE 'und:ci' OPTIONS(description='Source Salestype Value'),
channel_type_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Channel Type Code'),
comm_channel_type_cd STRING COLLATE 'und:ci' OPTIONS(description='Communication_2 Channel Type Code'),
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (channel_sid) NOT ENFORCED
);