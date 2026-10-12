CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_T_FACT_IOT_COLD_LOCATION_2
-- 20200528 SPEC0074701 sanadze: Initialisierung 		
--20250122 alavih: Filialumgliederung
(
    mandant_id
    , wup_id
    , nb_id
    , cal_dt
    , device_id
    , measurement_tm
    , supply_airtemp_meas
    , return_airtemp_meas
    , superheat_meas
    , door_open_pct
    , evaporator_active_qty
    , cooling_active_pct
    , temp_actual_meas
) 
AS
SELECT  
    v01.mandant_id
    , COALESCE (v02.aktuell_wup_id, v01.wup_id) AS wup_id --nur aktuell gültige WUP_2
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
FROM  dbp_view.v_t_fact_iot_cold_location_2 v01
LEFT JOIN dbp_view.v_wup_2 v02 --nur aktuell gültige WUP_2
   ON v01.wup_id = v02.wup_id AND 
   v01.mandant_id = v02.mandant_id
;