/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_reportedaddressstate_kpi
Description		|	QUINTIQ - view with final KPIs for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_QUINTIQ_REPORTEDADDRESSSTATE_KPI(
   CLIENT_ID COMMENT 'Client id - calculated based on the country code'
 , LIDL_COUNTRY COMMENT 'Country code. Original field name bic_zmlila'
 , SOURCE_SYSTEM COMMENT 'Source system'
 , WH_ID COMMENT 'Warehouse ID'
 , PALLET_POS_ADDITIONAL_DIST COMMENT 'The additional distance per pallet positions that had to be travelled to visit this address during the considered tour'
 , ADDRESS_ID COMMENT 'Stores the address ID'
 , CALENDAR_WEEK COMMENT 'CalendarWeek'
 , DELIVERY_DT COMMENT 'End of the delivery day to optimize for (max 24hrs after start).'
 , ONEWAY_FG COMMENT 'The address state where the resources are dismounted for one way tours'
 , TEMP_FG COMMENT 'Indicates if this is a temporary reported address state'
 , PALLET_POS_DLV_CNT COMMENT 'This calculates the number of pallet positions that is delivered to an address during a tour'
 , TOUR_DIST_WITHOUT_ADDR COMMENT 'The resulting tour distance if the considered address was not part of the tour'
 , REPORTEDTOURGID COMMENT 'GID of the reported tour'
 , DWH_LOAD_ID COMMENT 'Load id'
 , DWH_CREATED COMMENT 'Record created at'
 , DWH_UPDATED COMMENT 'Record updated at'
 , DWH_VALID_FROM COMMENT 'Valid from date'
 , DWH_VALID_TO COMMENT 'Valid to date'
 , DELETED_FG COMMENT 'Flag if record is deleted'
 , ACTIVE_FG COMMENT 'Flag if record is active'
 , ARRIVALACTUALTELEMATICS COMMENT 'Actual arrival time at this address received from Telematics'
 , ARRIVALESTIMATEDTELEMATICS COMMENT 'Estimated arrival time at this address received from Telematics'
 , DEPARTUREACTUALTELEMATICS COMMENT 'Actual departure time at this address received from Telematics'
) COMMENT='QUINTIQ - view with final KPIs for FE'
 AS 
SELECT
	CLIENT_ID
	,LIDL_COUNTRY
	,SOURCE_SYSTEM
	,WH_ID
	,PALLET_POS_ADDITIONAL_DIST
	,ADDRESS_ID
	,CALENDAR_WEEK
	,DELIVERY_DT
	,ONEWAY_FG
	,TEMP_FG
	,PALLET_POS_DLV_CNT
	,TOUR_DIST_WITHOUT_ADDR
	,REPORTEDTOURGID
	,DWH_LOAD_ID
	,DWH_CREATED
	,DWH_UPDATED
	,DWH_VALID_FROM
	,DWH_VALID_TO
	,DELETED_FG
	,IFF(DWH_VALID_TO = '9999-12-30', 1, 0) AS ACTIVE_FG
    ,ARRIVALACTUALTELEMATICS
    ,ARRIVALESTIMATEDTELEMATICS
    ,DEPARTUREACTUALTELEMATICS
FROM FE_MSTR_LOGOP.V_QUINTIQ_REPORTEDADDRESSSTATE;