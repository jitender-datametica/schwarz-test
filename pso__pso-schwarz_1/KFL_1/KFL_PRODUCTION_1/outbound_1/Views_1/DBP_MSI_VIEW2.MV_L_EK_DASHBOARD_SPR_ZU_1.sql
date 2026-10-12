CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_ek_dashboard_spr_zu_1 AS SELECT 1 AS ek_dashboard_id,
 '3.11.16.01 Saison Reporting MIT WA-Kalk' AS ek_dashboard_name
UNION ALL
SELECT 2 AS ek_dashboard_id,
 '3.11.16.02 Saison Reporting OHNE WA-Kalk' AS ek_dashboard_name
UNION ALL
SELECT 3 AS ek_dashboard_id,
 '3.11.16.01 Saison Reporting MIT WA-Kalk Ostern' AS ek_dashboard_name
UNION ALL
SELECT 4 AS ek_dashboard_id,
 '3.11.16.02 Saison Reporting OHNE WA-Kalk Ostern' AS ek_dashboard_name
UNION ALL
SELECT 5 AS ek_dashboard_id,
 '3.11.16.03 Tagesreporting NonFood' AS ek_dashboard_name
UNION ALL
SELECT 6 AS ek_dashboard_id,
 '3.11.16.04 ZEK_1 Reporting' AS ek_dashboard_name
UNION ALL
SELECT 7 AS ek_dashboard_id,
 '3.11.16.05 AVQ Sasion Reporting' AS ek_dashboard_name;