create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_SAISON_SPR_ZU_PROMPT_1(
	SAISON_ID,
	SAISON_BEZ,
	SAISON_BEZ_DE,
	SAISON_BEZ_CZ,
	SAISON_BEZ_SK,
	SAISON_BEZ_HR,
	SAISON_BEZ_PL,
	SAISON_BEZ_RO,
	SAISON_BEZ_BG
) as
--2023-02-13,dknop, AP0162072, initial
   SELECT
   v01.saison_id, MAX(CASE WHEN v01.spr_id=22 THEN v01.saison_bez END ) AS saison_bez                                              
   , MAX(CASE WHEN v01.spr_id=22 THEN v01.saison_bez END) AS saison_bez_de                                 
   , COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.saison_bez END), saison_bez_de) AS saison_bez_cz    
   , COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.saison_bez END), saison_bez_de) AS saison_bez_sk    
   , COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.saison_bez END), saison_bez_de) AS saison_bez_hr     
   , COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.saison_bez END), saison_bez_de) AS saison_bez_pl      
   , COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.saison_bez END), saison_bez_de) AS saison_bez_ro     
   , COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.saison_bez END), saison_bez_de) AS saison_bez_bg    
   FROM dbp_view.v_saison_spr_zu_1 v01 
   JOIN DBP_VIEW.v_mandant_spr_zu_1 v02 
   ON v01.mandant_id = v02.mandant_id
   AND v01.spr_id = v02.spr_id
   GROUP BY v01.saison_id;