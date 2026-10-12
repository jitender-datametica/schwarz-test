/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB view			|	t_alma_lanes_2
Description		|	ALMA table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_alma_lanes_2 (
	client_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code',
	lidl_country 		VARCHAR(3) 		NOT NULL 	COMMENT 'Country_2 code. Original field name bic_zmlila',
	source_system 		VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id 				NUMBER(38,0) 	NOT NULL	COMMENT 'wh_nr as a digit Source warehouse number (datastore_data:lagernummer)',		
	lane_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Primary Key',
	gate_id 			NUMBER(38,0) 	NULL		COMMENT 'Gate ID from T1214_GATES_2',
	label 				VARCHAR(200) 	NULL		COMMENT 'Label of the lane visible in the application.',
	allocation_state_id NUMBER(38,0) 	NULL		COMMENT 'Status_2 ID from T1211_ALLOCATIONSTATES',
	update_user 		VARCHAR(50) 	NULL		COMMENT 'The user who changed the record last. \"ALMA\" after initial master data load.',
	update_tmsp			TIMESTAMP 		NULL		COMMENT 'Timestamp of the import for last change.',
	next_lane_id 		VARCHAR(200) 	NULL		COMMENT 'ID of the next displayed lane according to the current lane ordering. NULL if the record represents the gate''s last lane.',
	info 				VARCHAR(500) 	NULL		COMMENT 'Lane comment.',
	gr_capacity 		NUMBER(38,0) 	NULL		COMMENT 'Lane capacity used for all GR processes (Gate Calculation)',
	gi_capacity 		NUMBER(38,0) 	NULL		COMMENT 'Lane capacity used for all GI processes',
	laneuu_id 			VARCHAR(50) 	NULL		COMMENT 'Default SYS_GUID() - Used by the ALMA webservice',
	tour_id 			NUMBER(38,0) 	NULL		COMMENT 'ID of the last TPP tour_2 that blocked this lane.',
	blocked_by_tour 	NUMBER(38,0) 	NULL		COMMENT 'Whether the lane is currently blocked by the GI process.',
	next_lane 			VARCHAR(50) 	NULL		COMMENT 'Gives the order of the Lane',	
	dwh_load_id 		NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created 		TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated 		TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 		DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to 		DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg 			BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, lane_id, dwh_valid_from)
) COMMENT = 'ALMA - The table contains all lane definition data (warehouse modelling master data).'
;