/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB view			|	t_alma_leftoverpallets
Description		|	ALMA table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_alma_leftoverpallets (
	client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code', 
	lidl_country 			VARCHAR(3) 		NOT NULL 	COMMENT 'Country code. Original field name bic_zmlila', 
	source_system 			VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id 					NUMBER(38,0) 	NOT NULL	COMMENT 'wh_nr as a digit Source warehouse number (datastore_data:lagernummer)',
	id						NUMBER(38,0)	NOT NULL 	COMMENT 'Primary Key',
	uu_id           		VARCHAR(50)     NULL 	 	COMMENT 'Default SYS_GUID() Used by the ALMA webservice',
	lane_id         		NUMBER(38,0)    NULL 	 	COMMENT 'ID of the selected lane References T1216_LANES.C1216_ID',
	store           		NUMBER(38,0)    NULL 	 	COMMENT 'Entered store number',
	ambient         		NUMBER(38,2)    NULL 	 	COMMENT 'Number saved for the column Ambient',
	bulk            		NUMBER(38,2)    NULL 	 	COMMENT 'Number saved for the column Bulk',
	nf              		NUMBER(38,2)    NULL 	 	COMMENT 'Number saved for the column Ambient',
	relocations     		NUMBER(38,2)    NULL 	 	COMMENT 'Number saved for the column Relocations',
	others          		NUMBER(38,2)    NULL 	 	COMMENT 'Number saved for the column Others',
	COMMENT	        		VARCHAR(500)    NULL 	 	COMMENT 'Entered comment (optional, may be null)',
	unblocking_fg   		BOOLEAN		    NULL 	 	COMMENT 'Displays if a Leftover Pallet is inactive /greyed out',
	dwh_load_id    			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created    			TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated    			TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 			DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to   			DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg     			BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, id, dwh_valid_from)
) COMMENT = 'ALMA - This table saves all leftover pallet records'
;