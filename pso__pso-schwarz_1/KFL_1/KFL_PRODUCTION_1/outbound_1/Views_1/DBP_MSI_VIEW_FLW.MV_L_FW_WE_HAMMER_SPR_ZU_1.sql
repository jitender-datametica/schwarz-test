CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_fw_we_hammer_spr_zu_1 (fw_we_hammer_id, mandant_id,
fw_we_hammer_bez) AS SELECT V01.fw_we_hammer_id,
 V01.mandant_id,
 V01.fw_we_hammer_bez
FROM kfl_production_dbp_view.v_fw_we_hammer_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.mandant_id IN (1, 2);