CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_woche_1 (gjwo, gjwo_vj, kjwo, kjwo_vj, kjwo_vvj, wo_dat_von,
wo_dat_bis, akt_wo, akt_wo_komplett) AS SELECT V01.gjwo,
 V01.gjwo_vj,
 V01.kjwo,
 V01.kjwo_vj,
 V01.kjwo_vvj,
 V01.wo_dat_von,
 V01.wo_dat_bis,
 V01.akt_wo,
 V01.akt_wo_komplett
FROM kfl_production_dbp_view.v_woche_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS V02 ON V01.kjwo = V02.kjwo
WHERE V02.akt_kj BETWEEN - 3 AND 3
GROUP BY V01.gjwo,
 V01.gjwo_vj,
 V01.kjwo,
 V01.kjwo_vj,
 V01.kjwo_vvj,
 V01.wo_dat_von,
 V01.wo_dat_bis,
 V01.akt_wo,
 V01.akt_wo_komplett;