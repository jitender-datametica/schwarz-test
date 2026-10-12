create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ARTIKELTYP_SPR_ZU_PROMPT_1(
	ARTIKELTYP_ID,
	ARTIKELTYP_BEZ,
	ARTIKELTYP_BEZ_DE,
	ARTIKELTYP_BEZ_CZ,
	ARTIKELTYP_BEZ_SK,
	ARTIKELTYP_BEZ_HR,
	ARTIKELTYP_BEZ_PL,
	ARTIKELTYP_BEZ_RO,
	ARTIKELTYP_BEZ_BG
) as
--2023-02-13,dknop, AP0162072, initial
   SELECT
     v01.artikeltyp_id
   , MAX(CASE WHEN v01.spr_id=22 THEN v01.artikeltyp_bez END ) AS artikeltyp_bez                                         
   , MAX(CASE WHEN v01.spr_id=22 THEN v01.artikeltyp_bez END) AS artikeltyp_bez_de                                 
   , COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_cz    
   , COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_sk    
   , COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_hr     
   , COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_pl      
   , COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_ro     
   , COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_bg    
   FROM dbp_view.v_artikeltyp_spr_zu_1 v01

     JOIN DBP_VIEW.v_mandant_spr_zu_1 v02 
  ON v01.mandant_id = v02.mandant_id
  AND v01.spr_id = v02.spr_id
  GROUP BY v01.artikeltyp_id;