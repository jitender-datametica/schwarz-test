CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.TBL_MV_L_BLOCK_VK
   AS 
   SELECT
   v01.mandant_id,
   v01.art_id AS muki_block_vk_id,
   TO_VARCHAR(v01.kl_art_id, 'FM00000000') muki_block_vk_kl_id_lang,
   v02.art_bez AS muki_block_vk_bez,
   CASE
  WHEN (v01.mutter_vk_id IS NULL)
  THEN 'W'
  ELSE 'M' END AS muki_block_kz_vk_id,
   CASE
  WHEN muki_block_kz_vk_id = 'M'
  THEN muki_block_vk_kl_id_lang
  ELSE ' ' END AS muki_block_vk_id_SAL,
v02.spr_id
  FROM dbp_view.v_art v01

   JOIN dbp_view.v_art_spr_zu v02
   ON v01.art_id=v02.art_id
   AND v01.mandant_id=v02.mandant_id

   WHERE v01.mandant_id <> 1
   AND (v01.mutter_vk_id IS NULL OR v01.mutter_vk_id = v01.art_id)
   AND v01.dat_bis = '9999-12-31';