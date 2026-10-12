CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_gp_2 (gp_id, mandant_id, gp_name, dat_von, dat_bis) AS SELECT
 gp_id,
 mandant_id,
  CASE
  WHEN gp_id >= 1
  THEN gp_name
  ELSE NULL
  END AS gp_name,
 dat_von,
 dat_bis
FROM kfl_production_dbp_view.v_gp_2 AS V01;