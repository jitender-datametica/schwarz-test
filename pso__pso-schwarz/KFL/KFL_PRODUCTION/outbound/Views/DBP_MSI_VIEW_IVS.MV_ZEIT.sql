CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_zeit AS SELECT gj,
 akt_gj,
 akt_gj_komplett,
 kj,
 kjmo,
 akt_mo,
 akt_mo_komplett,
 MIN(dat) AS kjmo_dat_von,
 MAX(dat) AS kjmo_dat_bis
FROM kfl_production_dbp_view.v_tag AS T0
GROUP BY gj,
 akt_gj,
 akt_gj_komplett,
 kj,
 kjmo,
 akt_mo,
 akt_mo_komplett;