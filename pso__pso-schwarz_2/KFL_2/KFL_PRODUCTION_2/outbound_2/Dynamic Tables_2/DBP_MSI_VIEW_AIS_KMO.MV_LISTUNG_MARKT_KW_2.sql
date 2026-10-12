CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_listung_markt_kw_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id,
  v03.wg_id,
  v01.art_id,
  v01.wup_id,
  v01.nb_id,
  v04.kreistyp_gruppe_id,
  v02.kjwo,
  IFNULL(SUM(v01.menge), 0) AS absatz,
  IFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge ELSE NULL END), 0) AS absatz_sa,
  IFNULL(SUM(CASE WHEN v01.bewart_id IN (1001, 1010) THEN v01.menge ELSE NULL END), 0) AS absatz_af,
  IFNULL(
    CASE WHEN IFNULL(SUM(v01.menge), 0) > 0 THEN COUNT(DISTINCT v02.kjwo) ELSE NULL END,
    0
  ) AS anz_wo_mit_absatz,
  IFNULL(
    CASE
      WHEN IFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge ELSE NULL END), 0) > 0
      AND NOT IFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge ELSE NULL END), 0) IS NULL
      THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v02.kjwo ELSE NULL END)
      ELSE NULL
    END,
    0
  ) AS anz_wo_mit_absatz_sa,
  IFNULL(
    CASE
      WHEN IFNULL(SUM(CASE WHEN v01.bewart_id IN (1001, 1010) THEN v01.menge ELSE NULL END), 0) > 0
      AND NOT IFNULL(SUM(CASE WHEN v01.bewart_id IN (1001, 1010) THEN v01.menge ELSE NULL END), 0) IS NULL
      THEN COUNT(DISTINCT CASE WHEN v01.bewart_id IN (1001, 1010) THEN v02.kjwo ELSE NULL END)
      ELSE NULL
    END,
    0
  ) AS anz_wo_mit_absatz_af
FROM kfl_production_dbp_data.artbew_wo_sum_2 AS v01
INNER JOIN kfl_production_dbp_data.woche_kj_kl_2 AS v02
  ON v01.kjwo_kl = v02.kjwo_kl
INNER JOIN kfl_production_dbp_data.art_wg_zu_per_2 AS v03
  ON v01.art_id = v03.art_id AND v01.mandant_id = v03.mandant_id
INNER JOIN kfl_production_dbp_data.wup_2 AS v04
  ON v01.wup_id = v04.wup_id
  AND v01.nb_id = v04.nb_id
  AND v01.mandant_id = v04.mandant_id
WHERE
  v01.mandant_id > 1
  AND v03.arthiertyp_id = 2
  AND v03.dat_bis = CAST('9999-12-31' AS DATE)
  AND (
    v01.mandant_id <> 5 OR v01.art_id <> 206731500
  )
  AND (
    v01.mandant_id <> 2 OR v01.art_id <> 208124500
  )
  AND (
    v01.mandant_id <> 3 OR v01.art_id <> 208113690
  )
  AND (
    v01.mandant_id <> 6 OR v01.art_id <> 208131570
  )
  AND (
    NOT v01.mandant_id IN (4, 7) OR v01.art_id <> 208114740
  )
  AND (
    v01.mandant_id <> 8 OR v01.art_id <> 208131640
  )
GROUP BY
  v01.mandant_id,
  v03.wg_id,
  v01.art_id,
  v01.wup_id,
  v01.nb_id,
  v04.kreistyp_gruppe_id,
  v02.kjwo;