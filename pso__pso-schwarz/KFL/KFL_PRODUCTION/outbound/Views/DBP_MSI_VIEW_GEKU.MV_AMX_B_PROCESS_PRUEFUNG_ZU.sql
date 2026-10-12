CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_b_process_pruefung_zu (business_process_id, pruefung_id,
amx_system_id) AS SELECT business_process_id,
 pruefung_id,
 amx_system_id
FROM kfl_production_dbp_view.v_amx_b_process_pruefung_zu
UNION DISTINCT
SELECT business_process_id,
 pruefung_id,
 1 AS amx_system_id
FROM kfl_production_dbp_view.v_amx_de_b_process_pruefung_zu;