-- prescherad SPEC0142410 erweitern um wo_dat_von und wo_dat_bis


CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_woche (kjwo, gjwo, kjwo_vj, kjwo_vvj, gjwo_vj, wo_dat_von,
wo_dat_bis, akt_wo_kalendarisch, akt_wo, kj, gj) AS SELECT kjwo,
 gjwo,
 kjwo_vj,
 kjwo_vvj,
 gjwo_vj,
 wo_dat_von,
 wo_dat_bis,
 akt_wo_kalendarisch,
 akt_wo,
 ROUND(CAST(SUBSTR(TRIM(SUBSTR(CAST(kjwo AS STRING), 1, 39)), 0, 4) AS BIGNUMERIC), 0) AS kj,
 ROUND(CAST(SUBSTR(TRIM(SUBSTR(CAST(gjwo AS STRING), 1, 39)), 0, 4) AS BIGNUMERIC), 0) AS gj
FROM kfl_production_dbp_view.v_woche
WHERE kjwo > 200152;