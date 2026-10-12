CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_cluster_dauer_spr_zu_2 (cluster_dauer_id, cluster_dauer_desc) AS
SELECT 1 AS cluster_dauer_id,
 '1-Tages-Aktion_2 Montag' AS cluster_dauer_desc
UNION ALL
SELECT 2 AS cluster_dauer_id,
 '1-Tages-Aktion_2 Dienstag' AS cluster_dauer_desc
UNION ALL
SELECT 3 AS cluster_dauer_id,
 '1-Tages-Aktion_2 Mittwoch' AS cluster_dauer_desc
UNION ALL
SELECT 4 AS cluster_dauer_id,
 '1-Tages-Aktion_2 Donnerstag' AS cluster_dauer_desc
UNION ALL
SELECT 5 AS cluster_dauer_id,
 '1-Tages-Aktion_2 Freitag' AS cluster_dauer_desc
UNION ALL
SELECT 6 AS cluster_dauer_id,
 '1-Tages-Aktion_2 Samstag' AS cluster_dauer_desc
UNION ALL
SELECT 7 AS cluster_dauer_id,
 '1-Tages-Aktion_2 Sonntag' AS cluster_dauer_desc
UNION ALL
SELECT 8 AS cluster_dauer_id,
 'Wochenstart' AS cluster_dauer_desc
UNION ALL
SELECT 9 AS cluster_dauer_id,
 'Wochenende' AS cluster_dauer_desc
UNION ALL
SELECT 10 AS cluster_dauer_id,
 'Wochenwerbung' AS cluster_dauer_desc
UNION ALL
SELECT 11 AS cluster_dauer_id,
 'Aktion_2 > 9 Tage' AS cluster_dauer_desc
UNION ALL
SELECT 12 AS cluster_dauer_id,
 'Mid-Week' AS cluster_dauer_desc
UNION ALL
SELECT 99 AS cluster_dauer_id,
 'Sonstiges' AS cluster_dauer_desc;