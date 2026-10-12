CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_SEGMENTATION    
    
(  segmentation_sid  COMMENT 'Surrogate Key SEGMENTATION'
 , model_sid  COMMENT 'Surrogate Key MODEL'
 , segmentation_name  COMMENT 'name of the segmentation in the model'
 , segmentation_descr  COMMENT 'description of the segmentatzion in the model'
 , dwh_load_id  COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'
 , dwh_created  COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'
 , dwh_updated  COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH'
    
) AS 
 SELECT    
  segmentation_sid  
 , model_sid  
 , segmentation_name  
 , segmentation_descr  
 , dwh_load_id  
 , dwh_created  
 , dwh_updated  
    
FROM  P_LEW_CORE.T_REF_SEGMENTATION   
; 