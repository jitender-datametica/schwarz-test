CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_WG_SPR_ZU AS 
-- 05.08.2018, AP0021792, mkub1811: OWG Umstellung
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   wg_id,
   v01.spr_id,
   arthiertyp_id,
   mandant_id,
   wg_bez,
   wg_id_bez
FROM
   DBP_MSI_VIEW3.tbl_MV_WG_SPR_ZU v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id
WHERE
   v01.arthiertyp_id = 2
   AND v01.wg_id >= -3 --17.07.10: Filterung der Korrektur- WG aus VIS/MIS;;;
;