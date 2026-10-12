CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_gp_fehlerart (system_id, mandant_id, gp_fehlerart_id) AS
SELECT 7 AS system_id,
 mandant_id,
  CASE
  WHEN gp_fehlerart_id = ''
  THEN '0'
  ELSE gp_fehlerart_id
  END AS gp_fehlerart_id
FROM kfl_production_dbp_view.v_l_gp_fehlerart
WHERE mandant_id = 1;