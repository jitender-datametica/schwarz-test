CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_l_k_listung (k_listung, mandant_id) AS SELECT CASE
  WHEN sm_id = - 1
  THEN 'N/A'
  ELSE CAST(sm_id AS STRING)
  END AS k_listung,
 mandant_id
FROM kfl_production_dbp_view.v_sm
WHERE mandant_id = 1
 AND sm_id <> - 9
 AND sm_id < 6;