CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_cos_bonuskauf_status (mandant_id, bonuskauf_status_id) AS SELECT
 mandant_id,
 bonuskauf_status_id
FROM kfl_production_dbp_data.l_cos_bonuskauf_status;