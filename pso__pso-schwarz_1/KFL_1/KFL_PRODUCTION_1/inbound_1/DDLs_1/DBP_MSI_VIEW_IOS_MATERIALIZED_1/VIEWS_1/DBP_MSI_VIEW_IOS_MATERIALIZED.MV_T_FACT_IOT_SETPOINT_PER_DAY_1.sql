create or replace view DBP_MSI_VIEW_IOS_MATERIALIZED.MV_T_FACT_IOT_SETPOINT_PER_DAY_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	CAL_DT,
	DAT_VON,
	DAT_BIS,
	DEVICE_ID,
	SUPPLY_AIRTEMP_MEAS,
	RETURN_AIRTEMP_MEAS,
	LIQUEFACTIONTEMP_MEAS,
	LIQUEFACTIONTEMP_COMPOUND_MEAS,
	TEMP_MEAS,
	LOWTEMP_MEAS,
	DEFROST_LIMITTEMP_MEAS
) as
SELECT  
    v01.mandant_id
    , v03.aktuell_wup_id AS wup_id
    , v01.nb_id
    , v02.dat AS cal_dt
    , v01.dat_von
    , v01.dat_bis
    , v01.device_id
    , v01.supply_airtemp_meas 
    , v01.return_airtemp_meas 
    , v01.liquefactiontemp_meas
    , v01.liquefactiontemp_compound_meas 
    , v01.temp_meas 
    , v01.lowtemp_meas 
    , v01.defrost_limittemp_meas
 
FROM dbp_view.v_t_fact_iot_setpoint_per_day_1 v01
JOIN dbp_view.v_tag_1 v02
ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis
INNER JOIN dbp_view.v_wup_1 v03 
   ON v01.wup_id = v03.wup_id AND 
   v01.mandant_id = v03.mandant_id;