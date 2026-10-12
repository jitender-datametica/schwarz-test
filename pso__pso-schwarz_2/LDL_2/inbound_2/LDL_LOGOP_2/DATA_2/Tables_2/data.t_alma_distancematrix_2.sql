/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB view			|	t_alma_distancematrix_2
Description		|	ALMA table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_alma_distancematrix_2 (
	client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code', 
	lidl_country 			VARCHAR(3) 		NOT NULL 	COMMENT 'Country_2 code. Original field name bic_zmlila', 
	source_system 			VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id 					NUMBER(38,0) 	NOT NULL	COMMENT 'wh_nr as a digit Source warehouse number (datastore_data:lagernummer)',
	matrix_id				NUMBER(38,0)	NOT NULL    COMMENT 'Primary Key',
	picking_bin             VARCHAR(200)    NULL    	COMMENT 'Label of the picking bin',
	gate_id                 NUMBER(38,0)    NULL    	COMMENT 'Gate ID from T1214_GATES_2',
	distance     			NUMBER(38,2)    NULL    	COMMENT 'Distance from gate to picking bin in meters',
	dwh_load_id    			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created    			TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated    			TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 			DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to   			DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg     			BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, matrix_id, dwh_valid_from)
) COMMENT = 'ALMA - The table contain distance information per Article-Location_2-Relation'
;