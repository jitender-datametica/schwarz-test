/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB view			|	t_alma_distancematrix_1
Description		|	ALMA table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_alma_distancematrix_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='wh_nr as a digit Source warehouse number (datastore_data:lagernummer)'),
matrix_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Primary Key'),
picking_bin STRING(200) OPTIONS(description='Label of the picking bin'),
gate_id BIGNUMERIC(38,0) OPTIONS(description='Gate ID from T1214_GATES_1'),
distance BIGNUMERIC(38,2) OPTIONS(description='Distance from gate to picking bin in meters'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, matrix_id, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='ALMA - The table contain distance information per Article-Location_1-Relation');