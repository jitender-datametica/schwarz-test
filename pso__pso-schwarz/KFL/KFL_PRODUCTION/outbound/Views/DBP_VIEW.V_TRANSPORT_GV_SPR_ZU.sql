CREATE OR REPLACE VIEW kfl_production_dbp_view.v_transport_gv_spr_zu AS SELECT mandant_id,
 transport_gv_id,
 spr_id,
 transport_gv_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.transport_gv_spr_zu;