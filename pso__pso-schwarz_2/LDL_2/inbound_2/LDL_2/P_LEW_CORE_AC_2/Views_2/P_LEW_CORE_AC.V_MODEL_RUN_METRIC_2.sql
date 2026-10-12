CREATE OR REPLACE VIEW P_LEW_CORE_AC.v_model_run_metric_2 COMMENT = '$Revision: 0000 $. This table contains the model-level results of a model run for every specific model run metric type.'
(
   model_sid                 COMMENT 'Surrogate Key MODEL'
   ,geo_area_sid             COMMENT 'Surrogate Key GEO AREA. Unique identifier of the geographical area.'
   ,run_tmsp                 COMMENT 'Relevant timestamp of the model run.'
   ,active_from_dt           COMMENT 'Start of the timeframe the model run result is valid for. This is in general the first day of a reference period, e.g. the Monday of the reference week for a weekly model.'
   ,model_run_metric_type_cd COMMENT 'Technical code for the metric to be calculated on model level in a run.'
   ,model_run_metric_measure COMMENT 'Result of the calculation of the metric in a model run.'
   ,model_area_cd            COMMENT 'Sprechender Code, CX, LDL+, AP.'
   ,model_group_cd           COMMENT 'Eindeutiger code, der mit dem area_cd beginnt, z.B. AP_bakeoff or CX_store_rating.'
   ,dwh_load_id              COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'
   ,dwh_created              COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'
   ,dwh_updated              COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.'
)
AS 
    SELECT 
        model_sid
        ,geo_area_sid
        ,run_tmsp
        ,active_from_dt
        ,model_run_metric_type_cd
        ,model_run_metric_measure
        ,model_area_cd
        ,model_group_cd
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated
FROM P_LEW_CORE.t_model_run_metric_2 ;