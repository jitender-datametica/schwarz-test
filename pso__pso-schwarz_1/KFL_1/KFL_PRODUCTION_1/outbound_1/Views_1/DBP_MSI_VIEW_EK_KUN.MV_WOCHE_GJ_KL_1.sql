CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_woche_gj_kl_1 (gjwo_kl, gjwo_kl_dat_von, gjwo_kl_dat_bis,
akt_gjwo_kl, akt_gjwo_kl_komplett, akt_gj, gj, akt_gj_komplett) AS SELECT gjwo_kl,
 gjwo_kl_dat_von,
 gjwo_kl_dat_bis,
 akt_gjwo_kl,
 akt_gjwo_kl_komplett,
 akt_gj,
 SUBSTR(CAST(gjwo_kl AS STRING), 1, 4) AS gj,
 akt_gj_komplett
FROM kfl_production_dbp_data.woche_gj_kl_1
WHERE gjwo_kl > 200153;