CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_block_vk_ro (mandant_id, muki_block_vk_id,
muki_block_vk_kl_id, muki_block_vk_bez, muki_block_kz_vk_id) AS SELECT V01.mandant_id,
 V01.art_id AS muki_block_vk_id,
 V01.kl_art_id AS muki_block_vk_kl_id,
 V02.art_bez AS muki_block_vk_bez,
  CASE
  WHEN V01.mutter_vk_id IS NULL
  THEN 'W'
  ELSE 'M'
  END AS muki_block_kz_vk_id
FROM kfl_production_dbp_view.v_art AS V01
 INNER JOIN kfl_production_dbp_view.v_art_spr_zu AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
WHERE V02.spr_id = 95
 AND (V01.mutter_vk_id IS NULL OR V01.mutter_vk_id = V01.art_id)
 AND V01.dat_bis = DATE '9999-12-31';