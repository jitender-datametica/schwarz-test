-- Werbemittel Spr_2 Zu

CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_werbemittel_spr_zu_2(
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
) AS
  -- 20220427 richternic: Eindeutiger Schluessel Werbemittel_id + Werbemittel_Art_id
-- AP0251869 dknop, werbemittel_art_id was changed to werbemittelkanal_id
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
   FROM dbp_view.v_werbemittel_spr_zu_2  v01

   GROUP BY
   v01.werbemittel_id, v01.werbemittelkanal_id;
