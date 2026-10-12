CREATE TABLE p_lew_core.t_sales_channel_1 (
client_id INTEGER NOT NULL COMMENT 'Client ID',
sales_channel_sid INTEGER NOT NULL COMMENT 'Sales_1 Channel SID',
sales_channel_cd VARCHAR(30) COLLATE 'en-ci' NOT NULL COMMENT 'Sales_1 Channel Code',
sales_channel_name VARCHAR(100) COLLATE 'en-ci' COMMENT 'Sales_1 Channel Name',
sales_channel_descr VARCHAR(100) COLLATE 'en-ci' COMMENT 'Sales_1 Channel Description',
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_sales_channel_pk PRIMARY KEY ( sales_channel_sid ),
UNIQUE ( client_id ,sales_channel_sid)
)
;

