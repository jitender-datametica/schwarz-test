 
CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MODEL_RUN_METRIC_TYPE COMMENT = '$Revision: 0000 $. a model run metric defines a model-level result of a model run'
    
(  model_run_metric_type_cd  COMMENT 'technical code for the metric to be calculated on model level in a run'
 , model_run_metric_type_descr  COMMENT 'description of the metric to be calculated on model level in a run'
 , dwh_load_id  COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'
 , dwh_created  COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'
 , dwh_updated  COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH'
    
) AS 
 SELECT    
  model_run_metric_type_cd  
 , model_run_metric_type_descr  
 , dwh_load_id  
 , dwh_created  
 , dwh_updated  
    
FROM P_LEW_CORE.T_REF_MODEL_RUN_METRIC_TYPE     
; 