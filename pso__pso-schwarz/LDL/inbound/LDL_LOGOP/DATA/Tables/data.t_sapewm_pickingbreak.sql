/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_pickingbreak
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE DATA.t_sapewm_pickingbreak (
    client_id 		NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code', 
	lidl_country 	VARCHAR(3) 		NOT NULL 	COMMENT 'Country code. Original field name bic_zmlila', 
	source_system 	VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id			NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number',
	mandt			VARCHAR(5)		NULL 		COMMENT 'Client of the EWM system',
	lgnum           VARCHAR(5)		NOT NULL 	COMMENT 'Warehouse Number/Warehouse Complex',
	created_by      VARCHAR(12)     NOT NULL 	COMMENT 'Created By',
	start_date      DATE            NOT NULL 	COMMENT 'Start Date',
	start_time      TIME(0)         NOT NULL 	COMMENT 'Start Time',
	start_tstamp    TIMESTAMP       NULL 		COMMENT 'UTC Time Stamp in Short Form (YYYYMMDDhhmmss)',
	end_date        DATE            NULL 		COMMENT 'End Date',
	end_time        TIME(0)         NULL 		COMMENT 'End Time',
	end_tstamp      TIMESTAMP       NULL 		COMMENT 'UTC Time Stamp in Short Form (YYYYMMDDhhmmss)',
	duration        NUMBER(38,3)    NULL 		COMMENT 'Planned Duration',
	unit_t          VARCHAR(5)      NULL 		COMMENT 'Time Unit',
	who             NUMBER(38,0)    NOT NULL 	COMMENT 'Warehouse Order Number',
	dwh_load_id 	NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created		TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated		TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	PRIMARY KEY (client_id, lgnum, who, created_by, start_date, start_time)
) COMMENT = 'SAP EWM - Picking Break in RF'
;