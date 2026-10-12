/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_stagingdimacell
Description		|	QUINTIQ table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_quintiq_stagingdimacell (
client_id 			NUMBER(38,0) 	NOT NULL	COMMENT 'Client id - calculated based on the country code',
lidl_country 		VARCHAR(3) 		NOT NULL	COMMENT 'Country code. Original field name bic_zmlila',
source_system 		VARCHAR(30) 	NOT NULL	COMMENT 'Source system',
wh_id 				VARCHAR(5) 		NOT NULL	COMMENT 'Warehouse ID',
src_tgt_dist 		NUMBER(38,10) 	NULL		COMMENT 'Distance from origin to destination address (disregard UOM)',
src_tgt_dur 		NUMBER(38,0) 	NULL		COMMENT 'Duration from origin to destionation address (In Minutes) - Imported',
src_address_id 		VARCHAR(512) 	NOT NULL	COMMENT 'Identifier of the origin address',
resource_type_id 	VARCHAR(512) 	NOT NULL	COMMENT 'The identifier for resource type',
time_profile_id 	VARCHAR(512) 	NOT NULL	COMMENT 'Identifier of time profile',
tgt_address_id 		VARCHAR(512) 	NOT NULL	COMMENT 'Identifier of the destination address',
toll_dist2 			NUMBER(38,10) 	NULL		COMMENT 'Distance for which the second type of toll is considered',
toll_dist 			NUMBER(38,10) 	NULL		COMMENT 'Distance for which first type of toll is considered',
tolldistance3		NUMBER(38,10) 	NULL		COMMENT 'Distance for which the third type of toll is considered, in kilometers',
dwh_load_id 		NUMBER(38,0) 	NOT NULL	COMMENT 'Load id',
dwh_created 		TIMESTAMP 		NOT NULL	COMMENT 'Record created at',
dwh_updated 		TIMESTAMP 		NOT NULL	COMMENT 'Record updated at',
dwh_valid_from 		DATE 			NOT NULL	COMMENT 'Valid from date',
dwh_valid_to 		DATE 			NOT NULL	COMMENT 'Valid to date',
deleted_fg 			BOOLEAN 		NOT NULL	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id,wh_id,src_address_id,tgt_address_id,resource_type_id,time_profile_id,dwh_valid_from)
) COMMENT = 'Object type in quintiq is StagingDiMaCell'; 