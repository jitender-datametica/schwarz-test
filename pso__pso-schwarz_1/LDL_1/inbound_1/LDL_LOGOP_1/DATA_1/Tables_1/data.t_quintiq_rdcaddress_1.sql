/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_rdcaddress_1
Description		|	QUINTIQ table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_quintiq_rdcaddress_1 (
client_id 							NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code',
lidl_country 						VARCHAR(3) 		NOT NULL 	COMMENT 'Country_1 code. Original field name bic_zmlila',
source_system 						VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
wh_id 		   						VARCHAR(5)   	NOT NULL 	COMMENT 'Warehouse ID',
city_name 							VARCHAR(512) 	NULL		COMMENT 'City',
country_name 						VARCHAR(512) 	NULL		COMMENT 'Country_1',
day_of_week 						VARCHAR(512) 	NOT NULL 	COMMENT 'Day of the week this address_1 is for',
default_comment 					VARCHAR(512) 	NULL		COMMENT 'Default comment for any address_1 states for this address_1',
end_open_tm 						VARCHAR(512) 	NULL		COMMENT 'End of the opening hours ',
extra_info 							VARCHAR(512) 	NULL		COMMENT 'Free text field to fill external information',
has_ramp_fg 						BOOLEAN 	 	NULL		COMMENT 'Indicates whether a ramp is available at the address_1',
house_nr 							VARCHAR(512) 	NULL		COMMENT 'HouseNumber',
address_id 							VARCHAR(512) 	NOT NULL 	COMMENT 'ID of the address_1/store',
soft_delete_fg 						BOOLEAN 	 	NULL		COMMENT 'Used for soft delete',
special_store_fg 					BOOLEAN 	 	NULL		COMMENT 'TRUE if this address_1 is a special stores that require different delivery handling',
store_fg 							BOOLEAN 	 	NULL		COMMENT 'Indicates whether the address_1 is a store',
dismount_allowed_fg 				BOOLEAN 	 	NULL		COMMENT 'Indicates whether at this location_1 a resource can be left behind - Phase 2',
unman_deliv_allowed_fg 				BOOLEAN 	 	NULL		COMMENT 'Indicator of an unmanned delivery is allowed',
address_long_name 					VARCHAR(512) 	NULL		COMMENT 'Full name of an address_1',
address_name 						VARCHAR(512) 	NULL		COMMENT 'Name of the address_1/store',
post_code 							VARCHAR(512) 	NULL		COMMENT 'PostCode',
start_open_tm 						VARCHAR(512) 	NULL		COMMENT 'Start of the opening hours',
state 								VARCHAR(512) 	NULL		COMMENT 'State',
street_name 						VARCHAR(512) 	NULL		COMMENT 'Street',
max_length							NUMBER(38,10)	NULL		COMMENT 'The maximum length a resource set is allowed to have to visit this address.',
max_predelivered_cnt				NUMBER(38,10)	NULL		COMMENT 'Maximum number of pallets that can be delivered early per store',
max_undelivered_cnt					NUMBER(38,10)	NULL		COMMENT 'Maximum number of pallets that can be delivered late per store',
location_lat						NUMBER(38,10)	NULL		COMMENT 'The geographical location.',
location_lon						NUMBER(38,10)	NULL		COMMENT 'The geographical location.',
location_x							NUMBER(38,10)	NULL		COMMENT 'X value for the location_1 Object',
location_y							NUMBER(38,10)	NULL		COMMENT 'Y value for the location_1 Object',
location_y_user						NUMBER(38,10)	NULL		COMMENT 'Y value for the location_1 Object',
vehicles_unmanned_delivery_max_cnt	NUMBER(38,0)	NULL		COMMENT 'Number of different vehicles allowed (models number of keys)',
stops_per_delivery_day_user_max_cnt	NUMBER(38,0)	NULL		COMMENT 'Number of stops that are allowed for one store per delivery day set by a User',
max_weight							NUMBER(38,10)	NULL		COMMENT 'Maximum weight of a truck that can park/approach the store.',
docks_max_cnt						NUMBER(38,0)	NULL		COMMENT 'Maximum number of (un)loads allowed at the same time',
max_width							NUMBER(38,10)	NULL		COMMENT 'The maximum width a resource set is allowed to have to visit this address.',
pre_action_duration					VARCHAR(512)	NULL		COMMENT 'Fixed (un)loading time in seconds when loading is done at an address_1',
pre_action_duration_unloading		VARCHAR(512)	NULL		COMMENT 'Fixed (un)loading time when unloading is done at an RDC only',
additionaladdressinfo				VARCHAR(512)	NULL		COMMENT 'Additional information for the Address_1 set by the user e.g. tax number',
hasuniquedefinitionperweekday       BOOLEAN         NULL		COMMENT 'True (not violated) if there are no RDCGlobalParameter objects that cover any of the same days of the week as this object',
isaddressindicatoravailable         BOOLEAN         NULL		COMMENT 'TRUE if there is indicator related to this rdc address_1',
isclusteravailable                  BOOLEAN         NULL		COMMENT 'TRUE if there is cluster related to this rdc address_1',
nicplacestoreid                     NUMBER(38,0)    NULL		COMMENT 'Presents which alert rules NicCompartment needs to apply when travelling to that address.',
isemissionfree						BOOLEAN			NULL		COMMENT 'TRUE if only emission free deliveries are allowed on this address_1',
isexternalwarehouse					BOOLEAN			NULL		COMMENT 'TRUE if this is an external warehouse',
isinternalwarehouse					BOOLEAN			NULL		COMMENT 'TRUE if this is an internal warehouse',
isnonfoodwarehouse					BOOLEAN			NULL		COMMENT 'TRUE if this is a non food warehouse',
dwh_load_id 						NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created 						TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated 						TIMESTAMP		NOT NULL 	COMMENT 'Record updated at',
dwh_valid_from 						DATE 			NOT NULL 	COMMENT 'Valid from date',
dwh_valid_to 						DATE 			NOT NULL 	COMMENT 'Valid to date',
deleted_fg 							BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id,wh_id,address_id,day_of_week,dwh_valid_from)
) COMMENT = 'Object type in quintiq is RDCAddress';
