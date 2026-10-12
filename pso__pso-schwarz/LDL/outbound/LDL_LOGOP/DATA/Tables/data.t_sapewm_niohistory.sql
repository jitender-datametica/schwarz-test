/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_niohistory
Description		|	SAP EWM - source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_sapewm_niohistory (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number'),
mandt STRING(3) OPTIONS(description='Client'),
lgnum STRING(5) NOT NULL OPTIONS(description='Warehouse Number/Warehouse Complex'),
huident STRING(20) NOT NULL OPTIONS(description='Handling Unit Identification'),
log_seq BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Log Sequence'),
cp STRING(18) OPTIONS(description='Communication Point for Conveyor Technique'),
utc_timestamp DATETIME OPTIONS(description='UTC Time Stamp in Short Form (YYYYMMDDhhmmss)'),
hu_status STRING(5) OPTIONS(description='Object Status'),
hu_status_short STRING(4) OPTIONS(description='Individual status of an object (short form)'),
hu_status_text STRING(30) OPTIONS(description='Object status'),
matnr STRING(40) OPTIONS(description='Product'),
maktx STRING(40) OPTIONS(description='Product Short Description'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, lgnum, log_seq, huident, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='SAP EWM - NIO History');