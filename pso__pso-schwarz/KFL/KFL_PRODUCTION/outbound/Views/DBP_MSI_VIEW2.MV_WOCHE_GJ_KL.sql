CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_woche_gj_kl (gjwo_kl, gjwo_kl_dat_von, gjwo_kl_dat_bis,
akt_gjwo_kl, akt_gjwo_kl_komplett, akt_gj, gj, akt_gj_komplett) AS SELECT gjwo_kl,
 gjwo_kl_dat_von,
 gjwo_kl_dat_bis,
 akt_gjwo_kl,
 akt_gjwo_kl_komplett,
 akt_gj,
 ROUND(CAST(SUBSTR(SUBSTR(CAST(CAST(gjwo_kl AS BIGNUMERIC) AS STRING), 1, 6), 1, 4) AS BIGNUMERIC), 0) AS gj,
 akt_gj_komplett
FROM kfl_production_dbp_view.v_woche_gj_kl
WHERE gjwo_kl > 200153;