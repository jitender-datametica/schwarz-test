CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_hl_1 (hl_id, hl_name, mandant_id) AS SELECT hl_id,
 hl_name,
 mandant_id
FROM kfl_production_dbp_view.v_hl_1
WHERE mandant_id = 1;