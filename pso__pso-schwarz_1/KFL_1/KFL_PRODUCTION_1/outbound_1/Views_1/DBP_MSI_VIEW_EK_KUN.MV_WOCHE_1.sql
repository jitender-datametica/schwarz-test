CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_woche_1 AS SELECT gjwo,
 gjwo_vj,
 kjwo,
 kjwo_vj,
 wo_dat_von,
 wo_dat_bis,
 akt_wo,
 akt_wo_komplett,
 akt_wo_kalendarisch
FROM kfl_production_dbp_view.v_woche_1;