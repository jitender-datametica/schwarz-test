CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_akt_gp_1 (mandant_id, akt_gp_id, akt_gp_name, akt_land_id) AS
SELECT mandant_id,
 gp_id AS akt_gp_id,
 gp_name AS akt_gp_name,
 land_id AS akt_land_id
FROM kfl_production_dbp_view.v_gp_1 AS V01;