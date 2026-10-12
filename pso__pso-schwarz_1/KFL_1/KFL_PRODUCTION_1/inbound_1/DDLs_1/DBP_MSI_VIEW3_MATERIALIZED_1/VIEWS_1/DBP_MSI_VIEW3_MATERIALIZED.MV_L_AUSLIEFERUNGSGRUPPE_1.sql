create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_L_AUSLIEFERUNGSGRUPPE_1(
	AUSLIEFERUNGSGRUPPE_ID
) as
--2022-03-21,AP0101988, SPEC0121842, initial, dknop 
--2022-05-12,AP0128635, SPEC0151986, removing mandant_id, dknop 
    
  SELECT 

auslieferungsgruppe_id FROM 
( 
SELECT 

auslieferungsgruppe_id FROM  dbp_view.v_wg_auslieferungsgruppe_per_1 WHERE dat_bis = '9999-12-31' GROUP BY auslieferungsgruppe_id
UNION  
SELECT 

auslieferungsgruppe_id FROM  dbp_view.v_art_auslieferungsgruppe_per_1 WHERE dat_bis = '9999-12-31' GROUP BY auslieferungsgruppe_id
UNION --dummy_1 record! 
SELECT 

'-1' AS auslieferungsgruppe_id FROM dbp_view.v_art_auslieferungsgruppe_per_1
) 
GROUP BY auslieferungsgruppe_id;