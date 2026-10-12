CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wg_int_2 AS SELECT arthiertyp_id,
 wg_id,
 owg_id,
   owg_id * 10000 + CAST(wg_id AS BIGNUMERIC) AS sort_id
FROM kfl_production_dbp_view.v_wg_per_2 AS WG
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31'
GROUP BY arthiertyp_id,
 wg_id,
 owg_id,
 sort_id;