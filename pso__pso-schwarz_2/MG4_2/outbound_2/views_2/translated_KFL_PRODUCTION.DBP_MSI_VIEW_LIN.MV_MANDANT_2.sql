CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_mandant_2 (mandant_id, mandant_bez, mandant_kbez,
mandant_sort_id, default_wrg) AS SELECT mandant_id,
 mandant_bez,
  CASE
  WHEN mandant_id = 1
  THEN 'DE'
  ELSE mandant_kbez
  END AS mandant_kbez,
 mandant_sort_id,
 default_wrg
FROM kfl_production_dbp_view.v_mandant_2 AS v01;