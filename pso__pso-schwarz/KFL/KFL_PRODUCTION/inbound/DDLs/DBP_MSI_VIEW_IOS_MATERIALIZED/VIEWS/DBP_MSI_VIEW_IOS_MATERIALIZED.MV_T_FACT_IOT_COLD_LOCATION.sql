create or replace view DBP_MSI_VIEW_IOS_MATERIALIZED.MV_T_FACT_IOT_COLD_LOCATION(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	CAL_DT,
	DEVICE_ID,
	MEASUREMENT_TM,
	SUPPLY_AIRTEMP_MEAS,
	RETURN_AIRTEMP_MEAS,
	SUPERHEAT_MEAS,
	DOOR_OPEN_PCT,
	EVAPORATOR_ACTIVE_QTY,
	COOLING_ACTIVE_PCT,
	TEMP_ACTUAL_MEAS
) as
SELECT  
    v01.mandant_id
    , COALESCE (v02.aktuell_wup_id, v01.wup_id) AS wup_id 
    , v01.nb_id
    , v01.cal_dt
    , v01.device_id
    , v01.measurement_tm
    , v01.supply_airtemp_meas
    , v01.return_airtemp_meas
    , v01.superheat_meas
    , v01.door_open_pct
    , v01.evaporator_active_qty
    , v01.cooling_active_pct
    , v01.temp_actual_meas
FROM  dbp_view.v_t_fact_iot_cold_location v01
LEFT JOIN dbp_view.v_wup v02 
   ON v01.wup_id = v02.wup_id AND 
   v01.mandant_id = v02.mandant_id;