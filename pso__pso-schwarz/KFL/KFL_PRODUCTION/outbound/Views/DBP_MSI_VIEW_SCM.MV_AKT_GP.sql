CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_akt_gp (mandant_id, akt_gp_id, akt_gp_name) AS SELECT
 mandant_id,
 gp_id AS akt_gp_id,
 gp_name AS akt_gp_name
FROM kfl_production_dbp_view.v_gp AS V01;