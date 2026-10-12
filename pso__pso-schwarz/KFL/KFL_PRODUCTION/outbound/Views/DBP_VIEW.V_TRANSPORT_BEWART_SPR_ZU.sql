CREATE OR REPLACE VIEW kfl_production_dbp_view.v_transport_bewart_spr_zu AS SELECT mandant_id,
 lvs_bewart_id,
 lagernummer_id,
 spr_id,
 lvs_bewart_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.transport_bewart_spr_zu;