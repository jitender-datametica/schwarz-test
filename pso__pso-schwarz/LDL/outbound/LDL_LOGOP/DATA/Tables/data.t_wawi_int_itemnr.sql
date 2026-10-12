/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_wawi_int_itemnr
Description		|	WAWI table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_int_itemnr (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
wawi_instanz_kzl STRING(3) NOT NULL,
int_itemnr STRING(20) NOT NULL OPTIONS(description='International item number'),
itemnr STRING(18) NOT NULL OPTIONS(description='National item number'),
int_itemdesc STRING(100) OPTIONS(description='German description'),
casesize NUMERIC(10,5) OPTIONS(description='Not in use (default null)'),
moddate DATETIME OPTIONS(description='Last modification date'),
moduser STRING(8) OPTIONS(description='Last user'),
int_itemnrsho STRING(4) OPTIONS(description='Not in use (default null)'),
active INTEGER
OPTIONS(description='Status of the link 0 = inactive; Active flag in WAWI is not checked 1 = active; Active flag in WAWI is checked'),
is_main_link INTEGER,
scn BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, int_itemnr, itemnr, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='WAWI - HQWAWIADM.T215_INT_ITEMNR Table for linking international item numbers with national item numbers.');