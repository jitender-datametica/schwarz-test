CREATE OR REPLACE VIEW kfl_production_dbp_view.v_bonuskauf_spr_zu AS SELECT bonuskauf_id,
 spr_id,
 mandant_id,
 bonuskauf_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.bonuskauf_spr_zu;