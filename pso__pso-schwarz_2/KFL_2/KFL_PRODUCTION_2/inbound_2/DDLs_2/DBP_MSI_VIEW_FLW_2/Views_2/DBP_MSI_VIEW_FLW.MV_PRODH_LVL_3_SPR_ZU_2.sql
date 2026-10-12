CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_PRODH_LVL_3_SPR_ZU_2
-- 26.09.2011 AL neu erstelt
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen 
AS 
SELECT
   v01.mandant_id, v01.spr_id, prodh_lvl_3, prodh_lvl_3_bez

   FROM DBP_MSI_VIEW_FLW.TBL_MV_PRODH_LVL_3_SPR_ZU_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id
;