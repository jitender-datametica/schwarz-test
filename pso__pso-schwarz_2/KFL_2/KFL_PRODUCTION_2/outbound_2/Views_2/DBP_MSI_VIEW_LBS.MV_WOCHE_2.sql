CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_woche_2 (gjwo, gjwo_vj, kjwo, kjwo_vj, kjwo_vvj, wo_dat_von,
wo_dat_bis, akt_wo, akt_wo_komplett, akt_wo_kalendarisch) AS SELECT gjwo,
 gjwo_vj,
 kjwo,
 kjwo_vj,
 kjwo_vvj,
 wo_dat_von,
 wo_dat_bis,
 akt_wo,
 akt_wo_komplett,
 akt_wo_kalendarisch
FROM kfl_production_dbp_view.v_woche_2;