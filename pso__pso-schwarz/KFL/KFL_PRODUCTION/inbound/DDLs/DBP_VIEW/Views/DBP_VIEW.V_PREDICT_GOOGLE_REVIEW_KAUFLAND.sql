CREATE OR REPLACE VIEW DBP_VIEW.V_PREDICT_GOOGLE_REVIEW_KAUFLAND AS 
    SELECT 
         google_place_id       
        ,kjmo                  
        ,mandant_id            
        ,wup_id                
        ,predict_review_count  
        ,predict_rating_avg    		
FROM DBP_DATA.predict_google_review_kaufland ;