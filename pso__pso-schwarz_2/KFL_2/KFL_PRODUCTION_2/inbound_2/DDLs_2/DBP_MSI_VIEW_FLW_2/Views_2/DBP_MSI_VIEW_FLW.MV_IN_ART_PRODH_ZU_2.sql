CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_IN_ART_PRODH_ZU_2
-- 26.09.2011 AL neu erstelt
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 22.01.2018 TWIE: SPEC0019330 alle Stufen kombiniert in einem Attribut anzeigen

(
mandant_id
,in_art_id
,prodh_lvl_1
,prodh_lvl_2
,prodh_lvl_3
,prodh_lvl_4
,prodh_lvl_5
,prodh_lvl_6
,prodh_kompl
)
AS

   SELECT
   mandant_id, flw_art_id AS in_art_id, MAX(CASE WHEN flw_art_col_id=1 THEN art_col_auspr ELSE NULL END ) prodh_lvl_1, MAX(CASE WHEN flw_art_col_id=2 THEN art_col_auspr ELSE NULL END ) prodh_lvl_2, MAX(CASE WHEN flw_art_col_id=3 THEN art_col_auspr ELSE NULL END ) prodh_lvl_3, MAX(CASE WHEN flw_art_col_id=4 THEN art_col_auspr ELSE NULL END ) prodh_lvl_4, MAX(CASE WHEN flw_art_col_id=5 THEN art_col_auspr ELSE NULL END ) prodh_lvl_5, MAX(CASE WHEN flw_art_col_id=6 THEN art_col_auspr ELSE NULL END ) prodh_lvl_6, CAST(prodh_lvl_1 AS CHAR(5)) || CAST(prodh_lvl_2 AS CHAR(2)) || CAST(prodh_lvl_3 AS CHAR(2)) || CAST(prodh_lvl_4 AS CHAR(2)) || CAST(prodh_lvl_5 AS CHAR(2)) || CAST(prodh_lvl_6 AS CHAR(2)) AS prodh_kompl
   FROM dbp_view.v_flw_art_col_zu_2
   GROUP BY mandant_id,
   flw_art_id;