CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_land_spr_zu_cz_2 (land_id, land_bez, land_iso, eu_land_fg) AS
SELECT land_id,
 land_bez,
 land_iso,
 eu_land_fg
FROM kfl_production_dbp_view.v_land_2 AS V01
WHERE mandant_id = 2;