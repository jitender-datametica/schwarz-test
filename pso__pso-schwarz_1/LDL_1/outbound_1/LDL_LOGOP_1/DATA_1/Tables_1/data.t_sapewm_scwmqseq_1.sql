/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_scwmqseq_1
Description		|	SAP EWM - source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_sapewm_scwmqseq_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number'),
mandt STRING(3) OPTIONS(description='Client'),
lgnum STRING(5) OPTIONS(description='Warehouse Number/Warehouse Complex'),
rsrc_grp STRING(4) OPTIONS(description='Resource Group'),
seqno BIGNUMERIC(38,0) OPTIONS(description='Sequence Number'),
queue STRING(10) OPTIONS(description='Queue'),
nointerleav BOOL OPTIONS(description='No Interleaving in RF'),
zz_crssys BOOL OPTIONS(description='Cross System Guided'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at')
) OPTIONS(description='SAP EWM - Sequenced Queues Per Resource Group');