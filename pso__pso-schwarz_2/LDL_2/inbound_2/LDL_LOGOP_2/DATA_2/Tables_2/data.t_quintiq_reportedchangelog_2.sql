/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedchangelog_2
Description		|	QUINTIQ table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_quintiq_reportedchangelog_2 (
client_id 	   					NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code',
lidl_country   					VARCHAR(3)   	NOT NULL 	COMMENT 'Country_2 code. Original field name bic_zmlila',
source_system  					VARCHAR(30)  	NOT NULL 	COMMENT 'Source system',
wh_id 		   					VARCHAR(5)   	NOT NULL 	COMMENT 'Warehouse ID',
changed_attr   					VARCHAR(512) 	NOT NULL 	COMMENT 'attribute which has been changed',
change_tmsp    					TIMESTAMP    	NOT NULL 	COMMENT 'date and time user have made change',
delivery_dt    					DATE		 	NULL	 	COMMENT 'End of the delivery day to optimize for (max 24hrs after start).',
new_val 	   					VARCHAR(512) 	NULL 	 	COMMENT 'new value of attribute',
old_val 	   					VARCHAR(512) 	NULL 	 	COMMENT 'old value of attribute',
change_reason  					VARCHAR(512) 	NULL 	 	COMMENT 'reason to change the value',
route_gid	   					VARCHAR(512) 	NULL 	 	COMMENT 'GID is to have a unique identifier of a Route across different delivery days for the same RDC.',
tour_gid       					VARCHAR(512) 	NOT NULL 	COMMENT 'GID is to have a unique identifier of a tour_2 across different delivery days for the same RDC.',
user_name      					VARCHAR(512) 	NULL 	 	COMMENT 'user name',
haschangeswhilestatusclosed		BOOLEAN			NULL		COMMENT 'True if status_2 closed is all other statuses false',
changedobject       			VARCHAR(512) 	NULL 		COMMENT 'The name of the object that was changed',
changedobjectid    				VARCHAR(512) 	NULL 		COMMENT 'The ID of the object that has been changed',
hauliername 					VARCHAR(512) 	NULL 		COMMENT 'The name of the haulier, which is set when a tour_2 was changed',
dwh_load_id    					NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created    					TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated    					TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
dwh_valid_from 					DATE 			NOT NULL 	COMMENT 'Valid from date',
dwh_valid_to   					DATE 			NOT NULL 	COMMENT 'Valid to date',
deleted_fg     					BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id,wh_id,tour_gid,change_tmsp,changed_attr,dwh_valid_from)
)COMMENT='The object ReportedChangeLog in the RDCMatrix dataset gathers all relevant data for this object from the ChangeLog objects in the RDCDay dataset.';
