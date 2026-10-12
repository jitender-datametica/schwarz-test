-- 01.02.2016 twie: kjwo_kl_vj entfernt
 CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_woche_gj_kl (gjwo_kl,
gjwo_kl_dat_von, gjwo_kl_dat_bis, akt_gjwo_kl, akt_gjwo_kl_komplett, akt_gj, gj, akt_gj_komplett) AS SELECT gjwo_kl,
 gjwo_kl_dat_von,
 gjwo_kl_dat_bis,
 akt_gjwo_kl,
 akt_gjwo_kl_komplett,
 akt_gj,
 SUBSTR(SUBSTR(CAST(CAST(gjwo_kl AS BIGNUMERIC) AS STRING), 1, 39), 1, 4) AS gj,
 akt_gj_komplett
FROM kfl_production_dbp_view.v_woche_gj_kl
WHERE gjwo_kl > 200153;