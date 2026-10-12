CREATE OR REPLACE VIEW kfl_production_dbp_view.v_hl_2 (hl_id, mandant_id, hl_name) AS SELECT hl_id,
 mandant_id,
 hl_name
FROM kfl_production_dbp_data.hl_2;