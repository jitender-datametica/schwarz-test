CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_teku_monat_monat_kum_zu_1 AS SELECT kjmo,
 kjmo AS kjmo_prompt,
 1 AS kum_id
FROM kfl_production_dbp_view.v_monat_1
WHERE gj >= 2012
 AND akt_gj <= 1
UNION ALL
SELECT T1.kjmo,
 T2.kjmo AS kjmo_prompt,
 2 AS kum_id
FROM kfl_production_dbp_view.v_monat_1 AS T1_1
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS T2 ON T1.gj = T2.gj AND T1.kjmo <= T2.kjmo
WHERE T1.gj >= 2012
 AND T1.akt_gj <= 1;