CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_wwc.mv_artbew_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.wup_id AS werks,
  v01.mandant_id,
  v01.bewart_id,
  v01.nb_id,
  v01.dat,
  v01.art_id,
  v01.menge,
  v01.umsatz_netto AS vk_netto,
  CASE
    WHEN v01.bewart_id = 1002
    THEN CAST(v01.umsatz_netto AS BIGNUMERIC)
    ELSE NULL
  END AS umsatz_netto_sa,
  CASE WHEN v01.bewart_id = 1002 THEN CAST(v01.menge AS BIGNUMERIC) ELSE NULL END AS vk_menge_sa,
  CASE
    WHEN v01.bewart_det_id = 100211
    THEN CAST(v01.pv_aktion AS BIGNUMERIC)
    ELSE NULL
  END AS pv_aktion_sa_loyalty,
  CASE
    WHEN v01.bewart_det_id IN (100221, 100211)
    THEN CAST(v01.pv_aktion_bby AS BIGNUMERIC)
    ELSE NULL
  END AS pv_aktion_sa_loyalty_bby,
  CASE
    WHEN v01.bewart_det_id IN (100231, 100221, 100211)
    THEN CAST(v01.pv_aktion_kdn_bby AS BIGNUMERIC)
    ELSE NULL
  END AS pv_aktion_sa_loyalty_kdn_bby,
  CASE
    WHEN v01.bewart_det_id IN (100241, 100231, 100221, 100211)
    THEN CAST(v01.pv_aktion_kdp_bby AS BIGNUMERIC)
    ELSE NULL
  END AS pv_aktion_sa_loyalty_kdp_bby,
  CASE
    WHEN v01.bewart_det_id = 100210
    THEN CAST(v01.pv_aktion AS BIGNUMERIC)
    ELSE NULL
  END AS pv_aktion_sa_non_loyalty,
  CASE
    WHEN v01.bewart_det_id IN (100220, 100210)
    THEN CAST(v01.pv_aktion_bby AS BIGNUMERIC)
    ELSE NULL
  END AS pv_aktion_sa_non_loyalty_bby,
  CASE
    WHEN v01.bewart_det_id IN (100221, 100231, 100241)
    THEN CAST(v01.pv_bby AS BIGNUMERIC)
    ELSE NULL
  END AS pv_bby_loyalty,
  CASE
    WHEN v01.bewart_det_id = 100220
    THEN CAST(v01.pv_bby AS BIGNUMERIC)
    ELSE NULL
  END AS pv_bby_non_loyalty,
  CASE
    WHEN v01.bewart_det_id IN (100231, 100241)
    THEN CAST(v01.pv_kdn_bby AS BIGNUMERIC)
    ELSE NULL
  END AS pv_kdn_bby_loyalty,
  CASE
    WHEN v01.bewart_det_id = 100241
    THEN CAST(v01.pv_kdp_bby AS BIGNUMERIC)
    ELSE NULL
  END AS pv_kdp_bby_loyalty,
  CASE
    WHEN v01.bewart_det_id IN (100210, 100220, 100130)
    THEN CAST(v01.pv_bonrabatt_bby AS BIGNUMERIC)
    ELSE 0
  END AS pv_bonrabatt_bby_non_loyalty,
  CASE
    WHEN v01.bewart_det_id IN (100211, 100221, 100231, 100241, 100131)
    THEN CAST(v01.pv_bonrabatt_bby AS BIGNUMERIC)
    ELSE 0
  END AS pv_bonrabatt_bby_loyalty,
  CASE
    WHEN v01.bewart_det_id IN (100210, 100220, 100130)
    THEN CAST(v01.pv_bonrabatt_bby AS BIGNUMERIC)
    ELSE 0
  END + CASE
    WHEN v01.bewart_det_id IN (100211, 100221, 100231, 100241, 100131)
    THEN CAST(v01.pv_bonrabatt_bby AS BIGNUMERIC)
    ELSE 0
  END AS pv_bonrabatt_bby,
  v02.default_wrg AS wrg_id,
  v01.bezugsweg_id
FROM kfl_production_dbp_view.v_artbew_2 AS v01
INNER JOIN kfl_production_dbp_view.v_mandant_2 AS v02
  ON v01.mandant_id = v02.mandant_id
INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_2 AS v03
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