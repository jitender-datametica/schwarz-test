CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_owg_int_1 (arthiertyp_id, owg_id, hwg_id, sort_id, orig_sort_id
) AS SELECT arthiertyp_id,
 owg_id,
 hwg_id,
 CAST(CASE
   WHEN owg_id > 0
   THEN ABS(hwg_id * 100000) + owg_id
   ELSE ABS(hwg_id * 100000) - owg_id * 10
   END AS BIGNUMERIC) AS sort_id,
   hwg_id * 100 - CAST(owg_id - 1000 AS BIGNUMERIC) AS orig_sort_id
FROM kfl_production_dbp_view.v_owg_per_1 AS OWG
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31'
GROUP BY arthiertyp_id,
 owg_id,
 hwg_id,
 sort_id,
 orig_sort_id;