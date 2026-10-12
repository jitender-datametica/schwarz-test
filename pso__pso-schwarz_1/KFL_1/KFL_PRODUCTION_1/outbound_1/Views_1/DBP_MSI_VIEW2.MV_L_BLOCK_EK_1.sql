CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_block_ek_1 (muki_block_ek_kl_id, muki_block_ek_kl_art_id,
muki_block_ek_id, muki_block_ek_bez, muki_block_kz_ek_id) AS SELECT TRIM(CAST(V03.kl_art_id AS STRING FORMAT '00000000')
  ) AS muki_block_ek_kl_id,
 V03.kl_art_id AS muki_block_ek_kl_art_id,
 V01.art_id AS muki_block_ek_id,
 V02.art_bez AS muki_block_ek_bez,
  CASE
  WHEN V01.mutter_ek_id IS NULL
  THEN 'W'
  ELSE 'M'
  END AS muki_block_kz_ek_id
FROM kfl_production_dbp_view.v_art_gp_zu_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_spr_zu_1 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_1 AS V03 ON V02.art_id = V03.art_id AND V02.mandant_id = V03.mandant_id
WHERE V02.spr_id = 22
 AND COALESCE(V01.mutter_ek_id, V01.art_id) = V01.art_id
 AND V01.dat_bis = PARSE_DATE('%F', '9999-12-31')
 AND V03.dat_bis = PARSE_DATE('%F', '9999-12-31')
 AND V03.mandant_id = 1;