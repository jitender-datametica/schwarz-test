create or replace view DBP_MSI_VIEW_IOS_MATERIALIZED.MV_T_FACT_IOT_COMPOUND_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	CAL_DT,
	DEVICE_ID,
	MEASUREMENT_TM,
	LIQUEFACTIONTEMP_ACTUAL_MEAS,
	LIQUEFACTIONTEMP_SETPOINT_MEAS,
	ROOMTEMP_MEAS,
	EVAPORATIONTEMP_ACTUAL_MEAS,
	EVAPORATION_PRESSURE_MEAS
) as
SELECT  
    v01.mandant_id
    , COALESCE(v02.aktuell_wup_id, v01.wup_id) AS wup_id 
    , v01.nb_id
    , v01.cal_dt
    , v01.device_id
    , v01.measurement_tm
    , v01.liquefactiontemp_actual_meas
    , v01.liquefactiontemp_setpoint_meas
    , v01.roomtemp_meas
    , v01.evaporationtemp_actual_meas
    , v01.evaporation_pressure_meas
FROM  dbp_view.v_t_fact_iot_compound_1 v01
LEFT JOIN dbp_view.v_wup_1 v02 
   ON v01.wup_id = v02.wup_id AND 
   v01.mandant_id = v02.mandant_id;