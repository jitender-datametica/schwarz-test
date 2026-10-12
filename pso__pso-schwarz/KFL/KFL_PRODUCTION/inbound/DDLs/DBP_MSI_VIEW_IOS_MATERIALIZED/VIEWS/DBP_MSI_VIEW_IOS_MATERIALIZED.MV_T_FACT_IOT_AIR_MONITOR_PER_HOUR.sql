create or replace view DBP_MSI_VIEW_IOS_MATERIALIZED.MV_T_FACT_IOT_AIR_MONITOR_PER_HOUR(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	CAL_DT,
	DEVICE_ID,
	MEASUREMENT_TM,
	HYGROMETERTEMP_MEAS,
	HYGROMETERHUMIDITY_MEAS
) as
SELECT  
    v01.mandant_id
  
    , COALESCE(w.wup_id, v01.wup_id) AS wup_id
    , v01.nb_id
    , v01.cal_dt
    , v01.device_id
    , v01.measurement_tm
    , v01.hygrometertemp_meas
    , v01.hygrometerhumidity_meas
FROM  dbp_view.v_t_fact_iot_air_monitor_per_hour v01

LEFT JOIN dbp_view.v_wup w
ON v01.wup_id = w.wup_id 
AND v01.mandant_id = w.mandant_id;