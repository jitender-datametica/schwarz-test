/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_sapewm_countinglog_temp_2
Description		|	SAP EWM - source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_sapewm_countinglog_temp_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number'),
mandt STRING(3) OPTIONS(description='Client'),
lgnum STRING(4) NOT NULL OPTIONS(description='Warehouse Number/Warehouse Complex'),
finish_tstamp DATETIME NOT NULL OPTIONS(description='Time of Confirmation'),
uname STRING(12) NOT NULL OPTIONS(description='ABAP System Field: Name of Current User'),
door STRING(4) NOT NULL OPTIONS(description='Warehouse Door'),
lane STRING(18) NOT NULL OPTIONS(description='Storage Bin'),
start_tstamp DATETIME OPTIONS(description='Start Time'),
tu_num STRING(18) OPTIONS(description='Internal Number of Transportation Unit_2'),
tu_sr_act_num BIGNUMERIC(38,0) OPTIONS(description='Shipping and Receiving Activity Number: Transportation Unit_2'),
count_hu BIGNUMERIC(38,0) OPTIONS(description='2 Byte Signed Integer'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (client_id, lgnum, finish_tstamp, uname, door, lane) NOT ENFORCED
) OPTIONS(description='SAP EWM - Internal counting log for warehouse performance (R338)');