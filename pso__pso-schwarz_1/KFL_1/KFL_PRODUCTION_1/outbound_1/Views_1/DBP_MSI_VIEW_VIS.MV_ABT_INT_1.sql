CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_abt_int_1 (arthiertyp_id, abt_id, sort_id, orig_sort_id) AS
SELECT arthiertyp_id,
 CAST(CASE
   WHEN abt_id < 5
   THEN 1000 - abt_id
   ELSE abt_id
   END AS BIGNUMERIC) AS abt_id,
 CAST(CASE
   WHEN abt_id = 0
   THEN 100
   WHEN abt_id = 4
   THEN 10
   ELSE abt_id
   END AS BIGNUMERIC) AS sort_id,
 CAST(CASE
   WHEN abt_id < 5
   THEN 1000 - abt_id
   ELSE abt_id
   END AS BIGNUMERIC) AS orig_sort_id
FROM kfl_production_dbp_view.v_abt_per_1 AS ABT_1
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31'
GROUP BY arthiertyp_id,
 ABT.abt_id,
 sort_id,
 orig_sort_id;