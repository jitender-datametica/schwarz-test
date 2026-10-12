CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_woche_kj_kl_2 (kjwo_kl, kjwo_kl_dat_von, kjwo_kl_dat_bis,
akt_kjwo_kl, akt_kjwo_kl_komplett, kj, akt_kj, akt_kj_komplett) AS SELECT kjwo_kl,
 kjwo_kl_dat_von,
 kjwo_kl_dat_bis,
 akt_kjwo_kl,
 akt_kjwo_kl_komplett,
 SUBSTR(SUBSTR(CAST(CAST(kjwo_kl AS BIGNUMERIC) AS STRING), 1, 6), 1, 4) AS kj,
 akt_kj,
 akt_kj_komplett
FROM kfl_production_dbp_view.v_woche_kj_kl_2
WHERE kjwo_kl > 200153;