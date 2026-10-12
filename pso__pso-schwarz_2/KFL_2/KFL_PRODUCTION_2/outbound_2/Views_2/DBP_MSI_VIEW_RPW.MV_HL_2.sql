CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_hl_2 (hl_id, hl_name, mandant_id, system_id) AS SELECT hl_id,
 hl_name,
 mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_hl_2
WHERE mandant_id = 1;