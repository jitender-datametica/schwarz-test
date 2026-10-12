CREATE OR REPLACE VIEW kfl_production_dbp_view.v_woche_gj_kl (gjwo_kl, gjwo_kl_dat_von, gjwo_kl_dat_bis, akt_gjwo_kl,
akt_gjwo_kl_komplett, akt_gj, akt_gj_komplett) AS SELECT gjwo_kl,
 gjwo_kl_dat_von,
 gjwo_kl_dat_bis,
 akt_gjwo_kl,
 akt_gjwo_kl_komplett,
 akt_gj,
 akt_gj_komplett
FROM kfl_production_dbp_data.woche_gj_kl;