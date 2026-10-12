CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_fwws_wup_pc AS SELECT V01.mandant_id,
 V01.nb_id,
 V01.wup_id,
 V01.problemcode_id,
 V01.kjmo,
 SUM(V01.anz_fehler) AS anz_fehler,
 SUM(SUM(V01.anz_fehler)) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), CAST(V01.wup_id AS STRING), CAST(V01.nb_id AS STRING)
    , V01.problemcode_id, CAST(V02.gj AS STRING) ORDER BY V01.kjmo IS NULL, V01.kjmo ROWS BETWEEN UNBOUNDED PRECEDING
  AND CURRENT ROW) AS anz_fehler_kum
FROM kfl_production_dbp_msi_v_view.v_vis_monat_gp_wup_probleme AS V01
 INNER JOIN kfl_production_dbp_view.v_monat AS V02 ON V01.kjmo = V02.kjmo
GROUP BY V01.mandant_id,
 V01.nb_id,
 V01.wup_id,
 V01.problemcode_id,
 V01.kjmo,
 V02.gj;