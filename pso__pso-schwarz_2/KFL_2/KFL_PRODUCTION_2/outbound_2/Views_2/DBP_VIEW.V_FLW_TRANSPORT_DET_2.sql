CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_transport_det_2 AS SELECT mandant_id,
 tour_id,
 komm_bereich_id,
 kunde_grp_id,
 flw_kunde_id,
 lkw_postyp_id,
 anz_stellplatz_ist,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_transport_det_2;