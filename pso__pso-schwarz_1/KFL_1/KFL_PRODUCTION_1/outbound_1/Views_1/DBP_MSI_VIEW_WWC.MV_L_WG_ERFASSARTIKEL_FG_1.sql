CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_wg_erfassartikel_fg_1 (wg_art_fg, wg_art_fg_bez) AS SELECT 1
 AS wg_art_fg,
 'WG Erfassartikel' AS wg_art_fg_bez
FROM kfl_production_dbp_view.v_mandant_1
WHERE mandant_id = 1
UNION ALL
SELECT 0 AS wg_art_fg,
 'kein WG Erfassartikel' AS wg_art_fg_bez
FROM kfl_production_dbp_view.v_mandant_1
WHERE mandant_id = 1;