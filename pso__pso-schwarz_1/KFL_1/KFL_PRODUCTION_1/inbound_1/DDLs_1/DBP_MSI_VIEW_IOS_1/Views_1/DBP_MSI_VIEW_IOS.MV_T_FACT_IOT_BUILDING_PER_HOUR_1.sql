CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_T_FACT_IOT_BUILDING_PER_HOUR_1
-- 20200619 SPEC0074701 sanadze: Initialisierung 
--20250122 alavih: Filialumgliederung		
(
    mandant_id
    , wup_id
    , nb_id
    , cal_dt
    , device_id
    , measurement_tm
    , outdoortemp_condenser_supplyair_meas
) 
AS
SELECT  
    v01.mandant_id
    , COALESCE (v02.aktuell_wup_id, v01.wup_id) AS wup_id
    , v01.nb_id
    , v01.cal_dt
    , v01.device_id
    , v01.measurement_tm
    , v01.outdoortemp_condenser_supplyair_meas
FROM  dbp_view.v_t_fact_iot_building_per_hour_1 v01
LEFT JOIN dbp_view.v_wup_1 v02
   ON v01.wup_id = v02.wup_id AND 
   v01.mandant_id = v02.mandant_id
;