CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_l_block_vk_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.art_id AS muki_block_vk_id,
  LPAD(SUBSTR(CAST(v01.kl_art_id AS STRING), 1, 10), 8, '0') AS muki_block_vk_kl_id_lang,
  v01.kl_art_id AS muki_block_vk_kl_id,
  v02.art_bez AS muki_block_vk_bez,
  CASE WHEN v01.mutter_vk_id IS NULL THEN 'W' ELSE 'M' END AS muki_block_kz_vk_id
FROM kfl_production_dbp_view.v_art_1 AS v01
INNER JOIN kfl_production_dbp_view.v_art_spr_zu_1 AS v02
  ON v01.art_id = v02.art_id AND v01.mandant_id = v02.mandant_id
WHERE
  v02.spr_id = 22
  AND (
    v01.mutter_vk_id IS NULL OR v01.mutter_vk_id = v01.art_id
  )
  AND v01.dat_bis = CAST('9999-12-31' AS DATE);
