CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_transport_bewart_1 (mandant_id, lvs_bewart_id, lagernummer_id,
wup_id, nb_id) AS SELECT mandant_id,
 lvs_bewart_id,
 lagernummer_id,
 wup_id,
 nb_id
FROM kfl_production_dbp_view.v_l_transport_bewart_1 AS V01;