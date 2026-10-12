create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_OWG_SPR_ZU_2(
	OWG_ID,
	MANDANT_ID,
	OWG_BEZ,
	OWG_BEZ_DE,
	OWG_BEZ_CZ,
	OWG_BEZ_SK,
	OWG_BEZ_HR,
	OWG_BEZ_PL,
	OWG_BEZ_RO,
	OWG_BEZ_BG
) as
   SELECT
   v01.owg_id, v01.mandant_id, COALESCE(MAX(CASE WHEN v02.spr_id =  22 THEN v02.owg_bez END),'N/A') AS owg_bez                                                             
   , COALESCE(MAX(CASE WHEN v02.spr_id =  22 THEN v02.owg_bez END),'N/A') AS owg_bez_de                                                     
   , COALESCE(MAX(CASE WHEN v02.spr_id = 124 THEN v02.owg_bez END), owg_bez_de) AS owg_bez_cz  
   , COALESCE(MAX(CASE WHEN v02.spr_id = 108 THEN v02.owg_bez END), owg_bez_de) AS owg_bez_sk 
   , COALESCE(MAX(CASE WHEN v02.spr_id =  65  THEN v02.owg_bez END), owg_bez_de) AS owg_bez_hr    
   , COALESCE(MAX(CASE WHEN v02.spr_id =  90  THEN v02.owg_bez END), owg_bez_de) AS owg_bez_pl    
   , COALESCE(MAX(CASE WHEN v02.spr_id =  95  THEN v02.owg_bez END), owg_bez_de) AS owg_bez_ro   
   , COALESCE(MAX(CASE WHEN v02.spr_id =  18  THEN v02.owg_bez END), owg_bez_de) AS owg_bez_bg  

   FROM dbp_view.v_owg_per_2 v01
   INNER JOIN dbp_view.v_owg_spr_zu_2 v02
   ON
   v02.owg_id = v01.owg_id

   WHERE CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis

   GROUP BY 1,2;