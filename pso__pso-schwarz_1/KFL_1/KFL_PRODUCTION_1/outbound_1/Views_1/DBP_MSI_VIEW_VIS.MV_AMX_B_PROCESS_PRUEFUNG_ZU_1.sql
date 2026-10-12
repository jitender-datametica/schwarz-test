CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_b_process_pruefung_zu_1 (business_process_id, pruefung_id)
AS SELECT business_process_id,
 pruefung_id
FROM kfl_production_dbp_view.v_amx_b_process_pruefung_zu_1
WHERE amx_system_id = 1
 AND business_process_id = 544687
UNION ALL
SELECT business_process_id,
 pruefung_id
FROM kfl_production_dbp_view.v_amx_de_b_process_pruefung_zu_1
WHERE business_process_id = 544687;