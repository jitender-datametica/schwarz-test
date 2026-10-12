CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_flw_transport_det_1 (mandant_id, tour_id, komm_bereich_id,
kunde_grp_id, in_kunde_id, lkw_postyp_id, anz_stellplatz_ist) AS SELECT mandant_id,
 tour_id,
 komm_bereich_id,
 kunde_grp_id,
 flw_kunde_id AS in_kunde_id,
 lkw_postyp_id,
 anz_stellplatz_ist
FROM kfl_production_dbp_view.v_flw_transport_det_1;