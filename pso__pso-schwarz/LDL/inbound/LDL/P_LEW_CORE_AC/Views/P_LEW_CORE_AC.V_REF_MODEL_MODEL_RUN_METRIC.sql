CREATE OR REPLACE VIEW p_lew_core_ac.v_ref_model_model_run_metric COMMENT = '$Revision: 0000 $. this table contains the information which model run metric will be calculated for which model'
(
   model_sid COMMENT 'Surrogate Key MODEL'
   ,model_run_metric_type_cd COMMENT 'technical code for the metric to be calculated on model level in a run'
   ,model_area_cd COMMENT 'sprechender Code, CX, LDL+,AP'
   ,model_group_cd COMMENT 'eindeutiger code, der mit dem area_cd beginnt z.b. AP_bakeoff or CX_store_rating'
   ,dwh_load_id COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'
   ,dwh_created COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'
   ,dwh_updated COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH'
)
AS 
    SELECT 
        model_sid
        ,model_run_metric_type_cd
        ,model_area_cd
        ,model_group_cd
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated
FROM P_LEW_CORE.t_ref_model_model_run_metric ;