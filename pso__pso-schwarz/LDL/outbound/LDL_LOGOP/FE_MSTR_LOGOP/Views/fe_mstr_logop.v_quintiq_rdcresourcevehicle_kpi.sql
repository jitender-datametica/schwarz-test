/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_rdcresourcevehicle_kpi
Description		|	QUINTIQ - view with final KPIs for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_rdcresourcevehicle_kpi (client_id
OPTIONS(description='Client id - calculated based on the country code'), lidl_country
OPTIONS(description='Country code. Original field name bic_zmlila'), source_system OPTIONS(description='Source system'),
wh_id OPTIONS(description='Warehouse ID'), day_of_week OPTIONS(description='Day of the week this resource is for'),
earliest_start_tm OPTIONS(description='First time moment of the selected days it can be used'), vehicle_height
OPTIONS(description='Height of vehicle (translated into a property in LP). Only applicable for Resource of ResourceType.HasContentsState = true. '),
resource_id OPTIONS(description='Unique identifier'), electric_fg
OPTIONS(description='Indicator if the vehicle is electric. Only applicable for Resource of ResourceType.CanReposition = true.'),
oneway_allowed_fg
OPTIONS(description='Trips are allowed to end at other addresses than RDC. (allowed locations in table)'),
optim_restricted_fg
OPTIONS(description='Indicator if a route with the resource mounted may be changed by the optimizer'), soft_delete_fg
OPTIONS(description='Used for soft delete'), resource_length OPTIONS(description='Length of the resource'), battery_cap
OPTIONS(description='Capacity of the vehicle battery in Kw (only applicable when IsElectric = true)'),
max_pallet_pos_cnt OPTIONS(description='Maximum nr of pallet positions'), max_load_weight_qty
OPTIONS(description='Maximum weight to be loaded on vehicle'), max_drive_dist
OPTIONS(description='Maximum distance a vehicle can drive. Only applicable for Resource of ResourceType.CanReposition = true.'),
max_time OPTIONS(description='The maximum duration of this resource'), load_oneway_allowed_fg
OPTIONS(description='Indicates whether it is allowed that this resource ends at a different end point than the RDC while it still hasshipments loaded onto it. Only applicable for Resource of ResourceType.HasContentsState = true.'),
resource_name OPTIONS(description='Unique name of the resource'), walls_red_cap_cnt
OPTIONS(description='When using at least this amount of walls then the number of available pallet positions is reduced. Only applicable for Resource of ResourceType.HasContentsState = true.'),
shift_allowed_cnt OPTIONS(description='Indicateds how many drivers shifts are allowed on the resource '), sep_walls_cnt
OPTIONS(description='Number of seperating walls on the vehicle (always 1 for 3 vaporizers). Only applicable for Resource of ResourceType.HasContentsState = true.'),
vap_cnt
OPTIONS(description='Number of vaporizers available on the vehicle/ Only applicable for Resource of ResourceType.HasContentsState = true.'),
drivers_cnt
OPTIONS(description='Defines how many drivers are a the resource concurrently. Only applicable for Resource of ResourceType.CanReposition = true.'),
stops_nocost_cnt OPTIONS(description='The number of stops for which the additional cost for the stops does not apply'),
toll_cat_nr
OPTIONS(description='Toll category applicable to the resource. Only applicable for Resource of ResourceType.CanReposition = true.'),
red_cap_cnt
OPTIONS(description='Number of pallet positions that are lost when the number of walls that are used is ≥ NrOfWallsThatReducedCapacity1. Only applicable for Resource of ResourceType.HasContentsState = true.'),
empty_resource_weight OPTIONS(description='Weight of the empty resource'), resource_width
OPTIONS(description='Width of vehicle (translated into a property in LP). Only applicable for Resource of ResourceType.HasContentsState = true.'),
factor_load_unload_time
OPTIONS(description='Factor to multiply the Address FixedLoadingTime and FixedUnloadingTime with when this resource is used. In case no value is available a value of 1 needs to be submitted.'),
has_lift_fg
OPTIONS(description='Indicates whether a vehicle has unloading equipment such as tail lift scissor lift (translated into a property in LP). Only applicable for Resource of ResourceType.HasContentsState = true.'),
hasnolicenseplateoverlap
OPTIONS(description='True (not violated) if no RDC resource vehicle has the same license plate selected for the same day excluding empty strings'),
hasuniquedefinitionperweekday
OPTIONS(description='True (not violated) if there are no RDCGlobalParameter objects that cover any of the same days of the week as this object'),
isspeedprofileavailable
OPTIONS(description='TRUE if all master time intervals that have day of week overlapping with this RDC resource contain a resource type time inteval'),
issubcontractoravailable
OPTIONS(description='TRUE if there exists an haulier with IsSubcontractor = true has the same subcontractor id of this rdc resource'),
trailerconsumption OPTIONS(description='Fuel/Energy consumption of a trailer'), drivingdrivetype
OPTIONS(description='Drive type of a motor vehicle'), trailerdrivetype OPTIONS(description='Drive type of a trailer'),
maxcapacity1converted OPTIONS(description='The converted maximum capacity (for quantity1) for this resource'), isdummy
OPTIONS(description='True if this resource is considered dummy for planning and excluded from KPI calculations'),
drivingconsumption OPTIONS(description='Fuel/Energy consumption of a motor vehicle'), dwh_load_id
OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted'), active_fg
OPTIONS(description='FLAG IF RECORD IS ACTIVE')) OPTIONS(DESCRIPTION = `QUINTIQ - PREPARED VIEW ON RAW DATA`) AS SELECT
 client_id,
 lidl_country,
 source_system,
 wh_id,
 day_of_week,
 earliest_start_tm,
 vehicle_height,
 resource_id,
 electric_fg,
 oneway_allowed_fg,
 optim_restricted_fg,
 soft_delete_fg,
 resource_length,
 battery_cap,
 max_pallet_pos_cnt,
 max_load_weight_qty,
 max_drive_dist,
 max_time,
 load_oneway_allowed_fg,
 resource_name,
 walls_red_cap_cnt,
 shift_allowed_cnt,
 sep_walls_cnt,
 vap_cnt,
 drivers_cnt,
 stops_nocost_cnt,
 toll_cat_nr,
 red_cap_cnt,
 empty_resource_weight,
 resource_width,
 factor_load_unload_time,
 has_lift_fg,
 hasnolicenseplateoverlap,
 hasuniquedefinitionperweekday,
 isspeedprofileavailable,
 issubcontractoravailable,
 trailerconsumption,
 drivingdrivetype,
 trailerdrivetype,
 maxcapacity1converted,
 isdummy,
 drivingconsumption,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 IF(dwh_valid_to = SAFE_CAST('9999-12-30' as DATE), 1, 0) AS active_fg
FROM ldl_logop_fe_mstr_logop.v_quintiq_rdcresourcevehicle;