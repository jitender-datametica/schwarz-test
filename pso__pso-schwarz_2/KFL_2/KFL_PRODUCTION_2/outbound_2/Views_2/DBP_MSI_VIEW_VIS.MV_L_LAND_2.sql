CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_land_2 AS SELECT CAST(CASE
   WHEN CAST(mandant_id AS BIGNUMERIC) = 1
   THEN mandant_sort_id + 1
   ELSE mandant_sort_id + 2
   END AS BIGNUMERIC) AS land_sort_id,
 CAST(mandant_id AS BIGNUMERIC) AS land_id,
 CAST(mandant_id AS BIGNUMERIC) AS mandant_id
FROM kfl_production_dbp_view.v_mandant_2 AS V01
UNION ALL
SELECT 1,
 - 1,
 CAST(mandant_id AS BIGNUMERIC)
FROM kfl_production_dbp_view.v_mandant_2 AS V02
UNION ALL
SELECT 3 AS dm__operand0,
 - 2 AS dm__operand1,
 CAST(mandant_id AS BIGNUMERIC) AS dm__operand2
FROM kfl_production_dbp_view.v_mandant_2 AS V03
WHERE mandant_id NOT IN (1);