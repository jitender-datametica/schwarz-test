/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedroute_2
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_QUINTIQ_REPORTEDROUTE_2(
   CLIENT_ID COMMENT 'Client id - calculated based on the country_2 code'
 , LIDL_COUNTRY COMMENT 'Country_2 code. Original field name bic_zmlila'
 , SOURCE_SYSTEM COMMENT 'Source system'
 , WH_ID COMMENT 'Warehouse ID'
 , DELIVERY_DT COMMENT 'End of the delivery day to optimize for (max 24hrs after start).'
 , CALC_DIST COMMENT 'Distance caluclated for the route'
 , CALC_DUR COMMENT 'Action.End - Action.Start'
 , HAULIER_ID COMMENT 'Identifier of haulier.'
 , HAULIER_NAME COMMENT 'Name of the Haulier'
 , LICENSE_PLATE COMMENT 'License plate of the vechicle used for this tour_2'
 , SHIFTS_CNT COMMENT 'Total number of shifts in the route'
 , RESOURCE_ID COMMENT 'Resource ID'
 , RESOURCE_SET_ID COMMENT 'The ID of resource set used in a route'
 , MAX_CAP_SUM COMMENT 'All capacities of the resources in the resourceSet summed'
 , TOUR_GID COMMENT 'GID is to have a unique identifier of a tour_2 across different delivery days for the same RDC.'
 , USER_DIST COMMENT 'User entered distance for the tour_2'
 , USER_DUR COMMENT 'User entered duration for the tour_2'
 , USER_SHIFTS_CNT COMMENT 'User entered number of shifts in the route'
 , CALENDER_WEEK_NR COMMENT 'Calenderweek of GlobalParameters.DeliveryDateEnd'
 , CHANGES_IN_SHIFT_COSTS COMMENT 'Change In Shift Costs'
 , END_TMSP COMMENT 'The time of the end of the action(s)'
 , HAULIER_CMNT_TXT COMMENT 'User entered comment on the haulier for this route'
 , INDICATORS_TIME_TOUR COMMENT 'Concatenation of all unique time indicators on tours related to this route'
 , TEMP_REPORTED_ROUTE_FG COMMENT 'Indicates if this is a temporary reported route'
 , SHIFT_INDICATOR_ELKE_CNT COMMENT 'Sum over all unique shiftIndicators which have IsStoreDelivery'
 , ROUTE_GID COMMENT 'GID is to have a unique identifier of a Route across different delivery days for the same RDC.'
 , START_TMSP COMMENT 'The time of the start of the action(s)'
 , MAX_CAP_SUM_2 COMMENT 'All capacities of the resources in the resourceSet summed'
 , DWH_LOAD_ID COMMENT 'Load id'
 , DWH_CREATED COMMENT 'Record created at'
 , DWH_UPDATED COMMENT 'Record updated at'
 , DWH_VALID_FROM COMMENT 'Valid from date'
 , DWH_VALID_TO COMMENT 'Valid to date'
 , DELETED_FG COMMENT 'Flag if record is deleted'
 , TRAILER2DRIVETYPEID COMMENT 'ID of trailer 2 drive type'
 , TRAILER1DRIVETYPEID COMMENT 'ID of trailer 1 drive type'
 , SUMMAXCAPACITY1CONVERTED COMMENT 'The sum of all max capacity 1 converted in the resources within this tour_2'
 , ISDUMMYRESOURCESET COMMENT 'TRUE if the resource set assigned to this route is dummy_2'
 , DRIVINGDRIVETYPEID COMMENT 'ID of driving drive type'
) COMMENT='QUINTIQ - prepared view on raw data'
 AS
SELECT
   CLIENT_ID
 , LIDL_COUNTRY
 , SOURCE_SYSTEM
 , WH_ID
 , DELIVERY_DT
 , CALC_DIST
 , CALC_DUR
 , HAULIER_ID
 , HAULIER_NAME
 , LICENSE_PLATE
 , SHIFTS_CNT
 , RESOURCE_ID
 , RESOURCE_SET_ID
 , MAX_CAP_SUM
 , TOUR_GID
 , USER_DIST
 , USER_DUR
 , USER_SHIFTS_CNT
 , CALENDER_WEEK_NR
 , CHANGES_IN_SHIFT_COSTS
 , END_TMSP
 , HAULIER_CMNT_TXT
 , INDICATORS_TIME_TOUR
 , TEMP_REPORTED_ROUTE_FG
 , SHIFT_INDICATOR_ELKE_CNT
 , ROUTE_GID
 , START_TMSP
 , MAX_CAP_SUM_2
 , DWH_LOAD_ID
 , DWH_CREATED
 , DWH_UPDATED
 , DWH_VALID_FROM
 , DWH_VALID_TO
 , DELETED_FG
 , TRAILER2DRIVETYPEID
 , TRAILER1DRIVETYPEID
 , SUMMAXCAPACITY1CONVERTED
 , ISDUMMYRESOURCESET
 , DRIVINGDRIVETYPEID

FROM DATA.T_QUINTIQ_REPORTEDROUTE_2;