CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_PRODH_LVL_3_SPR_ZU
-- 26.09.2011 AL neu erstelt
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
AS 
SELECT
   v01.mandant_id, v01.spr_id, v01.art_col_auspr  AS prodh_lvl_3, v01.art_col_bez     AS prodh_lvl_3_bez

   FROM dbp_view.v_flw_art_col_spr_zu v01
   WHERE flw_art_col_id =3;