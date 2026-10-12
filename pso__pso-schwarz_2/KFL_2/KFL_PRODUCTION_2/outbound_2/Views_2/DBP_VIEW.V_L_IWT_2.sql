CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_iwt_2 AS SELECT mandant_id,
 iwt_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_iwt_2;