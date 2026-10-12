CREATE OR REPLACE VIEW kfl_production_dbp_view.v_woche_kj_kl AS SELECT kjwo_kl,
 kjwo_kl_dat_von,
 kjwo_kl_dat_bis,
 akt_kjwo_kl,
 akt_kjwo_kl_komplett,
 akt_kj,
 akt_kj_komplett,
 kjwo,
 akt_wo,
 td_insert,
 td_update
FROM kfl_production_dbp_data.woche_kj_kl;