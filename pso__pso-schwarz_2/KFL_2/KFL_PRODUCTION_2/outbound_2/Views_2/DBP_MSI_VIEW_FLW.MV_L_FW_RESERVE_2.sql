CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_fw_reserve_2 (fw_reserve_id, mandant_id) AS SELECT
 fw_reserve_id,
 mandant_id
FROM kfl_production_dbp_view.v_l_fw_reserve_2 AS V01
WHERE mandant_id IN (1, 2);