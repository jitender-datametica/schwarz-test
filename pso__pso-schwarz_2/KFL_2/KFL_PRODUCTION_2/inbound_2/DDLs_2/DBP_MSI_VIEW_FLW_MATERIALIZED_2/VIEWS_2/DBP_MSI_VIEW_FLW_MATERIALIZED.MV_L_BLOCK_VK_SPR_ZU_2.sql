create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_BLOCK_VK_SPR_ZU_2(
	MUKI_BLOCK_VK_ID,
	MANDANT_ID,
	MUKI_BLOCK_VK_BEZ
) as
SELECT
   muki_block_vk_id,
   mandant_id,
   muki_block_vk_bez
FROM
   DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_L_BLOCK_VK_SPR_ZU_2 v01
   INNER JOIN dbp_msi.akt_msi_user_spr_zu_2 v03 ON v01.spr_id = v03.spr_id;