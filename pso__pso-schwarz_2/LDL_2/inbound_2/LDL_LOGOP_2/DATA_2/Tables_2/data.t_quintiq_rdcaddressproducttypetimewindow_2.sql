/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_rdcaddressproducttypetimewindow_2
Description		|	QUINTIQ table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_quintiq_rdcaddressproducttypetimewindow_2 (
client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code',
lidl_country 			VARCHAR(4) 		NOT NULL 	COMMENT 'Country_2 code. Original field name bic_zmlila',
wh_id 		   			VARCHAR(5)   	NOT NULL 	COMMENT 'Warehouse ID',
addressid				VARCHAR(512)   	NOT NULL 	COMMENT 'ID of the address_2',
dayofweek               VARCHAR(512)   	NOT NULL 	COMMENT 'Day of week indicator, 67 means weekend (Saturday + Sunday) & 1 means Monday',
endtime                 VARCHAR(512)   	NULL	 	COMMENT 'Pattern: (\d+ day(s)?, )?\d+:\d\d:\d\d',
istypepreferred         BOOLEAN   		NULL	 	COMMENT 'True if this time window is a time window of type preferred',
producttypeid           VARCHAR(512)   	NOT NULL 	COMMENT 'ID of the product type',
starttime               VARCHAR(512)   	NOT NULL	COMMENT 'Pattern: (\d+ day(s)?, )?\d+:\d\d:\d\d',
dwh_load_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created 			TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated 			TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
dwh_valid_from 			DATE 			NOT NULL 	COMMENT 'Valid from date',
dwh_valid_to 			DATE 			NOT NULL 	COMMENT 'Valid to date',
deleted_fg 				BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id, wh_id, addressid, producttypeid, dayofweek, starttime, dwh_valid_from)
) COMMENT = 'Object type in quintiq is RDCAddressProductTypeTimeWindow'; 