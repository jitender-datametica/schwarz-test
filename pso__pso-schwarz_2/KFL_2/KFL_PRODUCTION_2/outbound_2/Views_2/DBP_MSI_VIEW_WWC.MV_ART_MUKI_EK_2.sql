CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_muki_ek_2 (art_id, mandant_id, muki_block_ek_id,
muki_kz_ek_id, muki_block_kz_ek_id) AS SELECT art_id,
 mandant_id,
 COALESCE(mutter_ek_id, art_id) AS muki_block_ek_id,
  CASE
  WHEN mutter_ek_id IS NULL
  THEN 'W'
  WHEN art_id = mutter_ek_id
  THEN 'M'
  ELSE 'K'
  END AS muki_kz_ek_id,
  CASE
  WHEN mutter_ek_id IS NULL
  THEN 'W'
  ELSE 'M'
  END AS muki_block_kz_ek_id
FROM kfl_production_dbp_view.v_art_gp_zu_per_2
QUALIFY (SUM(1) OVER (PARTITION BY CAST(art_id AS STRING), CAST(mandant_id AS STRING) ORDER BY dat_bis IS NULL, dat_bis
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 1;