CREATE OR REPLACE VIEW P_LEW_CORE_AC.v_model_run_1 
(
   model_sid       COMMENT 'Surrogate Key MODEL'
   ,geo_area_sid   COMMENT 'Surrogate Key GEO AREA. Unique identifier of the geographical area.'
   ,run_tmsp       COMMENT 'Relevant timestamp of the model run.'
   ,active_from_dt COMMENT 'Start of the timeframe the model run result is valid for. This is in general the first day of a reference period, e.g. the Monday of the reference week for a weekly model.'
   ,active_to_dt   COMMENT 'End of the timeframe the model run result is valid for. This is in general the last day of a reference period, e.g. the Sunday of the reference week for a weekly model.'
   ,cy_week        COMMENT 'YYYYKW; WAWI: x_data.t_cal_week.cy_week. Populated in the case that the model is a weekly model.'
   ,cy_month       COMMENT 'YYYYMM; WAWI: x_data.t_cal_month.cy_month. Populated in the case that the model is a monthly model.'
   ,model_area_cd  COMMENT 'Sprechender Code, CX, LDL+, AP.'
   ,model_group_cd COMMENT 'Eindeutiger code, der mit dem model_area_cd beginnt, z.B. AP_bakeoff or CX_store_rating.'
   ,dwh_load_id    COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'
   ,dwh_created    COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'
   ,dwh_updated    COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.'
)
AS 
    SELECT 
        model_sid
        ,geo_area_sid
        ,run_tmsp
        ,active_from_dt
        ,active_to_dt
        ,cy_week
        ,cy_month
        ,model_area_cd
        ,model_group_cd
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated
FROM P_LEW_CORE.t_model_run_1 ;