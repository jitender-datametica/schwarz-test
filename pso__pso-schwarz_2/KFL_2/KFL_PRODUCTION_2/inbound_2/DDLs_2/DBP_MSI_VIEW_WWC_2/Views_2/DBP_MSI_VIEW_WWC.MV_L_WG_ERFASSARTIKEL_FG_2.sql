CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_WG_ERFASSARTIKEL_FG_2
(
wg_art_fg
,wg_art_fg_bez
)
AS

   SELECT
   CAST(1 AS BYTEINT) AS wg_art_fg, CAST('WG Erfassartikel' AS VARCHAR(21)) AS wg_art_fg_bez
   FROM dbp_view.v_mandant_2
   WHERE mandant_id = 1

   UNION ALL

   SELECT
   CAST(0 AS BYTEINT) AS wg_art_fg, CAST('kein WG Erfassartikel' AS VARCHAR(21)) AS wg_art_fg_bez
   FROM dbp_view.v_mandant_2
   WHERE mandant_id = 1;