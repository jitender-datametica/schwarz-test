/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_reportedaddressstate
Description		|	QUINTIQ table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_quintiq_reportedaddressstate (
client_id 	   				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code',
lidl_country   				VARCHAR(3)   	NOT NULL 	COMMENT 'Country code. Original field name bic_zmlila',
source_system  				VARCHAR(30)  	NOT NULL 	COMMENT 'Source system',
wh_id 		   				VARCHAR(5)   	NOT NULL 	COMMENT 'Warehouse ID',
pallet_pos_additional_dist  NUMBER(38,10) 	NULL 	 	COMMENT 'The additional distance per pallet positions that had to be travelled to visit this address during the considered tour',
address_id 					VARCHAR(512)  	NOT NULL 	COMMENT 'Stores the address ID',
calendar_week 				NUMBER(38,0)  	NULL 	 	COMMENT 'CalendarWeek',
delivery_dt 				DATE  		  	NOT NULL 	COMMENT 'End of the delivery day to optimize for (max 24hrs after start).',
oneway_fg 					BOOLEAN 	  	NULL 	 	COMMENT 'The address state where the resources are dismounted for one way tours',
temp_fg 					BOOLEAN       	NULL     	COMMENT 'Indicates if this is a temporary reported address state',
pallet_pos_dlv_cnt 			NUMBER(38,10) 	NULL 	 	COMMENT 'This calculates the number of pallet positions that is delivered to an address during a tour',
tour_dist_without_addr 		NUMBER(38,10) 	NULL 	 	COMMENT 'The resulting tour distance if the considered address was not part of the tour',
reportedtourgid				VARCHAR(512)  	NOT NULL 	COMMENT 'GID of the reported tour',
reportedtourid				VARCHAR(512)  	NULL 	 	COMMENT 'ID of the reported tour',
arrivalactualtelematics		TIMESTAMP  		NULL 	 	COMMENT 'Actual arrival time at this address, received from Telematics',
arrivalestimatedtelematics	TIMESTAMP  		NULL 	 	COMMENT 'Estimated arrival time at this address, received from Telematics',
departureactualtelematics	TIMESTAMP  		NULL 	 	COMMENT 'Actual departure time at this address, received from Telematics',
dwh_load_id    				NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created    				TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated    				TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
dwh_valid_from 				DATE 			NOT NULL 	COMMENT 'Valid from date',
dwh_valid_to   				DATE 			NOT NULL 	COMMENT 'Valid to date',
deleted_fg     				BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id,wh_id,address_id,reportedtourgid,delivery_dt,dwh_valid_from)
) COMMENT = 'AddressStates that belong to tours and routes that are reported AddressStates contains all actions within the same sequence at a certain address';