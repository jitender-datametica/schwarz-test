CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_BLOCK_VK_SPR_ZU 
-- 08.01.2014 twie: Sprachtabelle fuer Mutter-Kind Block, von AIS_DE uebernommen
--19.09.2018 naku:  WG Umstellung und Anpassungen: Alte wg_id durch neue ersetzt
(
   muki_block_vk_id,
   mandant_id,
   muki_block_vk_bez
) AS
SELECT
   muki_block_vk_id,
   mandant_id,
   muki_block_vk_bez
FROM
   DBP_MSI_VIEW_FLW.TBL_MV_L_BLOCK_VK_SPR_ZU v01
   INNER JOIN dbp_msi.akt_msi_user_spr_zu v03 ON v01.spr_id = v03.spr_id
;