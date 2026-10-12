/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_rdcresourcevehicle_2
Description		|	QUINTIQ table for raw data
====================================================================================================
*/

CREATE TABLE DATA.t_quintiq_rdcresourcevehicle_2 (
client_id 						NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code',
lidl_country 					VARCHAR(3) 		NOT NULL 	COMMENT 'Country_2 code. Original field name bic_zmlila',
source_system 					VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
wh_id 		   					VARCHAR(5)   	NOT NULL 	COMMENT 'Warehouse ID',
day_of_week 					VARCHAR(512) 	NOT NULL 	COMMENT 'Day of the week this resource is for',
earliest_start_tm 				VARCHAR(512)	NULL	 	COMMENT 'First time moment of the selected days it can be used',
vehicle_height 					NUMBER(38,10) 	NULL	 	COMMENT 'Height of vehicle (translated into a property in LP). Only applicable for Resource of ResourceType.HasContentsState = true. ',
resource_id 					VARCHAR(512) 	NOT NULL 	COMMENT 'Unique identifier',
electric_fg 					BOOLEAN 		NULL		COMMENT 'Indicator if the vehicle is electric. Only applicable for Resource of ResourceType.CanReposition = true.',
oneway_allowed_fg 				BOOLEAN 		NULL		COMMENT 'Trips are allowed to end at other addresses than RDC. (allowed locations in table)',
optim_restricted_fg 			BOOLEAN 		NULL		COMMENT 'Indicator if a route with the resource mounted may be changed by the optimizer',
soft_delete_fg 					BOOLEAN 		NULL		COMMENT 'Used for soft delete',
resource_length 				NUMBER(38,10) 	NULL		COMMENT 'Length of the resource',
battery_cap 					NUMBER(38,10) 	NULL		COMMENT 'Capacity of the vehicle battery in Kw (only applicable when IsElectric = true)',
max_pallet_pos_cnt 				NUMBER(38,10) 	NULL		COMMENT 'Maximum nr of pallet positions',
max_load_weight_qty 			NUMBER(38,10) 	NULL		COMMENT 'Maximum weight to be loaded on vehicle',
max_drive_dist 					NUMBER(38,10) 	NULL		COMMENT 'Maximum distance a vehicle can drive. Only applicable for Resource of ResourceType.CanReposition = true.',
max_time 						VARCHAR(512) 	NULL		COMMENT 'The maximum duration of this resource',
load_oneway_allowed_fg 			BOOLEAN 		NULL		COMMENT 'Indicates whether it is allowed that this resource ends at a different end point than the RDC while it still hasshipments loaded onto it. Only applicable for Resource of ResourceType.HasContentsState = true.',
resource_name 					VARCHAR(512) 	NULL		COMMENT 'Unique name of the resource',
walls_red_cap_cnt 				NUMBER(38,10) 	NULL		COMMENT 'When using at least this amount of walls then the number of available pallet positions is reduced. Only applicable for Resource of ResourceType.HasContentsState = true.',
shift_allowed_cnt 				NUMBER(38,10) 	NULL		COMMENT 'Indicateds how many drivers shifts are allowed on the resource ',
sep_walls_cnt 					NUMBER(38,10) 	NULL		COMMENT 'Number of seperating walls on the vehicle (always 1 for 3 vaporizers). Only applicable for Resource of ResourceType.HasContentsState = true.',
vap_cnt 						NUMBER(38,10) 	NULL		COMMENT 'Number of vaporizers available on the vehicle/ Only applicable for Resource of ResourceType.HasContentsState = true.',
drivers_cnt 					NUMBER(38,10) 	NULL		COMMENT 'Defines how many drivers are a the resource concurrently. Only applicable for Resource of ResourceType.CanReposition = true.',
stops_nocost_cnt 				NUMBER(38,10) 	NULL		COMMENT 'The number of stops for which the additional cost for the stops does not apply',
toll_cat_nr 					NUMBER(38,10) 	NULL		COMMENT 'Toll category applicable to the resource. Only applicable for Resource of ResourceType.CanReposition = true.',
red_cap_cnt 					NUMBER(38,10) 	NULL		COMMENT 'Number of pallet positions that are lost when the number of walls that are used is ≥ NrOfWallsThatReducedCapacity1. Only applicable for Resource of ResourceType.HasContentsState = true.',
empty_resource_weight 			NUMBER(38,10) 	NULL		COMMENT 'Weight of the empty resource',
resource_width 					NUMBER(38,10) 	NULL		COMMENT 'Width of vehicle (translated into a property in LP). Only applicable for Resource of ResourceType.HasContentsState = true.',
factor_load_unload_time			NUMBER(38,10) 	NULL		COMMENT 'Factor to multiply the Address_2 FixedLoadingTime and FixedUnloadingTime with when this resource is used. In case no value is available, a value of 1 needs to be submitted.',
has_lift_fg 					BOOLEAN		 	NULL		COMMENT 'Indicates whether a vehicle has unloading equipment such as tail lift, scissor lift (translated into a property in LP). Only applicable for Resource of ResourceType.HasContentsState = true.',
hasnolicenseplateoverlap		BOOLEAN			NULL		COMMENT 'True (not violated) if no RDC resource vehicle has the same license plate selected for the same day, excluding empty strings',
hasuniquedefinitionperweekday	BOOLEAN 		NULL		COMMENT 'True (not violated) if there are no RDCGlobalParameter objects that cover any of the same days of the week as this object',
isspeedprofileavailable			BOOLEAN 		NULL		COMMENT 'TRUE if all master time intervals that have day of week overlapping with this RDC resource contain a resource type time inteval',
issubcontractoravailable		BOOLEAN 		NULL		COMMENT 'TRUE if there exists an haulier with IsSubcontractor = true has the same subcontractor id of this rdc resource',
trailerconsumption				NUMBER(38,10) 	NULL		COMMENT 'Fuel/Energy consumption of a trailer',
drivingdrivetype            	VARCHAR(512) 	NULL		COMMENT 'Drive type of a motor vehicle',
trailerdrivetype            	VARCHAR(512) 	NULL		COMMENT 'Drive type of a trailer',
maxcapacity1converted       	NUMBER(38,10) 	NULL		COMMENT 'The converted maximum capacity (for quantity1) for this resource',
isdummy                     	BOOLEAN		 	NULL		COMMENT 'True if this resource is considered dummy_2 for planning and excluded from KPI calculations',
drivingconsumption          	NUMBER(38,10) 	NULL		COMMENT 'Fuel/Energy consumption of a motor vehicle',
dwh_load_id 					NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created 					TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated 					TIMESTAMP		NOT NULL 	COMMENT 'Record updated at',
dwh_valid_from 					DATE 			NOT NULL 	COMMENT 'Valid from date',
dwh_valid_to 					DATE 			NOT NULL 	COMMENT 'Valid to date',
deleted_fg 						BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id,wh_id,resource_id,day_of_week,dwh_valid_from)
) COMMENT = 'Object type in quintiq is RDCResourceVehicle';