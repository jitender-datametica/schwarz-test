/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_rdcresourcevehicle_2
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_QUINTIQ_RDCRESOURCEVEHICLE_2(
   CLIENT_ID COMMENT 'Client id - calculated based on the country_2 code'
 , LIDL_COUNTRY COMMENT 'Country_2 code. Original field name bic_zmlila'
 , SOURCE_SYSTEM COMMENT 'Source system'
 , WH_ID COMMENT 'Warehouse ID'
 , DAY_OF_WEEK COMMENT 'Day of the week this resource is for'
 , EARLIEST_START_TM COMMENT 'First time moment of the selected days it can be used'
 , VEHICLE_HEIGHT COMMENT 'Height of vehicle (translated into a property in LP). Only applicable for Resource of ResourceType.HasContentsState = true. '
 , RESOURCE_ID COMMENT 'Unique identifier'
 , ELECTRIC_FG COMMENT 'Indicator if the vehicle is electric. Only applicable for Resource of ResourceType.CanReposition = true.'
 , ONEWAY_ALLOWED_FG COMMENT 'Trips are allowed to end at other addresses than RDC. (allowed locations in table)'
 , OPTIM_RESTRICTED_FG COMMENT 'Indicator if a route with the resource mounted may be changed by the optimizer'
 , SOFT_DELETE_FG COMMENT 'Used for soft delete'
 , RESOURCE_LENGTH COMMENT 'Length of the resource'
 , BATTERY_CAP COMMENT 'Capacity of the vehicle battery in Kw (only applicable when IsElectric = true)'
 , MAX_PALLET_POS_CNT COMMENT 'Maximum nr of pallet positions'
 , MAX_LOAD_WEIGHT_QTY COMMENT 'Maximum weight to be loaded on vehicle'
 , MAX_DRIVE_DIST COMMENT 'Maximum distance a vehicle can drive. Only applicable for Resource of ResourceType.CanReposition = true.'
 , MAX_TIME COMMENT 'The maximum duration of this resource'
 , LOAD_ONEWAY_ALLOWED_FG COMMENT 'Indicates whether it is allowed that this resource ends at a different end point than the RDC while it still hasshipments loaded onto it. Only applicable for Resource of ResourceType.HasContentsState = true.'
 , RESOURCE_NAME COMMENT 'Unique name of the resource'
 , WALLS_RED_CAP_CNT COMMENT 'When using at least this amount of walls then the number of available pallet positions is reduced. Only applicable for Resource of ResourceType.HasContentsState = true.'
 , SHIFT_ALLOWED_CNT COMMENT 'Indicateds how many drivers shifts are allowed on the resource '
 , SEP_WALLS_CNT COMMENT 'Number of seperating walls on the vehicle (always 1 for 3 vaporizers). Only applicable for Resource of ResourceType.HasContentsState = true.'
 , VAP_CNT COMMENT 'Number of vaporizers available on the vehicle/ Only applicable for Resource of ResourceType.HasContentsState = true.'
 , DRIVERS_CNT COMMENT 'Defines how many drivers are a the resource concurrently. Only applicable for Resource of ResourceType.CanReposition = true.'
 , STOPS_NOCOST_CNT COMMENT 'The number of stops for which the additional cost for the stops does not apply'
 , TOLL_CAT_NR COMMENT 'Toll category applicable to the resource. Only applicable for Resource of ResourceType.CanReposition = true.'
 , RED_CAP_CNT COMMENT 'Number of pallet positions that are lost when the number of walls that are used is ≥ NrOfWallsThatReducedCapacity1. Only applicable for Resource of ResourceType.HasContentsState = true.'
 , EMPTY_RESOURCE_WEIGHT COMMENT 'Weight of the empty resource'
 , RESOURCE_WIDTH COMMENT 'Width of vehicle (translated into a property in LP). Only applicable for Resource of ResourceType.HasContentsState = true.'
 , FACTOR_LOAD_UNLOAD_TIME COMMENT 'Factor to multiply the Address_2 FixedLoadingTime and FixedUnloadingTime with when this resource is used. In case no value is available a value of 1 needs to be submitted.'
 , HAS_LIFT_FG COMMENT 'Indicates whether a vehicle has unloading equipment such as tail lift scissor lift (translated into a property in LP). Only applicable for Resource of ResourceType.HasContentsState = true.'
 , HASNOLICENSEPLATEOVERLAP COMMENT 'True (not violated) if no RDC resource vehicle has the same license plate selected for the same day excluding empty strings'
 , HASUNIQUEDEFINITIONPERWEEKDAY COMMENT 'True (not violated) if there are no RDCGlobalParameter objects that cover any of the same days of the week as this object'
 , ISSPEEDPROFILEAVAILABLE COMMENT 'TRUE if all master time intervals that have day of week overlapping with this RDC resource contain a resource type time inteval'
 , ISSUBCONTRACTORAVAILABLE COMMENT 'TRUE if there exists an haulier with IsSubcontractor = true has the same subcontractor id of this rdc resource'
 , TRAILERCONSUMPTION COMMENT 'Fuel/Energy consumption of a trailer'
 , DRIVINGDRIVETYPE COMMENT 'Drive type of a motor vehicle'
 , TRAILERDRIVETYPE COMMENT 'Drive type of a trailer'
 , MAXCAPACITY1CONVERTED COMMENT 'The converted maximum capacity (for quantity1) for this resource'
 , ISDUMMY COMMENT 'True if this resource is considered dummy_2 for planning and excluded from KPI calculations'
 , DRIVINGCONSUMPTION COMMENT 'Fuel/Energy consumption of a motor vehicle'
 , DWH_LOAD_ID COMMENT 'Load id'
 , DWH_CREATED COMMENT 'Record created at'
 , DWH_UPDATED COMMENT 'Record updated at'
 , DWH_VALID_FROM COMMENT 'Valid from date'
 , DWH_VALID_TO COMMENT 'Valid to date'
 , DELETED_FG COMMENT 'Flag if record is deleted'
) COMMENT='QUINTIQ - PREPARED VIEW ON RAW DATA'
 AS 
