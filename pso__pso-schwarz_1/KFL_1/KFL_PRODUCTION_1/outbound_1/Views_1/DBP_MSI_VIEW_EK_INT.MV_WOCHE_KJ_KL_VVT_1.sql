CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_woche_kj_kl_vvt_1 AS SELECT kjwo_kl,
 kjwo_kl_dat_von,
 kjwo_kl_dat_bis,
 akt_kjwo_kl,
 akt_kjwo_kl_komplett,
 akt_kj,
 akt_kj_komplett,
 kjwo,
 akt_wo
FROM kfl_production_dbp_msi_view_ek_int.mv_tag_1
GROUP BY kjwo_kl,
 kjwo_kl_dat_von,
 kjwo_kl_dat_bis,
 akt_kjwo_kl,
 akt_kjwo_kl_komplett,
 akt_kj,
 akt_kj_komplett,
 kjwo,
 akt_wo;