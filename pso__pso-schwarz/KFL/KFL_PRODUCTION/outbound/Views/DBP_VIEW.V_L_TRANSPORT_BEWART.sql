CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_transport_bewart AS SELECT mandant_id,
 lvs_bewart_id,
 lagernummer_id,
 wup_id,
 nb_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_transport_bewart;