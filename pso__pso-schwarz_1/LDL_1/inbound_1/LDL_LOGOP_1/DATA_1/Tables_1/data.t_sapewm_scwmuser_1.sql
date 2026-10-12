/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_scwmuser_1
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE DATA.t_sapewm_scwmuser_1 (
	client_id 		NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code', 
	lidl_country 	VARCHAR(3) 		NOT NULL 	COMMENT 'Country_1 code. Original field name bic_zmlila', 
	source_system 	VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id			NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number',
	mandt			VARCHAR(3)  	NULL        COMMENT 'Client',
	uname           VARCHAR(12) 	NOT NULL    COMMENT 'User Name in User Master Record',
	data_entry      VARCHAR(1)  	NULL        COMMENT 'Data Entry Type',
	prsn_prf        VARCHAR(2)  	NULL        COMMENT 'Personalization Profile',
	lgnum           VARCHAR(5)		NOT NULL	COMMENT 'Warehouse Number/Warehouse Complex',
	rsrc            VARCHAR(18) 	NULL        COMMENT 'Resource (Means of Transportation or User)',
	auto_logon      BOOLEAN     	NULL        COMMENT 'Automatic Logon',
	dwh_load_id     NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created     TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated     TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from  DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to    DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg      BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, lgnum, uname, dwh_valid_from)
) COMMENT = 'SAP EWM - Resource Management Users'
;