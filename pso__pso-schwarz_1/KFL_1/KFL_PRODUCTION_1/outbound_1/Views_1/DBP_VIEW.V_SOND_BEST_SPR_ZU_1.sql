CREATE OR REPLACE VIEW kfl_production_dbp_view.v_sond_best_spr_zu_1 AS SELECT mandant_id,
 sond_best_id,
 spr_id,
 sond_best_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.sond_best_spr_zu_1;