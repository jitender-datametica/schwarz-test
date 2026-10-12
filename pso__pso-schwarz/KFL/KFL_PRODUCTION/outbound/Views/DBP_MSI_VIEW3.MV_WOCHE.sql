CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_woche (kjwo, gjwo, kjwovj, gjwovj, kjwovvj, gjwovvj, wo_dat_von,
wo_dat_bis, akt_wo, akt_wo_komplett, akt_wo_kalendarisch) AS SELECT kjwo,
 gjwo,
  kjwo - 100 AS kjwovj,
  gjwo - 100 AS gjwovj,
  kjwo - 200 AS kjwovvj,
  gjwo - 200 AS gjwovvj,
 wo_dat_von,
 wo_dat_bis,
 akt_wo,
 akt_wo_komplett,
 akt_wo_kalendarisch
FROM kfl_production_dbp_view.v_woche
WHERE kjwo > 200449;