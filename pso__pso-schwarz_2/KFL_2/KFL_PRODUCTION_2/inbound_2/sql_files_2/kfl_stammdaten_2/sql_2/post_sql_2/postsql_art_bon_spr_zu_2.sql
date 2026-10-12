--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM DBP_ETL_PROCESS.agg_kinspect_wg_bez;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_ETL_PROCESS.agg_kinspect_wg_bez
(
      mandant_id,
      wg_id,
      wg_bez
)
SELECT
t1.mandant_id
,t1.wg_hierarchie_id as wg_id
,t1.wg_hierarchie_bez as wg_bez
FROM DBP_DATA.wg_hierarchie_spr_zu_2 t1_2
INNER JOIN DBP_DATA.mandant_spr_zu_2 t2
ON t1.mandant_id=t2.mandant_id
AND t1.spr_id=t2.spr_id
WHERE t1.arthiertyp_id=5 
AND t1.wg_hierarchie_ebene_id=3;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM DBP_ETL_PROCESS.agg_kinspect_art;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT	INTO DBP_ETL_PROCESS.agg_kinspect_art      
(                                                   
      mandant_id,                                  
      wg_id,                                       
      kl_art_id,                                   
      art_bez,                                     
	  oeko,                                          
	  nachhaltig,                                    
	  tierwohl,                                      
	  fairtrade                                      
)                                                  
SELECT                                             
      dt1.mandant_id,                              
      t2.wg_hierarchie_mutter_id wg_id,            
      dt1.kl_art_id kl_art_id,                     
      t4.art_bon_bez art_bez,                          
	  0 as oeko,                                     
	  0 as nachhaltig,                               
	  0 as tierwohl,                                 
	  0 as fairtrade                                 
FROM (                                             
SELECT	kl_art_id,mandant_id,max(art_id) as art_id 
FROM	dbe_data.art_2                                 
GROUP BY 1,2) dt1                                  
INNER JOIN DBP_DATA.art_wg_zu_per_2 t1_2               
	ON dt1.art_id=t1.art_id                          
	AND dt1.mandant_id=t1.mandant_id                 
INNER JOIN DBP_DATA.wg_hierarchie_zu_per_2 t2        
	ON t1.mandant_id=t2.mandant_id                   
	AND t1.wg_id=t2.wg_hierarchie_id                 
	AND t2.wg_hierarchie_ebene_id=4                  
	AND t2.dat_bis= to_date('9999-12-31','YYYY-MM_2-DD')                          
	AND t2.arthiertyp_id=5                           
	AND t1.arthiertyp_id=2                           
	AND t1.dat_bis= to_date('9999-12-31','YYYY-MM_2-DD')                          
INNER JOIN DBP_DATA.art_2 t3                         
	ON dt1.art_id=t3.art_id                          
	AND t1.mandant_id=t3.mandant_id                  
INNER JOIN DBP_ETL_PROCESS.art_bon_spr_zu t4                  
	ON dt1.art_id=t4.art_id                          
	AND dt1.mandant_id=t4.mandant_id                 
INNER JOIN DBP_DATA.mandant_spr_zu_2 t5              
	ON t4.spr_id=t5.spr_id                           
	AND t4.mandant_id=t5.mandant_id;

