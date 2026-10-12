CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_verkaufsorganisation_1 AS SELECT mandant_id,
 verkaufsorganisation_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_verkaufsorganisation_1;