/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_resource
Description		|	SAP EWM - source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_sapewm_resource (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number'),
lgnum STRING(5) NOT NULL OPTIONS(description='Warehouse Number/Warehouse Complex'),
rsrc STRING(18) NOT NULL OPTIONS(description='Resource (Means of Transportation or User)'),
rsrc_type STRING(4) OPTIONS(description='Resource Type'),
rsrc_grp STRING(4) OPTIONS(description='Resource Group'),
def_prdvc STRING(4) OPTIONS(description='Default Presentation Device'),
uname STRING(12) OPTIONS(description='User Name'),
rfind STRING(1) OPTIONS(description='RF Execution Environment'),
queue STRING(10) OPTIONS(description='Queue'),
act_queue STRING(10) OPTIONS(description='Actual Queue of Resource'),
lgtyp STRING(4) OPTIONS(description='Storage Type of Last Removal'),
logon_date DATE OPTIONS(description='Logon Date on RF'),
logon_time TIME OPTIONS(description='Logon Time on RF'),
cur_prdvc STRING(4) OPTIONS(description='Current Presentation Device'),
applic STRING(2) OPTIONS(description='Application'),
ltrans STRING(6) OPTIONS(description='Logical Transaction'),
ltranschg_date DATE OPTIONS(description='Date of Logical Transaction Change in RF'),
ltranschg_time TIME OPTIONS(description='Time of Logical Transaction Change in RF'),
default_bin STRING(18) OPTIONS(description='Standard Storage Bin of a Resource'),
actual_bin STRING(18) OPTIONS(description='Current Storage Bin of a Resource'),
zz_locked BOOL OPTIONS(description='Lock Resource (X Yes,   No)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, lgnum, rsrc, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='SAP EWM - Resource for WM Monitor Output');