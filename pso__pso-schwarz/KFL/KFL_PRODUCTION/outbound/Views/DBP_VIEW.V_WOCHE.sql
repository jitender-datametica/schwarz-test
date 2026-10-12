CREATE OR REPLACE VIEW kfl_production_dbp_view.v_woche AS SELECT gjwo,
 gjwo_vj,
 kjwo,
 kjwo_vj,
 kjwo_vvj,
 wo_dat_von,
 wo_dat_bis,
 akt_wo,
 akt_wo_komplett,
 akt_wo_kalendarisch,
 td_update,
 td_insert
FROM kfl_production_dbp_data.woche;