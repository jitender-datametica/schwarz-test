CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_scm.mv_dt_gp_counts_2
 AS
SELECT mandant_id,
 art_id,
 dat_ab AS dat_von,
 dat_bis,
 min_platzierung_markt_cluster_id,
 dat_beladung,
 COUNT(DISTINCT gp_id) AS gp_count
FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_2 AS V01
WHERE dat_beladung = CURRENT_DATE
GROUP BY mandant_id,
 art_id,
 dat_von,
 dat_bis,
 dat_beladung,
 min_platzierung_markt_cluster_id;