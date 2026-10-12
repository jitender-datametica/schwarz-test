CREATE OR REPLACE VIEW kfl_production_dbp_view.v_cos_bonuskauf_status_spr_zu (mandant_id, bonuskauf_status_id, spr_id,
bonuskauf_status_bez) AS SELECT mandant_id,
 bonuskauf_status_id,
 spr_id,
 bonuskauf_status_bez
FROM kfl_production_dbp_data.cos_bonuskauf_status_spr_zu;