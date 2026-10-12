create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_L_CLUSTER_BZG_2(
	BETRIEBSZUGEHOERIGKEIT_CLUSTER_SORT_ID,
	BETRIEBSZUGEHOERIGKEIT_CLUSTER_BEZ
) as
   SELECT *
   FROM (SELECT * FROM (SELECT 1 AS betriebszugehoerigkeit_cluster_sort_id, 'keine Stammdaten' AS betriebszugehoerigkeit_cluster_bez) x
   UNION ALL
   SELECT * FROM (SELECT 0 AS betriebszugehoerigkeit_cluster_sort_id, 'neg. BZG' AS betriebszugehoerigkeit_cluster_bez) x
   UNION ALL
   SELECT * FROM (SELECT 2 AS betriebszugehoerigkeit_cluster_sort_id, '<= 3 Monate'AS betriebszugehoerigkeit_cluster_bez) x
   UNION ALL
   SELECT * FROM (SELECT 3 AS betriebszugehoerigkeit_cluster_sort_id, '3-6 Monate' AS betriebszugehoerigkeit_cluster_bez) x
   UNION ALL
   SELECT * FROM (SELECT 4 AS betriebszugehoerigkeit_cluster_sort_id, '6-12 Monate' AS betriebszugehoerigkeit_cluster_bez) x
   UNION ALL
   SELECT * FROM (SELECT 5 AS betriebszugehoerigkeit_cluster_sort_id, '1-3 Jahre' AS betriebszugehoerigkeit_cluster_bez) x
   UNION ALL
   SELECT * FROM (SELECT 6 AS betriebszugehoerigkeit_cluster_sort_id, 'über 3 Jahre' AS betriebszugehoerigkeit_cluster_bez) x
   ) t;