CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_block_ek_hr_2 (mandant_id, muki_block_ek_kl_id,
muki_block_ek_id, muki_block_ek_bez, muki_block_kz_ek_id) AS SELECT V01.mandant_id,
 V03.kl_art_id AS muki_block_ek_kl_id,
 V01.art_id AS muki_block_ek_id,
 V02.art_bez AS muki_block_ek_bez,
  CASE
  WHEN V01.mutter_ek_id IS NULL
  THEN 'W'
  ELSE 'M'
  END AS muki_block_kz_ek_id
FROM kfl_production_dbp_view.v_art_gp_zu_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_spr_zu_2 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_2 AS V03 ON V02.art_id = V03.art_id AND V02.mandant_id = V03.mandant_id
WHERE V02.spr_id = 95
 AND COALESCE(V01.mutter_ek_id, V01.art_id) = V01.art_id
 AND V01.dat_bis = DATE '9999-12-31'
 AND V03.dat_bis = DATE '9999-12-31';