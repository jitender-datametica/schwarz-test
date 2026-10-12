CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_l_block_vk_spr_zu (muki_block_vk_id, mandant_id,
muki_block_vk_bez, spr_id) AS SELECT V01.art_id AS muki_block_vk_id,
 V01.mandant_id,
 V02.art_bez AS muki_block_vk_bez,
 V02.spr_id
FROM kfl_production_dbp_view.v_art AS V01
 INNER JOIN kfl_production_dbp_view.v_art_spr_zu AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS V04 ON V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id
   
WHERE (V01.mutter_vk_id IS NULL OR V01.mutter_vk_id = V01.art_id)
 AND V01.dat_bis = DATE '9999-12-31'
 AND V01.mandant_id IN (1, 2)
 AND V04.dat_bis = DATE '9999-12-31'
 AND V04.arthiertyp_id = 2
 AND V04.wg_id IN (3, 122, 128, 134, 135, 136, 137, 138, 139, 141, 142, 144, 145, 146, 147, 158, 159, 184, 186, 232, 233
   , 234, 235, 236, 237, 238, 239, 331, 242, 243, 244, 245, 246);