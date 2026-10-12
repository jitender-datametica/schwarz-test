CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tp_l_objekt_1 AS SELECT mandant_id,
 tp_objekt_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.tp_l_objekt_1;