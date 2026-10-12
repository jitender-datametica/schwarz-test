create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_ARTKZ_LOESCH_2(
	MANDANT_ID,
	LOESCH_ID,
	LOESCH_BEZ,
	LOESCH_BEZ_DE,
	LOESCH_BEZ_CZ,
	LOESCH_BEZ_SK,
	LOESCH_BEZ_HR,
	LOESCH_BEZ_PL,
	LOESCH_BEZ_RO,
	LOESCH_BEZ_BG
) as
-- 2022-09-13, AP0141509,SPEC0169569, dknop, initial
   SELECT
   v01.mandant_id, v01.loesch_id, MAX(CASE WHEN (spr_id =  22 AND NOT loesch_id='') THEN loesch_bez WHEN (spr_id =  22 AND loesch_id='') THEN 'leer/empty' END) AS loesch_bez                 
   , MAX(CASE WHEN (spr_id =  22 AND NOT loesch_id='') THEN loesch_bez WHEN (spr_id =  22 AND loesch_id='') THEN 'leer/empty' END) AS loesch_bez_de                          
   , COALESCE(MAX(CASE WHEN (spr_id = 124 AND NOT loesch_id='') THEN loesch_bez WHEN (spr_id = 124 AND loesch_id='') THEN 'leer/empty' END), loesch_bez_de) AS loesch_bez_cz    
   , COALESCE(MAX(CASE WHEN (spr_id = 108 AND NOT loesch_id='') THEN loesch_bez WHEN (spr_id =  108 AND loesch_id='') THEN 'leer/empty' END), loesch_bez_de) AS loesch_bez_sk    
   , COALESCE(MAX(CASE WHEN (spr_id = 65 AND NOT loesch_id='') THEN loesch_bez WHEN (spr_id =  65 AND loesch_id='') THEN 'leer/empty'  END), loesch_bez_de) AS loesch_bez_hr    
   , COALESCE(MAX(CASE WHEN (spr_id = 90 AND NOT loesch_id='') THEN loesch_bez WHEN (spr_id =  90 AND loesch_id='') THEN 'leer/empty' END), loesch_bez_de) AS loesch_bez_pl    
   , COALESCE(MAX(CASE WHEN (spr_id = 95 AND NOT loesch_id='') THEN loesch_bez WHEN (spr_id =  95 AND loesch_id='') THEN 'leer/empty' END), loesch_bez_de) AS loesch_bez_ro    
   , COALESCE(MAX(CASE WHEN (spr_id = 18 AND NOT loesch_id='') THEN loesch_bez WHEN (spr_id =  18 AND loesch_id='') THEN 'leer/empty' END), loesch_bez_de) AS loesch_bez_bg    
   FROM dbp_view.v_artkz_loesch_2  v01
   GROUP BY
   v01.mandant_id
   , v01.loesch_id
   UNION ALL
   SELECT
   v02.mandant_id, '' AS loesch_id, 'leer/empty' AS loesch_bez                 
   , 'leer/empty' AS loesch_bez_de, 'leer/empty' AS loesch_bez_cz    
   , 'leer/empty' AS loesch_bez_sk    
   , 'leer/empty' AS loesch_bez_hr     
   , 'leer/empty' AS loesch_bez_pl      
   , 'leer/empty' AS loesch_bez_ro     
   , 'leer/empty' AS loesch_bez_bg    
   FROM dbp_view.v_mandant_2 v02
   WHERE v02.mandant_id <> 1
   GROUP BY
   v02.mandant_id;