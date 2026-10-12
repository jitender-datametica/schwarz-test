CREATE OR REPLACE VIEW DBP_VIEW.V_PREDICT_COMPETITORS_1 AS 
    SELECT 
          google_place_id      
         ,mandant_id           
         ,competitor_name      
         ,wup_name             
         ,wup_str              
         ,wup_standort         
         ,laengengrad          
         ,breitengrad          

FROM DBP_DATA.predict_competitors_1 ;