CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_flw_transport_plombe_1 (mandant_id, tour_id, plombe_id,
dat_plombe_aenderung) AS SELECT mandant_id,
 tour_id,
 plombe_id,
 dat_plombe_aenderung
FROM kfl_production_dbp_view.v_flw_transport_plombe_1;