CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_wwc.mv_artbew_mo_sum
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.mandant_id,
  v01.wup_id AS werks,
  v01.nb_id,
  v01.bewart_id,
  v01.kjmo,
  v01.art_id,
  v01.menge,
  v01.umsatz_netto AS vk_netto,
  v02.default_wrg AS wrg_id
FROM kfl_production_dbp_view.v_artbew_mo_sum AS v01
INNER JOIN kfl_production_dbp_view.v_mandant AS v02
  ON v01.mandant_id = v02.mandant_id
INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS v03
  ON v01.art_id = v03.art_id
  AND v01.mandant_id = v03.mandant_id
  AND (
    NOT v03.mandant_id IN (1, 7)
    OR v03.mandant_id IN (1, 7)
    AND TRIM(CAST(v03.wg_id AS STRING FORMAT '000')) || TRIM(CAST(v03.wug_id AS STRING FORMAT '000')) <> '969006'
  )
  AND (
    v03.mandant_id <> 7
    OR v03.mandant_id = 7
    AND TRIM(CAST(v03.wg_id AS STRING FORMAT '000')) <> '980'
  )
  AND v03.wg_id <> 961
  AND (
    NOT v03.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
    OR v03.mandant_id IN (2, 3, 4, 5, 6, 7, 8)
    AND NOT TRIM(CAST(v03.wg_id AS STRING FORMAT '000')) || TRIM(CAST(v03.wug_id AS STRING FORMAT '000')) IN ('969001', '969002', '969003', '969004')
  )
  AND v03.arthiertyp_id = 2
  AND v03.dat_bis = CAST('9999-12-31' AS DATE);