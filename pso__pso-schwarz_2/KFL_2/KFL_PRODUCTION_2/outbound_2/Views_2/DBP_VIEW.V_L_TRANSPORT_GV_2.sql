CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_transport_gv_2 AS SELECT mandant_id,
 transport_gv_id,
 abrechnung_basiseinheit_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_transport_gv_2;