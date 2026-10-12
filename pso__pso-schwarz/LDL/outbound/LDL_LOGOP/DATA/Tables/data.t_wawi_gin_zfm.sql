/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_wawi_gin_zfm
Description		|	WAWI table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_gin_zfm (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
wh_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse number'),
wawi_instanz_kzl STRING(3) NOT NULL OPTIONS(description='Country code'),
id INTEGER NOT NULL OPTIONS(description='Unique ID. Sequential number'),
zfm_id STRING(30) OPTIONS(description='ZFM booking number'),
task_id BIGNUMERIC(38,0) OPTIONS(description='Internal Task ID (from T173 and T174)'),
gin_status BIGNUMERIC(38,0) OPTIONS(description='eGIN status'),
return_code BIGNUMERIC(38,0) OPTIONS(description='Status from ZFM (filled by WCI)'),
errormessage STRING(1000) OPTIONS(description='Error message from ZFM (filled by WCI)'),
mod_date DATETIME OPTIONS(description='Modification date of the corresponding line'),
created DATETIME OPTIONS(description='Creation date of the corresponding line'),
scn BIGNUMERIC(38,0) OPTIONS(description=''),
date_zfm DATETIME OPTIONS(description=''),
type_of_goods STRING(200) OPTIONS(description=''),
main_type_of_goods STRING(200) OPTIONS(description=''),
arrival_date DATETIME OPTIONS(description=''),
licence_plate STRING(32) OPTIONS(description=''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_nr, id, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='WAWI - WHWAWIADM.T1046_GIN_ZFM table.');