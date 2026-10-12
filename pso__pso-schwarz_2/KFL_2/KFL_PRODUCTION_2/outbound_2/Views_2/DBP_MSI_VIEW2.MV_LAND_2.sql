CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_land_2 (land_bez, land_iso, eu_land_fg, land_id) AS SELECT land_bez
 ,
 land_iso,
 eu_land_fg,
 land_id
FROM kfl_production_dbp_view.v_land_2
WHERE mandant_id = 1
 AND land_id = 'DE';