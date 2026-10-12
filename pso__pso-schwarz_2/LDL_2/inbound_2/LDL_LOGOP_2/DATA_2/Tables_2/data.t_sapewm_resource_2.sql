/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_resource_2
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE DATA.t_sapewm_resource_2 (
	client_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code', 
	lidl_country 		VARCHAR(3) 		NOT NULL 	COMMENT 'Country_2 code. Original field name bic_zmlila', 
	source_system 		VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id				NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number',
	lgnum				VARCHAR(5)		NOT NULL	COMMENT 'Warehouse Number/Warehouse Complex',
	rsrc                VARCHAR(18)     NOT NULL    COMMENT 'Resource (Means of Transportation or User)',
	rsrc_type           VARCHAR(4)      NULL        COMMENT 'Resource Type',
	rsrc_grp            VARCHAR(4)      NULL        COMMENT 'Resource Group',
	def_prdvc           VARCHAR(4)      NULL        COMMENT 'Default Presentation Device',
	uname               VARCHAR(12)     NULL        COMMENT 'User Name',
	rfind               VARCHAR(1)      NULL        COMMENT 'RF Execution Environment',
	QUEUE               VARCHAR(10)     NULL        COMMENT 'Queue',
	act_queue           VARCHAR(10)     NULL        COMMENT 'Actual Queue of Resource',
	lgtyp               VARCHAR(4)      NULL        COMMENT 'Storage Type of Last Removal',
	logon_date          DATE            NULL        COMMENT 'Logon Date on RF',
	logon_time          TIME(0)         NULL        COMMENT 'Logon Time on RF',
	cur_prdvc           VARCHAR(4)      NULL        COMMENT 'Current Presentation Device',
	applic              VARCHAR(2)      NULL        COMMENT 'Application',
	ltrans              VARCHAR(6)      NULL        COMMENT 'Logical Transaction',
	ltranschg_date      DATE            NULL        COMMENT 'Date of Logical Transaction Change in RF',
	ltranschg_time      TIME(0)         NULL        COMMENT 'Time of Logical Transaction Change in RF',
	default_bin         VARCHAR(18)     NULL        COMMENT 'Standard Storage Bin of a Resource',
	actual_bin          VARCHAR(18)     NULL        COMMENT 'Current Storage Bin of a Resource',
	zz_locked           BOOLEAN         NULL        COMMENT 'Lock Resource (X Yes,   No)',
	dwh_load_id    		NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created    		TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated    		TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 		DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to   		DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg     		BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, lgnum, rsrc, dwh_valid_from)
) COMMENT = 'SAP EWM - Resource for WM_2 Monitor Output'
;