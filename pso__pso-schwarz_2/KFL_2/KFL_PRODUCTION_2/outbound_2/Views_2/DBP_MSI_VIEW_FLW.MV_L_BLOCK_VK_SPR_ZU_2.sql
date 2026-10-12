CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_block_vk_spr_zu_2 (muki_block_vk_id, mandant_id,
muki_block_vk_bez) AS SELECT V01.muki_block_vk_id,
 V01.mandant_id,
 V01.muki_block_vk_bez
FROM kfl_production_dbp_msi_view_flw.tbl_mv_l_block_vk_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V03 ON V01.spr_id = V03.spr_id;