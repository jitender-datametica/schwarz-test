CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_transport_plombe AS SELECT mandant_id,
 tour_id,
 plombe_id,
 dat_plombe_aenderung,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_transport_plombe;