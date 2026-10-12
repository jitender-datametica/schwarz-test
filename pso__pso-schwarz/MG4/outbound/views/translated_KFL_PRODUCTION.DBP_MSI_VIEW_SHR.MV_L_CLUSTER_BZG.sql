CREATE OR REPLACE VIEW dbp_msi_view_shr.mv_l_cluster_bzg (betriebszugehoerigkeit_cluster_sort_id,
betriebszugehoerigkeit_cluster_bez) AS SELECT 1 AS betriebszugehoerigkeit_cluster_sort_id,
 'keine Stammdaten' AS betriebszugehoerigkeit_cluster_bez
UNION ALL
SELECT 0 AS betriebszugehoerigkeit_cluster_sort_id,
 'neg. BZG' AS betriebszugehoerigkeit_cluster_bez
UNION ALL
SELECT 2 AS betriebszugehoerigkeit_cluster_sort_id,
 '<= 3 Monate' AS betriebszugehoerigkeit_cluster_bez
UNION ALL
SELECT 3 AS betriebszugehoerigkeit_cluster_sort_id,
 '3-6 Monate' AS betriebszugehoerigkeit_cluster_bez
UNION ALL
SELECT 4 AS betriebszugehoerigkeit_cluster_sort_id,
 '6-12 Monate' AS betriebszugehoerigkeit_cluster_bez
UNION ALL
SELECT 5 AS betriebszugehoerigkeit_cluster_sort_id,
 '1-3 Jahre' AS betriebszugehoerigkeit_cluster_bez
UNION ALL
SELECT 6 AS betriebszugehoerigkeit_cluster_sort_id,
 'über 3 Jahre' AS betriebszugehoerigkeit_cluster_bez;