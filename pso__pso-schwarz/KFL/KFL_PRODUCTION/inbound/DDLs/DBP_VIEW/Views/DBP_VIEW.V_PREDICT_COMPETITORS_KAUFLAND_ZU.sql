CREATE OR REPLACE VIEW DBP_VIEW.V_PREDICT_COMPETITORS_KAUFLAND_ZU AS 
    SELECT 
         google_place_id   
		,kjmo              
		,mandant_id        
		,wup_id            
		,airline_distance  
		
FROM DBP_DATA.predict_competitors_kaufland_zu ;