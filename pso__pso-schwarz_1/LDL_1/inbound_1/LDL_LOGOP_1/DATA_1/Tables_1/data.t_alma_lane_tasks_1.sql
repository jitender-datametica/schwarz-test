/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB view			|	t_alma_lane_tasks_1
Description		|	ALMA table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_alma_lane_tasks_1 (
	client_id     	NUMBER(38,0)  	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code',
	lidl_country  	VARCHAR(3) 		NOT NULL 	COMMENT 'Country_1 code. Original field name bic_zmlila',
	source_system 	VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id 			NUMBER(38,0) 	NOT NULL	COMMENT 'wh_nr as a digit Source warehouse number (datastore_data:lagernummer)',
	lane_id 	  	NUMBER(38,0) 	NOT NULL 	COMMENT 'ID of the lane',
	task_id 	  	NUMBER(38,0) 	NOT NULL 	COMMENT 'eGIN task ID',
	gr_allocation 	NUMBER(38,0) 	NULL 		COMMENT 'Default 0. Type of eGIN Task Assignment.',
	update_tmsp   	TIMESTAMP    	NULL 		COMMENT 'Shows the Timestamp',
	dwh_load_id    	NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created    	TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated    	TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 	DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to   	DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg     	BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, lane_id, task_id, dwh_valid_from)
) COMMENT = 'ALMA - This table saves all eGIN tasks assigned to lanes for the GR process.'
;