CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MODEL COMMENT = '$Revision: 0000 $. a model consists of one or more segmentations which are defined together and intended to run together'
    
(  model_sid  COMMENT 'Surrogate Key MODEL'
 , model_name  COMMENT 'name of the model'
 , model_descr  COMMENT 'description of the model'
 , dwh_load_id  COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'
 , dwh_created  COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'
 , dwh_updated  COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH'
   
) AS 
 SELECT    
  model_sid  
 , model_name  
 , model_descr  
 , dwh_load_id  
 , dwh_created  
 , dwh_updated  
    
FROM P_LEW_CORE.T_REF_MODEL     
; 
 
