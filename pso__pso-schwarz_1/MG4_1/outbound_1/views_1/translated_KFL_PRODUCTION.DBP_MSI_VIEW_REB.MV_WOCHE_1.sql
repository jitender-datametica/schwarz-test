CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_woche_1 (kjwo, gjwo, kjwo_vj, gjwo_vj, akt_wo_kalendarisch,
akt_wo, kj, gj) AS SELECT kjwo,
 gjwo,
 kjwo_vj,
 gjwo_vj,
 akt_wo_kalendarisch,
 akt_wo,
 ROUND(CAST(SUBSTR(TRIM(SUBSTR(CAST(kjwo AS STRING), 1, 10)), 0, 4) AS BIGNUMERIC), 0) AS kj,
 ROUND(CAST(SUBSTR(TRIM(SUBSTR(CAST(gjwo AS STRING), 1, 10)), 0, 4) AS BIGNUMERIC), 0) AS gj
FROM kfl_production_dbp_view.v_woche_1
WHERE kjwo > 200152;