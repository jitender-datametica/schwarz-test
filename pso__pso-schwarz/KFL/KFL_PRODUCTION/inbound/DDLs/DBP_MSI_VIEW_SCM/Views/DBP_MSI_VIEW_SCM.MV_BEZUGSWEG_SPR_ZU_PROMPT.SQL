CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_BEZUGSWEG_SPR_ZU_PROMPT(
	BEZUGSWEG_ID,
	BEZUGSWEG_BEZ,
	BEZUGSWEG_BEZ_DE,
	BEZUGSWEG_BEZ_CZ,
	BEZUGSWEG_BEZ_SK,
	BEZUGSWEG_BEZ_HR,
	BEZUGSWEG_BEZ_PL,
	BEZUGSWEG_BEZ_RO,
	BEZUGSWEG_BEZ_BG
) AS
--2023-02-13,dknop, AP0162072, initial
   SELECT
   v01.bezugsweg_id, MAX(CASE WHEN  v01.spr_id =  22 THEN  v01.bezugsweg_bez END) AS bezugsweg_bez                 
   , MAX(CASE WHEN  v01.spr_id =  22 THEN  v01.bezugsweg_bez END) AS bezugsweg_bez_de                          
   , COALESCE(MAX(CASE WHEN  v01.spr_id = 124 THEN  v01.bezugsweg_bez END), bezugsweg_bez_de) AS bezugsweg_bez_cz    
   , COALESCE(MAX(CASE WHEN  v01.spr_id = 108 THEN  v01.bezugsweg_bez END), bezugsweg_bez_de) AS bezugsweg_bez_sk    
   , COALESCE(MAX(CASE WHEN  v01.spr_id =  65 THEN  v01.bezugsweg_bez END), bezugsweg_bez_de) AS bezugsweg_bez_hr    
   , COALESCE(MAX(CASE WHEN  v01.spr_id =  90 THEN  v01.bezugsweg_bez END), bezugsweg_bez_de) AS bezugsweg_bez_pl    
   , COALESCE(MAX(CASE WHEN  v01.spr_id =  95 THEN  v01.bezugsweg_bez END), bezugsweg_bez_de) AS bezugsweg_bez_ro    
   , COALESCE(MAX(CASE WHEN  v01.spr_id =  18 THEN  v01.bezugsweg_bez END), bezugsweg_bez_de) AS bezugsweg_bez_bg    
   FROM dbp_view.v_bezugsweg_spr_zu  v01
   JOIN DBP_VIEW.v_mandant_spr_zu v02 
   ON v01.mandant_id = v02.mandant_id
   AND v01.spr_id = v02.spr_id
   GROUP BY v01.bezugsweg_id;