CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_T_FACT_IOT_COLD_LOCATION_PER_HOUR_2
-- 20200625 SPEC0074701 sanadze: Initialisierung 	
-- 20210415 SPEC richternic: Aufnahme einer neuen Spalte 
--20250122 alavih: Filialumgliederung	
(
    mandant_id
    , wup_id
    , nb_id
    , cal_dt
    , device_id
    , measurement_tm
    , supply_airtemp_actual_meas
    , supply_airtemp_setpoint_meas 
    , return_airtemp_actual_meas
    , return_airtemp_setpoint_meas 
    , temp_actual_meas
    , temp_setpoint_meas 
    , vaporizationtemp_effective_meas
    , superheat_meas
    , defrosting_activ_pct
    , door_open_pct
    , overtemp_diff
    , alarm_delay_hightemp_meas
    , alarm_priority_qty
    , defrosttime_max_qty
    , driptime_qty
    , evaporator_active_qty
    , cooling_active_pct
    , overtemp_meas
    , evaporationtemp_max_meas
    , evaporation_limittemp_setpoint_meas
    , lowtemp_setpoint_meas
) 
AS
SELECT  
    v01.mandant_id
    , COALESCE(v02.aktuell_wup_id, v01.wup_id) AS wup_id --aktuell gültige WUP_2
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
FROM  dbp_view.v_t_fact_iot_cold_location_per_hour_2 v01
LEFT JOIN dbp_view.v_wup_2 v02 --Aktuell gültige WUP_ID
   ON v01.wup_id = v02.wup_id AND 
   v01.mandant_id = v02.mandant_id
   ;