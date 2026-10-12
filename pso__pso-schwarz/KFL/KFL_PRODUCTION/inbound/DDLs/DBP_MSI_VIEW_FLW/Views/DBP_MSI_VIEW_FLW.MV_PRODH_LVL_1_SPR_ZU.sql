CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_PRODH_LVL_1_SPR_ZU
-- 26.09.2011 AL neu erstelt
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
as 
SELECT
   v01.mandant_id, v01.spr_id, prodh_lvl_1,  prodh_lvl_1_bez

   FROM DBP_MSI_VIEW_FLW.tbl_MV_PRODH_LVL_1_SPR_ZU v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id
;