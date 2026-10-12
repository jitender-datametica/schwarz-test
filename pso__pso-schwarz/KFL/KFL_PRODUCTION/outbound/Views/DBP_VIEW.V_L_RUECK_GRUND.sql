CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_rueck_grund AS SELECT rueck_grund_id,
 mandant_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_rueck_grund;