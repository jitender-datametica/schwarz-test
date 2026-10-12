CREATE OR REPLACE VIEW P_LEW_CORE_AC.v_customer_score_2 COMMENT = '$Revision: 0000 $. this table contains the calculated scores for customers which have been calculated in model runs of models for customer segmentation'
(
   customer_sid    COMMENT 'unique identifier of the customer (surrogate key)'
   ,score_type_sid COMMENT 'Surrogate Key SCORE TYPE'
   ,model_sid      COMMENT 'Surrogate Key MODEL'
   ,geo_area_sid   COMMENT 'unique identifier of the geographical area (surrogate key)'
   ,run_tmsp       COMMENT 'relevant timestamp of the model run'
   ,active_from_dt COMMENT 'begin of the timeframe the model run result is valid for. This is in general the first day of a reference period, e.g. the Monday of the reference week for a weekly model.'
   ,score_measure  COMMENT 'result of the calculation of a score type for an individual customer in a certain model run.'
   ,model_area_cd  COMMENT 'sprechender Code, CX, LDL+,AP'
   ,model_group_cd COMMENT 'eindeutiger code, der mit dem area_cd beginnt z.b. AP_bakeoff or CX_store_rating'
   ,dwh_load_id    COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'
   ,dwh_created    COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'
   ,dwh_updated    COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH'
)
AS 
    SELECT 
        customer_sid
        ,score_type_sid
        ,model_sid
        ,geo_area_sid
        ,run_tmsp
        ,active_from_dt
        ,score_measure
        ,model_area_cd
        ,model_group_cd
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated
FROM P_LEW_CORE.t_customer_score_2 ;