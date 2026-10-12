CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_abt_2 AS SELECT mandant_id,
 arthiertyp_id,
 abt_id,
  CASE
  WHEN abt_id <= 0
  THEN abt_id + 1000
  ELSE abt_id
  END AS sort_id
FROM kfl_production_dbp_view.v_abt_2 AS V01
WHERE arthiertyp_id = 2;