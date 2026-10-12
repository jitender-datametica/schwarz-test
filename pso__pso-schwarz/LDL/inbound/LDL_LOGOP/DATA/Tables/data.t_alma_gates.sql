/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB view			|	t_alma_gates
Description		|	ALMA table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_alma_gates (
	client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code', 
	lidl_country 			VARCHAR(3) 		NOT NULL 	COMMENT 'Country code. Original field name bic_zmlila', 
	source_system 			VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id 					NUMBER(38,0) 	NOT NULL	COMMENT 'wh_nr as a digit Source warehouse number (datastore_data:lagernummer)',
	gate_id					NUMBER(38,0)	NOT NULL    COMMENT 'Primary Key',
	gateuu_id               VARCHAR(50)     NULL    	COMMENT 'Default SYS_GUID. Used by the ALMA webservice',
	label                   VARCHAR(200)    NULL    	COMMENT 'Label of the gate',
	allocation_state_id     NUMBER(38,0)    NULL    	COMMENT 'Status ID from T1211_ALLOCATIONSTATES',
	task_id                 NUMBER(38,0)    NULL    	COMMENT 'eGIN task ID if the gate has been blocked during gate calculation.',
	tour_id                 NUMBER(38,0)    NULL    	COMMENT 'TPP tour ID if the gate has been blocked automatically by tour status.',
	blocked_by_tour         NUMBER(38,0)    NULL    	COMMENT 'Manually unblocking an automatic tour block sets this field to 0 effectively releasing the gate block. Prevents the same tour from re-blocking.',
	info                    VARCHAR(200)    NULL    	COMMENT 'Comment that is displayed in the application with the gate block.',
	update_user             VARCHAR(50)     NULL    	COMMENT 'Username of the user who changed the gate status last.',
	update_tmsp		        TIMESTAMP       NULL    	COMMENT 'Time of the last status change.',
	temperature_id          NUMBER(38,0)    NULL    	COMMENT 'Was required for the WAMAS Areas',
	next_gate               VARCHAR(50)     NULL    	COMMENT 'Gives the order of the Gates',
	gi_overlapping          NUMBER(38,0)    NULL    	COMMENT 'Decides the direction an overlapping assignment is possible. By default the value is 0.',
	gr_overlapping          NUMBER(38,0)    NULL    	COMMENT 'Decides the direction an overlapping assignment is possible. By default the value is 0.',
	area_id                 NUMBER(38,0)    NULL    	COMMENT 'Refers to the Table T1240_AREAS',
	dwh_load_id    			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created    			TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated    			TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 			DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to   			DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg     			BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, gate_id, dwh_valid_from)
) COMMENT = 'ALMA - The table contains basic gate definition data (warehouse modelling master data)'
;