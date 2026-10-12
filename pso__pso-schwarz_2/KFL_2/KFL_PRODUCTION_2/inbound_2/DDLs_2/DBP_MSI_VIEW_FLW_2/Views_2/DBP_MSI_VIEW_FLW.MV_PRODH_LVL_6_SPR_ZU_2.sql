CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_PRODH_LVL_6_SPR_ZU_2
-- 26.09.2011 AL neu erstelt
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(

mandant_id
,spr_id
,prodh_lvl_6
,prodh_lvl_6_bez
)
AS

   SELECT
   v01.mandant_id, v01.spr_id, v01.art_col_auspr  AS prodh_lvl_6, v01.art_col_bez     AS prodh_lvl_6_bez

   FROM dbp_view.v_flw_art_col_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id

   WHERE flw_art_col_id =6;