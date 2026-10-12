CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_artkz_leist_2 (leist_id, leist_bez, mandant_id, spr_id) AS SELECT
  CASE
  WHEN leist_id = ''
  THEN 'keine'
  ELSE leist_id
  END AS leist_id,
 leist_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_artkz_leist_2
WHERE mandant_id = 1
 AND leist_id NOT IN ('N', 'N2', 'N3', 'O1', 'O2', 'O3', 'WA', 'WB', 'WC', 'WD');