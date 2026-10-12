/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_quintiq_rdcresourcevehicle
Description		|	QUINTIQ table for raw data
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_quintiq_rdcresourcevehicle (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id STRING(5) NOT NULL OPTIONS(description='Warehouse ID'),
day_of_week STRING(512) NOT NULL OPTIONS(description='Day of the week this resource is for'),
earliest_start_tm STRING(512) OPTIONS(description='First time moment of the selected days it can be used'),
vehicle_height BIGNUMERIC(38,10)
OPTIONS(description='Height of vehicle (translated into a property in LP). Only applicable for Resource of ResourceType.HasContentsState = true. '),
resource_id STRING(512) NOT NULL OPTIONS(description='Unique identifier'),
electric_fg BOOL
OPTIONS(description='Indicator if the vehicle is electric. Only applicable for Resource of ResourceType.CanReposition = true.'),
oneway_allowed_fg BOOL
OPTIONS(description='Trips are allowed to end at other addresses than RDC. (allowed locations in table)'),
optim_restricted_fg BOOL
OPTIONS(description='Indicator if a route with the resource mounted may be changed by the optimizer'),
soft_delete_fg BOOL OPTIONS(description='Used for soft delete'),
resource_length BIGNUMERIC(38,10) OPTIONS(description='Length of the resource'),
battery_cap BIGNUMERIC(38,10)
OPTIONS(description='Capacity of the vehicle battery in Kw (only applicable when IsElectric = true)'),
max_pallet_pos_cnt BIGNUMERIC(38,10) OPTIONS(description='Maximum nr of pallet positions'),
max_load_weight_qty BIGNUMERIC(38,10) OPTIONS(description='Maximum weight to be loaded on vehicle'),
max_drive_dist BIGNUMERIC(38,10)
OPTIONS(description='Maximum distance a vehicle can drive. Only applicable for Resource of ResourceType.CanReposition = true.'),
max_time STRING(512) OPTIONS(description='The maximum duration of this resource'),
load_oneway_allowed_fg BOOL
OPTIONS(description='Indicates whether it is allowed that this resource ends at a different end point than the RDC while it still hasshipments loaded onto it. Only applicable for Resource of ResourceType.HasContentsState = true.'),
resource_name STRING(512) OPTIONS(description='Unique name of the resource'),
walls_red_cap_cnt BIGNUMERIC(38,10)
OPTIONS(description='When using at least this amount of walls then the number of available pallet positions is reduced. Only applicable for Resource of ResourceType.HasContentsState = true.'),
shift_allowed_cnt BIGNUMERIC(38,10)
OPTIONS(description='Indicateds how many drivers shifts are allowed on the resource '),
sep_walls_cnt BIGNUMERIC(38,10)
OPTIONS(description='Number of seperating walls on the vehicle (always 1 for 3 vaporizers). Only applicable for Resource of ResourceType.HasContentsState = true.'),
vap_cnt BIGNUMERIC(38,10)
OPTIONS(description='Number of vaporizers available on the vehicle/ Only applicable for Resource of ResourceType.HasContentsState = true.'),
drivers_cnt BIGNUMERIC(38,10)
OPTIONS(description='Defines how many drivers are a the resource concurrently. Only applicable for Resource of ResourceType.CanReposition = true.'),
stops_nocost_cnt BIGNUMERIC(38,10)
OPTIONS(description='The number of stops for which the additional cost for the stops does not apply'),
toll_cat_nr BIGNUMERIC(38,10)
OPTIONS(description='Toll category applicable to the resource. Only applicable for Resource of ResourceType.CanReposition = true.'),
red_cap_cnt BIGNUMERIC(38,10)
OPTIONS(description='Number of pallet positions that are lost when the number of walls that are used is ≥ NrOfWallsThatReducedCapacity1. Only applicable for Resource of ResourceType.HasContentsState = true.'),
empty_resource_weight BIGNUMERIC(38,10) OPTIONS(description='Weight of the empty resource'),
resource_width BIGNUMERIC(38,10)
OPTIONS(description='Width of vehicle (translated into a property in LP). Only applicable for Resource of ResourceType.HasContentsState = true.'),
factor_load_unload_time BIGNUMERIC(38,10)
OPTIONS(description='Factor to multiply the Address FixedLoadingTime and FixedUnloadingTime with when this resource is used. In case no value is available, a value of 1 needs to be submitted.'),
has_lift_fg BOOL
OPTIONS(description='Indicates whether a vehicle has unloading equipment such as tail lift, scissor lift (translated into a property in LP). Only applicable for Resource of ResourceType.HasContentsState = true.'),
hasnolicenseplateoverlap BOOL
OPTIONS(description='True (not violated) if no RDC resource vehicle has the same license plate selected for the same day, excluding empty strings'),
hasuniquedefinitionperweekday BOOL
OPTIONS(description='True (not violated) if there are no RDCGlobalParameter objects that cover any of the same days of the week as this object'),
isspeedprofileavailable BOOL
OPTIONS(description='TRUE if all master time intervals that have day of week overlapping with this RDC resource contain a resource type time inteval'),
issubcontractoravailable BOOL
OPTIONS(description='TRUE if there exists an haulier with IsSubcontractor = true has the same subcontractor id of this rdc resource'),
trailerconsumption BIGNUMERIC(38,10) OPTIONS(description='Fuel/Energy consumption of a trailer'),
drivingdrivetype STRING(512) OPTIONS(description='Drive type of a motor vehicle'),
trailerdrivetype STRING(512) OPTIONS(description='Drive type of a trailer'),
maxcapacity1converted BIGNUMERIC(38,10)
OPTIONS(description='The converted maximum capacity (for quantity1) for this resource'),
isdummy BOOL
OPTIONS(description='True if this resource is considered dummy for planning and excluded from KPI calculations'),
drivingconsumption BIGNUMERIC(38,10) OPTIONS(description='Fuel/Energy consumption of a motor vehicle'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, resource_id, day_of_week, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='Object type in quintiq is RDCResourceVehicle');