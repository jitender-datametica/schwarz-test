CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_anz_tage_cluster_1 (anz_tage_aktion, cluster_dauer_id,
cluster_dauer_desc) AS SELECT DISTINCT A_W.anz_tage_aktion,
 A_W.cluster_dauer_id,
 C_DESC.cluster_dauer_desc
FROM kfl_production_dbp_data.avq_werbung_1 AS A_W
 INNER JOIN kfl_production_dbp_msi_view_scm.mv_cluster_dauer_spr_zu_1 AS C_DESC ON A_W.cluster_dauer_id = C_DESC.cluster_dauer_id;