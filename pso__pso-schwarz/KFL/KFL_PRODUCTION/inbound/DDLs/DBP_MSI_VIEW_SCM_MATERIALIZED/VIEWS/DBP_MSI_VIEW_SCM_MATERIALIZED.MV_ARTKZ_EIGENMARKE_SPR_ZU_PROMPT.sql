create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ARTKZ_EIGENMARKE_SPR_ZU_PROMPT(
	EIGENMARKE_ID,
	EIGENMARKE_BEZ,
	EIGENMARKE_BEZ_DE,
	EIGENMARKE_BEZ_CZ,
	EIGENMARKE_BEZ_SK,
	EIGENMARKE_BEZ_HR,
	EIGENMARKE_BEZ_PL,
	EIGENMARKE_BEZ_RO,
	EIGENMARKE_BEZ_BG
) as
--2023-02-13,dknop, AP0162072, initial
   SELECT
   v01.eigenmarke_id, MAX(CASE WHEN v01.spr_id=22 THEN v01.eigenmarke_bez END ) AS eigenmarke_bez                                         
   , MAX(CASE WHEN v01.spr_id=22 THEN v01.eigenmarke_bez END) AS eigenmarke_bez_de                                 
   , COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.eigenmarke_bez END), eigenmarke_bez_de) AS eigenmarke_bez_cz    
   , COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.eigenmarke_bez END), eigenmarke_bez_de) AS eigenmarke_bez_sk    
   , COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.eigenmarke_bez END), eigenmarke_bez_de) AS eigenmarke_bez_hr     
   , COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.eigenmarke_bez END), eigenmarke_bez_de) AS eigenmarke_bez_pl      
   , COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.eigenmarke_bez END), eigenmarke_bez_de) AS eigenmarke_bez_ro     
   , COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.eigenmarke_bez END), eigenmarke_bez_de) AS eigenmarke_bez_bg    
   FROM dbp_view.v_artkz_eigenmarke v01
   JOIN DBP_VIEW.v_mandant_spr_zu v02 
   ON v01.mandant_id = v02.mandant_id
   AND v01.spr_id = v02.spr_id
   GROUP BY v01.eigenmarke_id;