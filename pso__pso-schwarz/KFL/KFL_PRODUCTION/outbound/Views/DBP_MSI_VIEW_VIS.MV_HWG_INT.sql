CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_hwg_int (arthiertyp_id, hwg_id, abt_id, sort_id, orig_sort_id
) AS SELECT arthiertyp_id,
 hwg_id,
 abt_id,
 CAST(CASE
   WHEN hwg_id > 0
   THEN CASE
     WHEN abt_id = 4
     THEN 10000
     ELSE abt_id * 1000
     END + hwg_id
   ELSE CASE
     WHEN abt_id = 4
     THEN 10000
     ELSE abt_id * 1000
     END - hwg_id * 10
   END AS BIGNUMERIC) AS sort_id,
   CASE
   WHEN abt_id = 4
   THEN 10000
   ELSE abt_id * 1000
   END + CAST(CASE
    WHEN hwg_id > 0
    THEN hwg_id
    ELSE hwg_id * - 10
    END AS BIGNUMERIC) AS orig_sort_id
FROM kfl_production_dbp_view.v_hwg_per AS HWG
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31'
GROUP BY arthiertyp_id,
 hwg_id,
 abt_id,
 sort_id,
 orig_sort_id;