CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_phasenart AS SELECT phasenart_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_phasenart;