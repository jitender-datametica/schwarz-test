/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_pickingbreak_2
Description		|	SAP EWM - source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_sapewm_pickingbreak_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number'),
mandt STRING(5) OPTIONS(description='Client of the EWM system'),
lgnum STRING(5) NOT NULL OPTIONS(description='Warehouse Number/Warehouse Complex'),
created_by STRING(12) NOT NULL OPTIONS(description='Created By'),
start_date DATE NOT NULL OPTIONS(description='Start Date'),
start_time TIME NOT NULL OPTIONS(description='Start Time'),
start_tstamp DATETIME OPTIONS(description='UTC Time Stamp in Short Form (YYYYMMDDhhmmss)'),
end_date DATE OPTIONS(description='End Date'),
end_time TIME OPTIONS(description='End Time'),
end_tstamp DATETIME OPTIONS(description='UTC Time Stamp in Short Form (YYYYMMDDhhmmss)'),
duration BIGNUMERIC(38,3) OPTIONS(description='Planned Duration'),
unit_t STRING(5) OPTIONS(description='Time Unit_2'),
who BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse Order Number'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (client_id, lgnum, who, created_by, start_date, start_time) NOT ENFORCED
) OPTIONS(description='SAP EWM - Picking Break in RF');