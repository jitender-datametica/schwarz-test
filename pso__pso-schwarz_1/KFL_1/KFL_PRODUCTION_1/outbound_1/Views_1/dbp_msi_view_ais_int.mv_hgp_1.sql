CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_hgp_1 (hgp_id, hgp_name, mandant_id, zek_id) AS SELECT
DISTINCT gp_id AS hgp_id,
 gp_name AS hgp_name,
 mandant_id,
 zek_id
FROM kfl_production_dbp_view.v_gp_1
WHERE gp_id IN (SELECT hgp_id
   FROM kfl_production_dbp_view.v_gp_1);