CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_woche_kj_kl_2 AS SELECT kjwo_kl,
 kjwo_kl_dat_von,
 kjwo_kl_dat_bis,
 akt_kjwo_kl,
 akt_kjwo_kl_komplett,
 akt_kj,
 akt_kj_komplett,
 CAST(FLOOR(kjwo_kl / 100) AS INTEGER) AS kj,
 kjwo,
 akt_wo
FROM kfl_production_dbp_view.v_woche_kj_kl_2 AS V01;