SELECT
   CLIENT_ID
 , LIDL_COUNTRY
 , SOURCE_SYSTEM
 , WH_ID
 , DAY_OF_WEEK
 , EARLIEST_START_TM
 , VEHICLE_HEIGHT
 , RESOURCE_ID
 , ELECTRIC_FG
 , ONEWAY_ALLOWED_FG
 , OPTIM_RESTRICTED_FG
 , SOFT_DELETE_FG
 , RESOURCE_LENGTH
 , BATTERY_CAP
 , MAX_PALLET_POS_CNT
 , MAX_LOAD_WEIGHT_QTY
 , MAX_DRIVE_DIST
 , MAX_TIME
 , LOAD_ONEWAY_ALLOWED_FG
 , RESOURCE_NAME
 , WALLS_RED_CAP_CNT
 , SHIFT_ALLOWED_CNT
 , SEP_WALLS_CNT
 , VAP_CNT
 , DRIVERS_CNT
 , STOPS_NOCOST_CNT
 , TOLL_CAT_NR
 , RED_CAP_CNT
 , EMPTY_RESOURCE_WEIGHT
 , RESOURCE_WIDTH
 , FACTOR_LOAD_UNLOAD_TIME
 , HAS_LIFT_FG
 , HASNOLICENSEPLATEOVERLAP
 , HASUNIQUEDEFINITIONPERWEEKDAY
 , ISSPEEDPROFILEAVAILABLE
 , ISSUBCONTRACTORAVAILABLE
 , TRAILERCONSUMPTION
 , DRIVINGDRIVETYPE
 , TRAILERDRIVETYPE
 , MAXCAPACITY1CONVERTED
 , ISDUMMY
 , DRIVINGCONSUMPTION
 , DWH_LOAD_ID
 , DWH_CREATED
 , DWH_UPDATED
 , DWH_VALID_FROM
 , DWH_VALID_TO
 , DELETED_FG
FROM DATA.T_QUINTIQ_RDCRESOURCEVEHICLE_2;