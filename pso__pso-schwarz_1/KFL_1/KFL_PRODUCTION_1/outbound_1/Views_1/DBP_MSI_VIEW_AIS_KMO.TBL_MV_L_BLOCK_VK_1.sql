CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_l_block_vk_1 AS SELECT V01.mandant_id,
 V01.art_id AS muki_block_vk_id,
 TRIM(CAST(V01.kl_art_id AS STRING FORMAT '00000000')) AS muki_block_vk_kl_id_lang,
 V02.art_bez AS muki_block_vk_bez,
  CASE
  WHEN V01.mutter_vk_id IS NULL
  THEN 'W'
  ELSE 'M'
  END AS muki_block_kz_vk_id,
  CASE
  WHEN CASE
    WHEN V01.mutter_vk_id IS NULL
    THEN 'W'
    ELSE 'M'
    END = 'M'
  THEN TRIM(CAST(V01.kl_art_id AS STRING FORMAT '00000000'))
  ELSE ' '
  END AS muki_block_vk_id_sal,
 V02.spr_id
FROM kfl_production_dbp_view.v_art_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_spr_zu_1 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
WHERE V01.mandant_id <> 1
 AND (V01.mutter_vk_id IS NULL OR V01.mutter_vk_id = V01.art_id)
 AND V01.dat_bis = DATE '9999-12-31';