CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_PRODH_LVL_1_SPR_ZU_1
-- 26.09.2011 AL neu erstelt
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
AS

   SELECT
   v01.mandant_id, v01.spr_id, v01.art_col_auspr  AS prodh_lvl_1, v01.art_col_bez     AS prodh_lvl_1_bez

   FROM dbp_view.v_flw_art_col_spr_zu_1 v01
   WHERE flw_art_col_id =1;