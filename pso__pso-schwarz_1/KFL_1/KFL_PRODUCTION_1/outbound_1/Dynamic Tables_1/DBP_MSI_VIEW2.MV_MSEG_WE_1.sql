CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_mseg_we_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.art_id AS art_id,
  v01.wup_id AS wup_id,
  v01.nb_id AS nb_id,
  v01.dat_buch AS dat,
  SUM(v01.menge_lagerbew_bme) AS mseg_menge_we_wwc,
  SUM(v01.betrag_verkauf) AS mseg_vk_brutto_we_wwc,
  SUM(v01.betrag_vk_netto) AS mseg_vk_netto_we_wwc
FROM kfl_production_dbp_view.v_lagerbew_det_1 AS v01
INNER JOIN kfl_production_dbp_view.v_lagerbew_det_wwc_1 AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.lagerbew_beleg_id = v02.lagerbew_beleg_id
  AND v01.lagerbew_beleg_pos_id = v02.lagerbew_beleg_pos_id
  AND v01.kj = v02.kj
  AND v01.dat_buch = v02.dat_buch
WHERE
  v01.mandant_id = 1
  AND v01.lager_bewart_id IN (
    '901',
    '902',
    '905',
    '906',
    '907',
    '908',
    '915',
    '916',
    '301',
    '302',
    '303',
    '304',
    '317',
    '318',
    '319',
    '320'
  )
GROUP BY
  v01.mandant_id,
  v01.art_id,
  v01.wup_id,
  v01.nb_id,
  dat
UNION ALL
SELECT
  mandant_id,
  art_id,
  wup_id,
  nb_id,
  dat_buch AS dat,
  SUM(menge_lagerbew_bme) AS mseg_menge_we_wwc,
  SUM(betrag_verkauf) AS mseg_vk_brutto_we_wwc,
  SUM(betrag_vk_netto) AS mseg_vk_netto_we_wwc
FROM kfl_production_dbp_view.v_lagerbew_det_delta_1
WHERE
  mandant_id = 1
  AND lager_bewart_id IN (
    '901',
    '902',
    '905',
    '906',
    '907',
    '908',
    '915',
    '916',
    '301',
    '302',
    '303',
    '304',
    '317',
    '318',
    '319',
    '320'
  )
GROUP BY
  mandant_id,
  art_id,
  wup_id,
  nb_id,
  dat;
