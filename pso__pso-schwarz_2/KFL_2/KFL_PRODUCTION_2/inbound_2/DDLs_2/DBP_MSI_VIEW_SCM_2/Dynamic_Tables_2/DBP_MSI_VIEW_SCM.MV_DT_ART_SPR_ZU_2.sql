create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_DT_ART_SPR_ZU_2(
	MANDANT_ID,
	ART_ID,
	ART_BEZ,
	ART_BEZ_DE,
	ART_BEZ_CZ,
	ART_BEZ_SK,
	ART_BEZ_HR,
	ART_BEZ_PL,
	ART_BEZ_RO,
	ART_BEZ_BG
) target_lag = '1 hour' refresh_mode = AUTO initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_LOG
 as
SELECT 
    v01.mandant_id
  , v01.art_id
  , MAX(CASE WHEN v01.art_id = -1 THEN 'Alle (DIF)' WHEN spr_id =  22 THEN art_bez END) AS art_bez                 
  , MAX(CASE WHEN v01.art_id = -1 THEN 'Alle (DIF)' WHEN spr_id =  22 THEN art_bez END) AS art_bez_de                          
  , COALESCE(MAX(CASE WHEN spr_id = 124 THEN art_bez END), art_bez_de) AS art_bez_cz    
  , COALESCE(MAX(CASE WHEN spr_id = 108 THEN art_bez END), art_bez_de) AS art_bez_sk    
  , COALESCE(MAX(CASE WHEN spr_id =  65 THEN art_bez END), art_bez_de) AS art_bez_hr    
  , COALESCE(MAX(CASE WHEN spr_id =  90 THEN art_bez END), art_bez_de) AS art_bez_pl    
  , COALESCE(Max(CASE WHEN spr_id =  95 THEN art_bez END), art_bez_de) AS art_bez_ro    
  , COALESCE(Max(CASE WHEN spr_id =  18 THEN art_bez END), art_bez_de) AS art_bez_bg    
FROM DBP_VIEW.v_art_spr_zu_2 v01
GROUP BY 
    v01.mandant_id
  , v01.art_id
 UNION
 SELECT 
    v01.mandant_id
  , -3 AS art_id
  , 'n/a' AS art_bez                 
  , 'n/a' AS art_bez_de                          
  , 'n/a' AS art_bez_cz    
  , 'n/a' AS art_bez_sk   
  , 'n/a' AS art_bez_hr   
  , 'n/a' AS art_bez_pl   
  , 'n/a' AS art_bez_ro    
  , 'n/a' AS art_bez_bg    
FROM DBP_VIEW.v_mandant_2 v01
GROUP BY 
    v01.mandant_id
;
