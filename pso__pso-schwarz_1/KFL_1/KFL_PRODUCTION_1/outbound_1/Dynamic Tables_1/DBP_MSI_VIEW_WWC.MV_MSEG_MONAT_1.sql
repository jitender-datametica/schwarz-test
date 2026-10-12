CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_wwc.mv_mseg_monat_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.lager_bewart_id AS bwart,
  v01.art_id AS art_id,
  v01.wup_id AS werks,
  v01.nb_id AS nb_id,
  v01.gp_id AS lifnr,
  v01.kjmo AS kjmo,
  v01.wrg_id AS waers,
  v01.betrag_lagerbew AS dmbtr,
  v01.betrag_verkauf AS vkwrt,
  v01.menge_lagerbew_bme AS menge,
  v01.betrag_vk_netto AS vkwra,
  v01.betrag_verkauf_ist AS exvkw,
  v01.betrag_verkauf_ist_netto AS betrag_verkauf_ist_netto,
  CASE
    WHEN v01.exvkw_gleich_vkwrt_fg = 1
    THEN v01.betrag_vk_netto
    ELSE v01.betrag_verkauf_ist_netto
  END AS exvkw_nt,
  CASE
    WHEN v01.lager_bewart_id IN ('251', '252') AND v01.exvkw_gleich_vkwrt_fg = 1
    THEN v01.betrag_vk_netto
    WHEN v01.lager_bewart_id IN ('251', '252') AND v01.exvkw_gleich_vkwrt_fg = 0
    THEN v01.betrag_verkauf_ist_netto
    WHEN NOT v01.lager_bewart_id IN ('251', '252')
    THEN v01.betrag_vk_netto
    ELSE 0
  END AS vk_wert_nt,
  v01.betrag_exbwr AS exbwr,
  v01.exvkw_gleich_vkwrt_fg AS exvkw_gleich_vkwrt_fg
FROM kfl_production_dbp_view.v_lagerbew_det_wwc_monat_1 AS v01
INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS v03
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
