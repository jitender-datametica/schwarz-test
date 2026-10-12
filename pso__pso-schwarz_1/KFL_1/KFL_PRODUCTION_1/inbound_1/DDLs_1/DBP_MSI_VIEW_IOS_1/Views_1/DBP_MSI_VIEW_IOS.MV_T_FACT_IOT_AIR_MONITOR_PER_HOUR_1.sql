CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_T_FACT_IOT_AIR_MONITOR_PER_HOUR_1
-- 20200619 SPEC0074701 sanadze: Initialisierung
-- 20240225 alavih: Filialumgliederung
(
    mandant_id
    , wup_id
    , nb_id
    , cal_dt
    , device_id
    , measurement_tm
    , hygrometertemp_meas
    , hygrometerhumidity_meas
) 
AS
SELECT  
    v01.mandant_id
  --  , v01.wup_id
    , COALESCE(w.wup_id, v01.wup_id) AS wup_id
    , v01.nb_id
    , v01.cal_dt
    , v01.device_id
    , v01.measurement_tm
    , v01.hygrometertemp_meas
    , v01.hygrometerhumidity_meas
FROM  dbp_view.v_t_fact_iot_air_monitor_per_hour_1 v01

LEFT JOIN dbp_view.v_wup_1 w
ON v01.wup_id = w.wup_id 
AND v01.mandant_id = w.mandant_id  

;