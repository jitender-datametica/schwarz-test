CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_land_art_2 (land_bez, land_iso, eu_land_fg, land_id) AS SELECT
 land_bez,
 land_iso,
 eu_land_fg,
 land_id
FROM kfl_production_dbp_view.v_land_2 AS V01
WHERE mandant_id = 1;