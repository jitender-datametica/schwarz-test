CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_shr_2 AS SELECT kj_ker_mo_id AS kjmo,
  akt_fruehinfo2 - 1 AS akt_mo_shr,
 akt_fruehinfo2,
 dat_fruehinfo2,
 akt_gj_buchungs_schluss
FROM kfl_production_dbp_view.v_l_buchungsstatus_ker_2;