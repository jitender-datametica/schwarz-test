
/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_fact_vehicle_measures_2
Description		  | This view lists the vehicles with which a disposition is executed
====================================================================================================
*/


CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_FACT_VEHICLE_MEASURES_2(
	INBOUND_DISPO_ORDER_SID
	,TRANSPORT_UNIT_SEQ
	,EXECUTING_HAULER_SID
	,RECEIVING_WH_SID
	,MAIN_CROSSDOCK_SID
	,SUPPLIER_SITE_SID
	,LOGISTIC_TYPE_CD
	,LOGISTIC_TEMP_CD
	,BUS_COUNTRY_CD
	,MEANS_OF_TRANSPORT_CD
	,CAL_DT
	,TRANSPORT_VEHICLE_DESCR
	,VEHICLE_COUNT
	,PLANNED_ORDER_DT
) AS
SELECT
	INBOUND_DISPO_ORDER_SID
	,TRANSPORT_UNIT_SEQ
	,EXECUTING_HAULER_SID
	,RECEIVING_WH_SID
	,MAIN_CROSSDOCK_SID
	,SUPPLIER_SITE_SID
	,LOGISTIC_TYPE_CD
	,LOGISTIC_TEMP_CD
	,BUS_COUNTRY_CD
	,MEANS_OF_TRANSPORT_CD
	,CAL_DT
	,TRANSPORT_VEHICLE_DESCR
	,VEHICLE_CNT AS VEHICLE_COUNT 
	,PLANNED_ORDER_DT
FROM CORE.T_FACT_VEHICLE_MEASURES_2
;
