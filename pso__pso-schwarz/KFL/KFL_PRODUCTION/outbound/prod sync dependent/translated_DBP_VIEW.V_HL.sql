CREATE OR REPLACE VIEW kfl_production_dbp_view.v_hl (hl_id, mandant_id, hl_name) AS SELECT hl_id,
 mandant_id,
 hl_name
FROM kfl_production_dbp_data.hl;