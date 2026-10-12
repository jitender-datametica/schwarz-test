/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_niohistory_2
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE DATA.t_sapewm_niohistory_2 (
	client_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code', 
	lidl_country 		VARCHAR(3) 		NOT NULL 	COMMENT 'Country_2 code. Original field name bic_zmlila', 
	source_system 		VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id				NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number',
	mandt				VARCHAR(3)		NULL		COMMENT 'Client',
	lgnum               VARCHAR(5)      NOT NULL    COMMENT 'Warehouse Number/Warehouse Complex',
	huident             VARCHAR(20)     NOT NULL    COMMENT 'Handling Unit_2 Identification',
	log_seq             NUMBER(38,0)    NOT NULL    COMMENT 'Log Sequence',
	cp                  VARCHAR(18)     NULL        COMMENT 'Communication_2 Point for Conveyor Technique',
	utc_timestamp       TIMESTAMP       NULL        COMMENT 'UTC Time Stamp in Short Form (YYYYMMDDhhmmss)',
	hu_status           VARCHAR(5)      NULL        COMMENT 'Object Status_2',
	hu_status_short     VARCHAR(4)      NULL        COMMENT 'Individual status_2 of an object (short form)',
	hu_status_text      VARCHAR(30)     NULL        COMMENT 'Object status_2',
	matnr      			VARCHAR(40)     NULL        COMMENT 'Product',
    maktx      			VARCHAR(40)     NULL        COMMENT 'Product Short Description',
	dwh_load_id    		NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created    		TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated    		TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 		DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to   		DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg     		BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, lgnum, log_seq, huident, dwh_valid_from)
) COMMENT = 'SAP EWM - NIO History'
;