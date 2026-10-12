CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_artkz_leist_1 (leist_id, leist_bez, mandant_id, spr_id) AS
SELECT CASE
  WHEN leist_id = ''
  THEN 'keine'
  ELSE leist_id
  END AS leist_id,
 leist_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_artkz_leist_1
WHERE mandant_id = 1
 AND spr_id = 22
 AND leist_id NOT IN ('N', 'N2', 'N3', 'O1', 'O2', 'O3', 'WA', 'WB', 'WC', 'WD');