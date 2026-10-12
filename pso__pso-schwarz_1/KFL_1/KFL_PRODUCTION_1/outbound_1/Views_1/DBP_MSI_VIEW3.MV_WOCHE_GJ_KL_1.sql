CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_woche_gj_kl_1 (gjwo_kl, gjwo_kl_dat_von, gjwo_kl_dat_bis,
akt_gjwo_kl, akt_gjwo_kl_komplett, gj, akt_gj, akt_gj_komplett) AS SELECT gjwo_kl,
 gjwo_kl_dat_von,
 gjwo_kl_dat_bis,
 akt_gjwo_kl,
 akt_gjwo_kl_komplett,
 CAST(gjwo_kl / 100 AS BIGNUMERIC) AS gj,
 akt_gj,
 akt_gj_komplett
FROM kfl_production_dbp_view.v_woche_gj_kl_1
WHERE gjwo_kl > 200153;