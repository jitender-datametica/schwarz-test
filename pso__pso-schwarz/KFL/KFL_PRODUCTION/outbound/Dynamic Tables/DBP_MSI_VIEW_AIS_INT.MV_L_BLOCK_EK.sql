CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_l_block_ek
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v03.mandant_id AS mandant_id,
  v03.kl_art_id AS muki_block_ek_kl_id,
  LPAD(SUBSTR(CAST(v03.kl_art_id AS STRING), 1, 10), 8, '0') AS muki_block_ek_kl_id_lang,
  v01.art_id AS muki_block_ek_id,
  v02.art_bez AS muki_block_ek_bez,
  CASE WHEN v01.mutter_ek_id IS NULL THEN 'W' ELSE 'M' END AS muki_block_kz_ek_id
FROM kfl_production_dbp_view.v_art_gp_zu_per AS v01
INNER JOIN kfl_production_dbp_view.v_art_spr_zu AS v02
  ON v01.art_id = v02.art_id AND v01.mandant_id = v02.mandant_id
INNER JOIN kfl_production_dbp_view.v_art AS v03
  ON v02.art_id = v03.art_id AND v02.mandant_id = v03.mandant_id
WHERE
  v02.spr_id = 22
  AND COALESCE(v01.mutter_ek_id, v01.art_id) = v01.art_id
  AND v01.dat_bis = CAST('9999-12-31' AS DATE)
  AND v03.dat_bis = CAST('9999-12-31' AS DATE);
