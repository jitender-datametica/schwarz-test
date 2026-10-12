CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_artkz_eigenmarke (eigenmarke_id, eigenmarke_bez) AS SELECT
 eigenmarke_id,
  CASE
  WHEN eigenmarke_id = 'S'
  THEN 'SPIRITUOSEN;BIER'
  ELSE eigenmarke_bez
  END AS eigenmarke_bez
FROM kfl_production_dbp_view.v_artkz_eigenmarke
WHERE mandant_id = 1;