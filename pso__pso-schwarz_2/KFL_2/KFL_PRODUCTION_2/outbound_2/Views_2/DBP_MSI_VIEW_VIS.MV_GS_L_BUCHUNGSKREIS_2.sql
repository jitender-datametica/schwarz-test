CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_gs_l_buchungskreis_2 AS SELECT mandant_id,
 buchungskreis_id,
 system_id
FROM kfl_production_dbp_view.v_l_buchungskreis_2 AS V01
WHERE mandant_id = 1 AND system_id = 2
 OR mandant_id = 2 AND system_id = 53
 OR mandant_id = 5 AND system_id = 51
 OR mandant_id = 6 AND system_id = 54
 OR mandant_id = 3 AND system_id = 55
 OR mandant_id = 7 AND system_id = 13
 OR mandant_id = 8 AND system_id = 12
 OR mandant_id = 4 AND system_id = 13
UNION ALL
SELECT mandant_id,
 0 AS buchungskreis_id,
 CAST(CASE
   WHEN mandant_id = 1
   THEN 2
   WHEN mandant_id = 2
   THEN 53
   WHEN mandant_id = 5
   THEN 51
   WHEN mandant_id = 6
   THEN 54
   WHEN mandant_id = 3
   THEN 55
   WHEN mandant_id = 7
   THEN 13
   WHEN mandant_id = 8
   THEN 12
   WHEN mandant_id = 4
   THEN 13
   ELSE NULL
   END AS BIGNUMERIC) AS system_id
FROM kfl_production_dbp_view.v_mandant_2 AS V01;