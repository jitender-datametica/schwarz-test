CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_PRODH_LVL_2_2
-- 26.09.2011 AL neu erstelt
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(

mandant_id
,prodh_lvl_2
)
AS

   SELECT
   mandant_id, art_col_auspr  AS prodh_lvl_2

   FROM dbp_view.v_flw_l_art_col_2
   WHERE flw_art_col_id =2;