CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_sond_best AS SELECT mandant_id,
 sond_best_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_sond_best;