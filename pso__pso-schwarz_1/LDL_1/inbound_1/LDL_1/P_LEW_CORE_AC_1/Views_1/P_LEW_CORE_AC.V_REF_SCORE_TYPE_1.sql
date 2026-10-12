CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_SCORE_TYPE_1    
    
(  score_type_sid  COMMENT 'Surrogate Key SCORE TYPE'
 , score_type_name  COMMENT 'name of the score type'
 , score_type_descr  COMMENT 'description of the score type'
 , dwh_load_id  COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'
 , dwh_created  COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'
 , dwh_updated  COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH'
   
) AS 
 SELECT    
  score_type_sid  
 , score_type_name  
 , score_type_descr  
 , dwh_load_id  
 , dwh_created  
 , dwh_updated  
    
FROM P_LEW_CORE.T_REF_SCORE_TYPE_1    
; 