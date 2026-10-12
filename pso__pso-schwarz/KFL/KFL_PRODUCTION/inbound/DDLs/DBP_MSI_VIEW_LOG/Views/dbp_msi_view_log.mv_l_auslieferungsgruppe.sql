CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_AUSLIEFERUNGSGRUPPE(

	AUSLIEFERUNGSGRUPPE_ID
) AS
--2022-03-21,AP0122352, SPEC0146171,initial, dknop 
 --2022-05-12,AP0128635, SPEC0151986, removing mandant_id, dknop    
  SELECT 

auslieferungsgruppe_id FROM 
( 
SELECT 

auslieferungsgruppe_id FROM  dbp_view.v_wg_auslieferungsgruppe_per WHERE dat_bis = '9999-12-31' GROUP BY auslieferungsgruppe_id
UNION  
SELECT 

auslieferungsgruppe_id FROM  dbp_view.v_art_auslieferungsgruppe_per WHERE dat_bis = '9999-12-31' GROUP BY auslieferungsgruppe_id
UNION --dummy record! 
SELECT 

'-1' AS auslieferungsgruppe_id FROM dbp_view.v_art_auslieferungsgruppe_per
) 
GROUP BY auslieferungsgruppe_id;