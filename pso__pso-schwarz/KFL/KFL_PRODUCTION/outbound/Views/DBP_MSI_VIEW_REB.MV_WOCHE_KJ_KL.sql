CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_woche_kj_kl (kjwo_kl, kjwo_kl_dat_von, kjwo_kl_dat_bis,
akt_kjwo_kl, akt_kjwo_kl_komplett, akt_kj, akt_kj_komplett, kjwo, kj, akt_wo) AS SELECT kjwo_kl,
 kjwo_kl_dat_von,
 kjwo_kl_dat_bis,
 akt_kjwo_kl,
 akt_kjwo_kl_komplett,
 akt_kj,
 akt_kj_komplett,
 kjwo,
 ROUND(CAST(TRUNC(CAST(kjwo_kl / 100 AS BIGNUMERIC)) AS BIGNUMERIC), 0) AS kj,
 akt_wo
FROM kfl_production_dbp_view.v_woche_kj_kl
WHERE kjwo_kl > 200153;