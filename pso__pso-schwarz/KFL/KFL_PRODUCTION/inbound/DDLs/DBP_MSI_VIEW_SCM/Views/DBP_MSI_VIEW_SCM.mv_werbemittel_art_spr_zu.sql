--Werbemittel Art Spr Zu

CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_werbemittel_art_spr_zu(
	WERBEMITTEL_ART_ID,
	WERBEMITTEL_ART_BEZ,
	WERBEMITTEL_ART_BEZ_DE,
	WERBEMITTEL_ART_BEZ_CZ,
	WERBEMITTEL_ART_BEZ_SK,
	WERBEMITTEL_ART_BEZ_HR,
	WERBEMITTEL_ART_BEZ_PL,
	WERBEMITTEL_ART_BEZ_RO,
	WERBEMITTEL_ART_BEZ_BG
) AS

   SELECT DISTINCT
 
    werbemittel_art_id
   , MAX(CASE WHEN spr_id =  22 THEN werbemittel_art_bez END) AS werbemittel_art_bez                 
   , MAX(CASE WHEN spr_id =  22 THEN werbemittel_art_bez END) AS werbemittel_art_bez_de                          
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN werbemittel_art_bez END), werbemittel_art_bez_de) AS werbemittel_art_bez_cz    
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN werbemittel_art_bez END), werbemittel_art_bez_de) AS werbemittel_art_bez_sk    
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN werbemittel_art_bez END), werbemittel_art_bez_de) AS werbemittel_art_bez_hr    
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN werbemittel_art_bez END), werbemittel_art_bez_de) AS werbemittel_art_bez_pl    
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN werbemittel_art_bez END), werbemittel_art_bez_de) AS werbemittel_art_bez_ro    
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN werbemittel_art_bez END), werbemittel_art_bez_de) AS werbemittel_art_bez_bg    
   FROM dbp_view.v_werbemittel_art_spr_zu  v01

   GROUP BY
   v01.werbemittel_art_id;