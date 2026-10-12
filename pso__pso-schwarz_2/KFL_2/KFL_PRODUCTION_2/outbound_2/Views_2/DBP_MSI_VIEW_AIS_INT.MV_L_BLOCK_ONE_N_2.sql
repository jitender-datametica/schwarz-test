CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_l_block_one_n_2 (one_n_block_id, one_n_block_kl_id,
one_n_block_kl_art_id, one_n_block_bez, one_n_kz_block) AS SELECT V01.art_id AS one_n_block_id,
 TRIM(CAST(V01.kl_art_id AS STRING FORMAT '00000000')) AS one_n_block_kl_id,
 V01.kl_art_id AS one_n_block_kl_art_id,
 V02.art_bez AS one_n_block_bez,
  CASE
  WHEN V01.mutter_1_n_id IS NULL
  THEN '1:1'
  ELSE '1:N'
  END AS one_n_kz_block
FROM kfl_production_dbp_view.v_art_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_spr_zu_2 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
WHERE V02.spr_id = 22
 AND V01.dat_bis = PARSE_DATE('%F', '9999-12-31')
 AND V01.mandant_id = 1;