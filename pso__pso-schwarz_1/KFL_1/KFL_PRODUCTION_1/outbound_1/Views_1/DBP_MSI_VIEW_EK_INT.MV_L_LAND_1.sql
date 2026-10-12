CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_l_land_1 AS SELECT CAST(mandant_id AS BIGNUMERIC) AS land_id
 ,
 CAST(mandant_id AS BIGNUMERIC) AS mandant_id,
 CAST(CASE
   WHEN mandant_id = 1
   THEN 2
   WHEN mandant_id = 2
   THEN 4
   WHEN mandant_id = 5
   THEN 5
   WHEN mandant_id = 6
   THEN 6
   WHEN mandant_id = 3
   THEN 7
   WHEN mandant_id = 7
   THEN 8
   WHEN mandant_id = 8
   THEN 9
   WHEN mandant_id = 4
   THEN 10
   ELSE NULL
   END AS BIGNUMERIC) AS land_sort_id
FROM kfl_production_dbp_view.v_mandant_1 AS V01
UNION ALL
SELECT - 1 AS land_id,
 CAST(mandant_id AS BIGNUMERIC) AS mandant_id,
 1 AS land_sort_id
FROM kfl_production_dbp_view.v_mandant_1 AS V02
UNION ALL
SELECT - 2 AS land_id,
 CAST(mandant_id AS BIGNUMERIC) AS mandant_id,
 3 AS land_sort_id
FROM kfl_production_dbp_view.v_mandant_1 AS V03
WHERE mandant_id NOT IN (1);