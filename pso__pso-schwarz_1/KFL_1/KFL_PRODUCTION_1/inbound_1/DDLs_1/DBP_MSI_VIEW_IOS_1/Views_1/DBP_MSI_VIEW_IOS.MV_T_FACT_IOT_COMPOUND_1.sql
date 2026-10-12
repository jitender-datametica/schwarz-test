CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_T_FACT_IOT_COMPOUND_1
-- 20200528 SPEC0074701 sanadze: Initialisierung 		
-- 20210415 SPEC richternic: Aufnahme einer neuen Spalte
--20250122 alavih: Filialumgliederung
--  
(
    mandant_id
    , wup_id 
    , nb_id
    , cal_dt
    , device_id
    , measurement_tm
    , liquefactiontemp_actual_meas
    , liquefactiontemp_setpoint_meas
    , roomtemp_meas
    , evaporationtemp_actual_meas
    , evaporation_pressure_meas
) 
AS
SELECT  
    v01.mandant_id
    , COALESCE(v02.aktuell_wup_id, v01.wup_id) AS wup_id --aktuelle wup_1
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
LEFT JOIN dbp_view.v_wup_1 v02 --aktuell gültige WUP_1
   ON v01.wup_id = v02.wup_id AND 
   v01.mandant_id = v02.mandant_id;