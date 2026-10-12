CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_it_gremium AS SELECT it_gremium_id,
 it_gremium_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_it_gremium;