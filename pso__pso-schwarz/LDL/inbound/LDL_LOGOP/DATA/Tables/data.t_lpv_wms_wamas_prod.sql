/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lpv_wms_wamas_prod
Description		|	LPV source table
====================================================================================================
*/

CREATE TABLE DATA.t_lpv_wms_wamas_prod (
	client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code', 
	lidl_country 			VARCHAR(3) 		NOT NULL 	COMMENT 'Country code. Original field name bic_zmlila', 
	source_system 			VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id 					NUMBER(38,0) 	NOT NULL	COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)',
	auftrag					VARCHAR(12)		NOT NULL 	COMMENT 'Task number. Original name - auftrag',
	tanr                    NUMBER(38,0)    NULL 	 	COMMENT 'Task number in WAMAS. Original name - tanr',
	status                  VARCHAR(6)      NULL 	 	COMMENT 'Task status. Original name - status',
	typ                     VARCHAR(4)      NULL 	 	COMMENT 'Task type. Original name - typ',
	artikelnr               VARCHAR(20)     NULL 	 	COMMENT 'Item number. FK: References LPV.AST.ANR. Original name - artikelnr',
	prio                    NUMBER(38,0)    NULL 	 	COMMENT 'Priority. Original name - prio',
	quelle                  VARCHAR(16)     NULL 	 	COMMENT 'N/A. Original name - quelle',
	anlagezeit              TIMESTAMP       NULL 	 	COMMENT 'Time stamp of the record creation. Original name - anlagezeit',
	aenderungskz            NUMBER(38,0)    NULL 	 	COMMENT 'Change flag. Original name - aenderungskz',
	dwh_load_id    			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created    			TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated    			TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 			DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to   			DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg     			BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, auftrag, dwh_valid_from)
) COMMENT = 'LPV - Table shows all open and active replenishment tasks and putaway tasks for non-LPV items (bulk). The data shown here is live.'
; 