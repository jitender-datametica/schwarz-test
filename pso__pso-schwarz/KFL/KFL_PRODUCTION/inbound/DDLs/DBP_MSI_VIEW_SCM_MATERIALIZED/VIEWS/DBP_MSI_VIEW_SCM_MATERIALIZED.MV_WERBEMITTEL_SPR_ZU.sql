create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_WERBEMITTEL_SPR_ZU(
	WERBEMITTEL_ID,
	WERBEMITTEL_ART_ID,
	WERBEMITTEL_BEZ,
	WERBEMITTEL_BEZ_DE,
	WERBEMITTEL_BEZ_CZ,
	WERBEMITTEL_BEZ_SK,
	WERBEMITTEL_BEZ_HR,
	WERBEMITTEL_BEZ_PL,
	WERBEMITTEL_BEZ_RO,
	WERBEMITTEL_BEZ_BG
) as
  

   SELECT DISTINCT
   v01.werbemittel_id
   ,v01.werbemittelkanal_id AS werbemittel_art_id
   , MAX(CASE WHEN spr_id =  22 THEN werbemittel_bez END) AS werbemittel_bez                 
   , MAX(CASE WHEN spr_id =  22 THEN werbemittel_bez END) AS werbemittel_bez_de                          
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN werbemittel_bez END), werbemittel_bez_de) AS werbemittel_bez_cz    
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN werbemittel_bez END), werbemittel_bez_de) AS werbemittel_bez_sk    
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN werbemittel_bez END), werbemittel_bez_de) AS werbemittel_bez_hr    
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN werbemittel_bez END), werbemittel_bez_de) AS werbemittel_bez_pl    
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN werbemittel_bez END), werbemittel_bez_de) AS werbemittel_bez_ro    
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN werbemittel_bez END), werbemittel_bez_de) AS werbemittel_bez_bg    
   FROM dbp_view.v_werbemittel_spr_zu  v01

   GROUP BY
   v01.werbemittel_id, v01.werbemittelkanal_id;