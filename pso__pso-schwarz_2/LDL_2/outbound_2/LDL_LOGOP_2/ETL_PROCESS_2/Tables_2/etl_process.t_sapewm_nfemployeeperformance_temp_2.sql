/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_sapewm_nfemployeeperformance_temp_2
Description		|	SAP EWM - source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_sapewm_nfemployeeperformance_temp_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number'),
lgnum STRING(5) NOT NULL OPTIONS(description='Warehouse Number/Warehouse Complex'),
zz_werks STRING(4) OPTIONS(description='Store'),
zz_kw STRING(2) OPTIONS(description='Calendar_2 week'),
zz_refbs STRING(10) OPTIONS(description='Return number'),
huident STRING(20) OPTIONS(description='Handling Unit_2 Identification'),
productno STRING(40) OPTIONS(description='Product Number'),
defect BOOL OPTIONS(description='Flag: Is defect'),
art_unknown BOOL OPTIONS(description='Flag: Is article unknown'),
is_in_ret BOOL OPTIONS(description='Flag: Is in return'),
sps BOOL OPTIONS(description='Flag: Is Special Sales_2'),
matnr_dummy STRING(40) OPTIONS(description='Dummy_2 material number'),
repeat_qty BIGNUMERIC(38,14) OPTIONS(description='Quantity Field'),
uom STRING(3) OPTIONS(description='Unit_2 of Measure'),
station_id STRING(10) OPTIONS(description='Id of Scan Station in NF counting process'),
station_id_prep STRING(10) OPTIONS(description='Id of Scan Station in NF preparation process'),
created_date DATE NOT NULL OPTIONS(description='Created On'),
created_time TIME OPTIONS(description='Created At'),
creusr STRING(12) OPTIONS(description='Created By'),
name STRING(80) OPTIONS(description='Full Name of Person'),
undo_set BOOL OPTIONS(description='Undo flag'),
offline_srt BOOL OPTIONS(description='Offline Sorting'),
scan_guid STRING(50) OPTIONS(description='Scan ID'),
ean11 STRING(18) OPTIONS(description='Data Element:  International Article Number'),
sort_req BOOL OPTIONS(description='SORT REQ'),
is_unpacked STRING(1) OPTIONS(description='Is unpacked'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at')
) OPTIONS(description='SAP EWM - Employee_2 Performance');