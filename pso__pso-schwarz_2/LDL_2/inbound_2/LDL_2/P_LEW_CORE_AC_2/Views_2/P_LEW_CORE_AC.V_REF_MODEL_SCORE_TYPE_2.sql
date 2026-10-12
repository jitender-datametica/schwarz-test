CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MODEL_SCORE_TYPE_2 COMMENT = '$Revision: 0000 $. this table contains the information which score will be calculated and used in which model'
    
(  model_sid  COMMENT 'Surrogate Key MODEL'
 , score_type_sid  COMMENT 'Surrogate Key SCORE TYPE'
 , model_area_cd COMMENT 'Sprechender Code, CX, LDL+, AP.'
 , model_group_cd COMMENT 'Eindeutiger Code, der mit dem area_cd beginnt z.b. AP_bakeoff oder CX_store_rating.'
 , dwh_load_id  COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'
 , dwh_created  COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'
 , dwh_updated  COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH'
 
) AS 
 SELECT    
  model_sid  
 , score_type_sid  
 , model_area_cd
 , model_group_cd
 , dwh_load_id  
 , dwh_created  
 , dwh_updated  
    
FROM P_LEW_CORE.T_REF_MODEL_SCORE_TYPE_2     
; 