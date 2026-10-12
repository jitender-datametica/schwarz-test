create or replace view DBP_MSI_VIEW_IOS_MATERIALIZED.MV_T_FACT_IOT_COLD_LOCATION_PER_HOUR(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	CAL_DT,
	DEVICE_ID,
	MEASUREMENT_TM,
	SUPPLY_AIRTEMP_ACTUAL_MEAS,
	SUPPLY_AIRTEMP_SETPOINT_MEAS,
	RETURN_AIRTEMP_ACTUAL_MEAS,
	RETURN_AIRTEMP_SETPOINT_MEAS,
	TEMP_ACTUAL_MEAS,
	TEMP_SETPOINT_MEAS,
	VAPORIZATIONTEMP_EFFECTIVE_MEAS,
	SUPERHEAT_MEAS,
	DEFROSTING_ACTIV_PCT,
	DOOR_OPEN_PCT,
	OVERTEMP_DIFF,
	ALARM_DELAY_HIGHTEMP_MEAS,
	ALARM_PRIORITY_QTY,
	DEFROSTTIME_MAX_QTY,
	DRIPTIME_QTY,
	EVAPORATOR_ACTIVE_QTY,
	COOLING_ACTIVE_PCT,
	OVERTEMP_MEAS,
	EVAPORATIONTEMP_MAX_MEAS,
	EVAPORATION_LIMITTEMP_SETPOINT_MEAS,
	LOWTEMP_SETPOINT_MEAS
) as
SELECT  
    v01.mandant_id
    , COALESCE(v02.aktuell_wup_id, v01.wup_id) AS wup_id 
    , v01.nb_id
    , v01.cal_dt
    , v01.device_id
    , v01.measurement_tm
    , v01.supply_airtemp_actual_meas
    , v01.supply_airtemp_setpoint_meas
    , v01.return_airtemp_actual_meas
    , v01.return_airtemp_setpoint_meas
    , v01.temp_actual_meas
    , v01.temp_setpoint_meas
    , v01.vaporizationtemp_effective_meas
    , v01.superheat_meas
    , v01.defrosting_activ_pct
    , v01.door_open_pct
    , v01.overtemp_diff
    , v01.alarm_delay_hightemp_meas
    , v01.alarm_priority_qty
    , v01.defrosttime_max_qty
    , v01.driptime_qty
    , v01.evaporator_active_qty
    , v01.cooling_active_pct
    , v01.overtemp_meas
    , v01.evaporationtemp_max_meas
    , v01.evaporation_limittemp_setpoint_meas
    , v01.lowtemp_setpoint_meas
FROM  dbp_view.v_t_fact_iot_cold_location_per_hour v01
LEFT JOIN dbp_view.v_wup v02 
   ON v01.wup_id = v02.wup_id AND 
   v01.mandant_id = v02.mandant_id;