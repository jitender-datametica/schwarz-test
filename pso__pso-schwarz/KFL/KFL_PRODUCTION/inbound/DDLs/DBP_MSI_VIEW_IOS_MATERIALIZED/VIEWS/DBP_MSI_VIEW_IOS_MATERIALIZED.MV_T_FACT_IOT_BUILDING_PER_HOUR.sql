create or replace view DBP_MSI_VIEW_IOS_MATERIALIZED.MV_T_FACT_IOT_BUILDING_PER_HOUR(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	CAL_DT,
	DEVICE_ID,
	MEASUREMENT_TM,
	OUTDOORTEMP_CONDENSER_SUPPLYAIR_MEAS
) as
SELECT  
    v01.mandant_id
    , COALESCE (v02.aktuell_wup_id, v01.wup_id) AS wup_id
    , v01.nb_id
    , v01.cal_dt
    , v01.device_id
    , v01.measurement_tm
    , v01.outdoortemp_condenser_supplyair_meas
FROM  dbp_view.v_t_fact_iot_building_per_hour v01
LEFT JOIN dbp_view.v_wup v02
   ON v01.wup_id = v02.wup_id AND 
   v01.mandant_id = v02.mandant_id;