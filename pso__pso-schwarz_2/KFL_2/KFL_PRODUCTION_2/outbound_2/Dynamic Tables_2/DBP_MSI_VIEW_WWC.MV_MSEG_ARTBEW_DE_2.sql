CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_wwc.mv_mseg_artbew_de_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  *
FROM (
  SELECT
    mandant_id,
    wup_id AS werks,
    nb_id,
    dat_buch AS budat,
    art_id,
    gp_id AS lifnr,
    lager_bewart_id AS bwart,
    menge_lagerbew_bme AS menge,
    CAST(betrag_lagerbew AS NUMERIC) AS dmbtr,
    CAST(CASE
      WHEN betrag_verkauf_ist <> 0.0 AND betrag_verkauf_ist <> betrag_verkauf
      THEN betrag_verkauf_ist
      ELSE betrag_verkauf
    END AS NUMERIC) AS vk_brutto,
    CASE
      WHEN betrag_verkauf_ist <> 0.0 AND betrag_verkauf_ist <> betrag_verkauf
      THEN CASE
        WHEN betrag_verkauf_ist = betrag_verkauf
        THEN betrag_vk_netto
        ELSE betrag_verkauf_ist_netto
      END
      ELSE betrag_vk_netto
    END AS vk_netto
  FROM kfl_production_dbp_view.v_lagerbew_det_2 AS v01
  WHERE
    mandant_id = 1
  UNION DISTINCT
  SELECT
    mandant_id,
    wup_id AS werks,
    nb_id,
    dat_buch AS budat,
    art_id,
    gp_id AS lifnr,
    lager_bewart_id AS bwart,
    menge_lagerbew_bme AS menge,
    CAST(betrag_lagerbew AS NUMERIC) AS dmbtr,
    CAST(CASE
      WHEN betrag_verkauf_ist <> 0.0 AND betrag_verkauf_ist <> betrag_verkauf
      THEN betrag_verkauf_ist
      ELSE betrag_verkauf
    END AS NUMERIC) AS vk_brutto,
    CASE
      WHEN betrag_verkauf_ist <> 0.0 AND betrag_verkauf_ist <> betrag_verkauf
      THEN CASE
        WHEN betrag_verkauf_ist = betrag_verkauf
        THEN betrag_vk_netto
        ELSE betrag_verkauf_ist_netto
      END
      ELSE betrag_vk_netto
    END AS vk_netto
  FROM kfl_production_dbp_view.v_lagerbew_det_delta_2 AS v02
  WHERE
    mandant_id = 1
)
UNION ALL
SELECT
  mandant_id,
  wup_id AS werks,
  nb_id,
  dat,
  art_id,
  -1 AS lifnr,
  '251' AS bwart,
  menge * -1 AS menge,
  ek_netto_bnk * -1 AS ek_netto_bnk,
  (
    umsatz_netto + umsatz_mwst_betrag
  ) * -1 AS vk_brutto,
  umsatz_netto * -1 AS umsatz_netto
FROM kfl_production_dbp_view.v_artbew_2 AS v03
WHERE
  mandant_id = 1;