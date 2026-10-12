/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB view			|	t_alma_leftoverpallets_1
Description		|	ALMA table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_alma_leftoverpallets_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='wh_nr as a digit Source warehouse number (datastore_data:lagernummer)'),
id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Primary Key'),
uu_id STRING(50) OPTIONS(description='Default SYS_GUID() Used by the ALMA webservice'),
lane_id BIGNUMERIC(38,0) OPTIONS(description='ID of the selected lane References T1216_LANES.C1216_ID'),
store BIGNUMERIC(38,0) OPTIONS(description='Entered store number'),
ambient BIGNUMERIC(38,2) OPTIONS(description='Number saved for the column Ambient'),
bulk BIGNUMERIC(38,2) OPTIONS(description='Number saved for the column Bulk'),
nf BIGNUMERIC(38,2) OPTIONS(description='Number saved for the column Ambient'),
relocations BIGNUMERIC(38,2) OPTIONS(description='Number saved for the column Relocations'),
others BIGNUMERIC(38,2) OPTIONS(description='Number saved for the column Others'),
comment STRING(500) OPTIONS(description='Entered comment (optional, may be null)'),
unblocking_fg BOOL OPTIONS(description='Displays if a Leftover Pallet is inactive /greyed out'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, id, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='ALMA - This table saves all leftover pallet records');