CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_gs_buchungskreis_2 AS SELECT mandant_id,
 system_id,
 buchungskreis_id,
 MAX(buchungskreis_bez) AS buchungskreis_bez,
 CAST(CASE
   WHEN mandant_id = 1
   THEN 22
   WHEN mandant_id = 2
   THEN 124
   WHEN mandant_id = 5
   THEN 108
   WHEN mandant_id = 6
   THEN 65
   WHEN mandant_id = 3
   THEN 90
   WHEN mandant_id = 7
   THEN 95
   WHEN mandant_id = 8
   THEN 18
   WHEN mandant_id = 4
   THEN 95
   ELSE NULL
   END AS BIGNUMERIC) AS spr_id
FROM kfl_production_dbp_view.v_buchungskreis_spr_zu_2 AS V01
WHERE mandant_id = 1 AND system_id = 2
 OR mandant_id = 2 AND system_id = 53
 OR mandant_id = 5 AND system_id = 51
 OR mandant_id = 6 AND system_id = 54
 OR mandant_id = 3 AND system_id = 55
 OR mandant_id = 7 AND system_id = 13
 OR mandant_id = 8 AND system_id = 12
 OR mandant_id = 4 AND system_id = 13
GROUP BY mandant_id,
 buchungskreis_id,
 system_id
UNION ALL
SELECT mandant_id,
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
   END AS BIGNUMERIC) AS system_id,
 0 AS buchungskreis_id,
 'nicht zugeordnet' AS buchungskreis_bez,
 CAST(CASE
   WHEN mandant_id = 1
   THEN 22
   WHEN mandant_id = 2
   THEN 124
   WHEN mandant_id = 5
   THEN 108
   WHEN mandant_id = 6
   THEN 65
   WHEN mandant_id = 3
   THEN 90
   WHEN mandant_id = 7
   THEN 95
   WHEN mandant_id = 8
   THEN 18
   WHEN mandant_id = 4
   THEN 95
   ELSE NULL
   END AS BIGNUMERIC) AS spr_id
FROM kfl_production_dbp_view.v_mandant_2 AS V01;