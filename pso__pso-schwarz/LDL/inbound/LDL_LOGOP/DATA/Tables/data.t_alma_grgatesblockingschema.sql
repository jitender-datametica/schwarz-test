/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB view			|	t_alma_grgatesblockingschema
Description		|	ALMA table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_alma_grgatesblockingschema (
	client_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code',
	lidl_country 		VARCHAR(3)	 	NOT NULL 	COMMENT 'Country code. Original field name bic_zmlila',
	source_system 		VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id 				NUMBER(38,0) 	NOT NULL	COMMENT 'wh_nr as a digit Source warehouse number (datastore_data:lagernummer)',
	id 					NUMBER(38,0) 	NOT NULL 	COMMENT 'Primary Key',
	gate_id 			NUMBER(38,0) 	NULL 		COMMENT 'Gate ID from T1214_GATES',
	time_windows 		VARIANT		 	NULL 		COMMENT 'Beginning of the time window in microseconds',
	COMMENT 			VARCHAR(20) 	NULL 		COMMENT 'Comment',
	dwh_load_id 		NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created 		TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated 		TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 		DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to 		DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg 			BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, id, dwh_valid_from)
) COMMENT = 'ALMA - This table saves time windows during which gates can only be used by the GR process.'
;