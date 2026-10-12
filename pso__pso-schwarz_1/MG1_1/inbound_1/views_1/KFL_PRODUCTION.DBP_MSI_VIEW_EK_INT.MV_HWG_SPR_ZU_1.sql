create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_HWG_SPR_ZU_1(
	HWG_ID,
	ARTHIERTYP_ID,
	HWG_BEZ,
	HWG_BEZ_DE,
	HWG_BEZ_CZ,
	HWG_BEZ_SK,
	HWG_BEZ_HR,
	HWG_BEZ_PL,
	HWG_BEZ_RO,
	HWG_BEZ_BG
) as

   SELECT
   v01.hwg_id, v01.arthiertyp_id, COALESCE(MAX(CASE WHEN v02.spr_id =  22 THEN v02.hwg_bez END),'N/A') AS hwg_bez                                                             
   , COALESCE(MAX(CASE WHEN v02.spr_id =  22 THEN v02.hwg_bez END),'N/A') AS hwg_bez_de                                                     
   , COALESCE(MAX(CASE WHEN v02.spr_id = 124 THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_cz  
   , COALESCE(MAX(CASE WHEN v02.spr_id = 108 THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_sk 
   , COALESCE(MAX(CASE WHEN v02.spr_id =  65  THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_hr    
   , COALESCE(MAX(CASE WHEN v02.spr_id =  90  THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_pl    
   , COALESCE(MAX(CASE WHEN v02.spr_id =  95  THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_ro   
   , COALESCE(MAX(CASE WHEN v02.spr_id =  18  THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_bg  

   FROM dbp_view.v_hwg_per_1 v01
   INNER JOIN dbp_view.v_hwg_spr_zu_1 v02
   ON v02.mandant_id = v01.mandant_id
   AND v02.hwg_id = v01.hwg_id

   WHERE CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis

   group by 1,2;