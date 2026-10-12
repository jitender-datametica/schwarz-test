
/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_fact_normalized_vehicle_measures_1
Description		  | Vehicle measures normalized on pallet
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_FACT_NORMALIZED_VEHICLE_MEASURES_1(
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
	,AVG_VEHICLE_COUNT
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
	,AVG_VEHICLE_CNT AS AVG_VEHICLE_COUNT
FROM CORE.T_FACT_NORMALIZED_VEHICLE_MEASURES_1
;


