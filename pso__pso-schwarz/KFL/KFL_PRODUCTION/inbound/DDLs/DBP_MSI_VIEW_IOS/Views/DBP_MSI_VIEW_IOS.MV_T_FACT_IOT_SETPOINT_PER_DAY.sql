CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_T_FACT_IOT_SETPOINT_PER_DAY
-- 20200803 SPEC0074701 sanadze: Initialisierung
--20250122 alavih: Filialumgliederung 		
(
    mandant_id
    , wup_id
    , nb_id
    , cal_dt
    , dat_von
    , dat_bis
    , device_id
    , supply_airtemp_meas
    , return_airtemp_meas
    , liquefactiontemp_meas
    , liquefactiontemp_compound_meas
    , temp_meas
    , lowtemp_meas
    , defrost_limittemp_meas
) 
AS
SELECT  
    v01.mandant_id
    , v03.aktuell_wup_id AS wup_id--aktuelle WUP
    , v01.nb_id
    , v02.dat AS cal_dt
    , v01.dat_von
    , v01.dat_bis
    , v01.device_id
    , v01.supply_airtemp_meas -- Sollwert Zulufttemperatur  (Stunde) --
    , v01.return_airtemp_meas -- Sollwert Ruecklufttemperatur (Stunde) --
    , v01.liquefactiontemp_meas-- Sollwert Verfluessigungstemperatur (Stunde)-
    , v01.liquefactiontemp_compound_meas -- Sollwert Verfluessigungstemperatur-
    , v01.temp_meas -- Sollwert temperatur (Stunde)
    , v01.lowtemp_meas -- Sollwert Untertemperatur (Stunde) 
    , v01.defrost_limittemp_meas-- Sollwert Abtaubegrenzungstemperatur (Stunde)
 
FROM dbp_view.v_t_fact_iot_setpoint_per_day v01
JOIN dbp_view.v_tag v02
ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis
INNER JOIN dbp_view.v_wup v03 --aktuelle WUP
   ON v01.wup_id = v03.wup_id AND 
   v01.mandant_id = v03.mandant_id
   ;