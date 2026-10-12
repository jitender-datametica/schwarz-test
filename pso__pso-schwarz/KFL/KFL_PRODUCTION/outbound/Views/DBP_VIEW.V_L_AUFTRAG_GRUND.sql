CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_auftrag_grund AS SELECT mandant_id,
 auftrag_grund_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_auftrag_grund;