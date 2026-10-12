/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_queue_2
Description		|	SAP EWM - source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_sapewm_queue_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number'),
lgnum STRING(5) NOT NULL OPTIONS(description='Warehouse Number/Warehouse Complex'),
queue STRING(10) NOT NULL OPTIONS(description='Queue'),
rfrsrc STRING(1) OPTIONS(description='Operating Environment'),
tot_who BIGNUMERIC(38,0) OPTIONS(description='Total Number of Open Warehouse Orders'),
tot_rsrc BIGNUMERIC(38,0) OPTIONS(description='Number of Active Resources per Queue'),
text_descr STRING(40) OPTIONS(description='Description'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (client_id, lgnum, queue) NOT ENFORCED
) OPTIONS(description='SAP EWM - Queue for WM_2 Monitor Output');