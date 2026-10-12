CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_fw_wk_system_spr_zu_2 (fw_wk_system_id,
mandant_id, fw_wk_system_bez) AS SELECT V01.fw_wk_system_id,
 V01.mandant_id,
 V01.fw_wk_system_bez
FROM kfl_production_dbp_view.v_fw_wk_system_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.mandant_id IN (1, 2);