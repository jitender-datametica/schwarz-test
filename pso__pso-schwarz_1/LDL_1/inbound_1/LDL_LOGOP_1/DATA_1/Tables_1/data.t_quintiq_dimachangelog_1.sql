/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_dimachangelog_1
Description		|	QUINTIQ table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_quintiq_dimachangelog_1 (
client_id 	   NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code',
lidl_country   VARCHAR(3)   	NOT NULL 	COMMENT 'Country_1 code. Original field name bic_zmlila',
source_system  VARCHAR(30)  	NOT NULL 	COMMENT 'Source system',
wh_id 		   VARCHAR(5)   	NOT NULL 	COMMENT 'Warehouse ID',
changed_attr   VARCHAR(512) 	NOT NULL	COMMENT 'The attribute that was changed',
change_tmsp    TIMESTAMP    	NULL		COMMENT 'Time when the ok button was pressed to trigger the change',
change_id 	   VARCHAR(512) 	NOT NULL	COMMENT 'Combination of AddressFrom, To, ResourceType and timeProfile',
new_val 	   VARCHAR(512) 	NULL 		COMMENT 'The new value of the attribute',
old_val 	   VARCHAR(512) 	NULL 		COMMENT 'The old value of the attribute',
user_nr 	   VARCHAR(512) 	NULL 		COMMENT 'Employee_1 number of the user that made the change',
changedobject  VARCHAR(512) 	NULL 		COMMENT 'The name of the object that was changed (StagingDiMaCell or StagingTollCell)',
datasetname    VARCHAR(512) 	NULL 		COMMENT 'The name of the dataset where this change occured',
reason		   VARCHAR(512) 	NULL 		COMMENT 'The given reason for this DiMa change',
dwh_load_id    NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created    TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated    TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
dwh_valid_from DATE 			NOT NULL 	COMMENT 'Valid from date',
dwh_valid_to   DATE 			NOT NULL 	COMMENT 'Valid to date',
deleted_fg     BOOLEAN 			NOT NULL 	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id,wh_id,change_id,changed_attr,dwh_valid_from)
) COMMENT = 'Object type in quintiq is DiMaChangeLog Object tracking user entered changes to specific attributes';