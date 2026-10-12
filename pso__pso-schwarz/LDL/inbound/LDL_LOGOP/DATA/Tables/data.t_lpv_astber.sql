/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lpv_astber
Description		|	LPV source table
====================================================================================================
*/

CREATE TABLE DATA.t_lpv_astber (
	client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code', 
	lidl_country 			VARCHAR(3) 		NOT NULL 	COMMENT 'Country code. Original field name bic_zmlila', 
	source_system 			VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id 					NUMBER(38,0) 	NOT NULL	COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)',
	article_nr				VARCHAR(20)		NOT NULL	COMMENT 'Article number. FК: References LPV.AST.ANR. Original name - anr',
	area_nr                 NUMBER(38,0)    NOT NULL	COMMENT 'Number of the configured area. FК: References LPV.BEREICH.NR. Original name - bereich',
	fixbin_id               VARCHAR(11)     NULL		COMMENT 'Location that is set as the picking location (internal location ID). FК: References LPV.WHX.ORT. Original name - fixort1',
	change_tmsp        		TIMESTAMP	    NULL		COMMENT 'Time stamp of the record creation.19000101000000 if the record was created automatically in response to a WMI telegram. Original name - anlagezeit',
	creation_computer_id    VARCHAR(15)     NULL		COMMENT 'ID of the computer used to create the record. Empty if the record was created in response to a WMI telegram. Original name - anlagerechnerid',
	dwh_load_id    			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created    			TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated    			TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 			DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to   			DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg     			BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, article_nr, area_nr, dwh_valid_from)
) COMMENT = 'LPV - This table saves article picking locations for articles.'
;