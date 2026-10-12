CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_land_1 AS SELECT CAST(CASE
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
   END AS BIGNUMERIC) AS land_sort_id,
 mandant_id AS land_id,
 mandant_bez AS land_bez,
 default_wrg AS wrg_id_land
FROM kfl_production_dbp_view.v_mandant_1
UNION ALL
SELECT 1 AS land_sort_id,
 - 1 AS land_id,
 'INT' AS land_bez,
 'EUR' AS wrg_id_land
UNION ALL
SELECT 3 AS land_sort_id,
 - 2 AS land_id,
 'Ausland' AS land_bez,
 'EUR' AS wrg_id_land;