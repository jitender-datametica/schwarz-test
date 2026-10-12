CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_listung_markt_kw
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v03.wg_id AS wg_id,
  v05.owg_id AS owg_id,
  v01.art_id AS art_id,
  v01.wup_id AS wup_id,
  v01.nb_id AS nb_id,
  v04.kreistyp_gruppe_id AS kreistyp_gruppe_id,
  v02.kjwo AS kjwo,
  IFNULL(SUM(v01.menge), 0) AS absatz,
  IFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge ELSE NULL END), 0) AS absatz_sa,
  IFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge ELSE NULL END), 0) AS absatz_af,
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
      WHEN IFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge ELSE NULL END), 0) > 0
      AND NOT IFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge ELSE NULL END), 0) IS NULL
      THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v02.kjwo ELSE NULL END)
      ELSE NULL
    END,
    0
  ) AS anz_wo_mit_absatz_af
FROM kfl_production_dbp_view.v_artbew_wo_sum AS v01
INNER JOIN kfl_production_dbp_view.v_woche_kj_kl AS v02
  ON v01.kjwo_kl = v02.kjwo_kl
INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS v03
  ON v01.art_id = v03.art_id AND v01.mandant_id = v03.mandant_id
INNER JOIN kfl_production_dbp_view.v_wup AS v04
  ON v01.wup_id = v04.wup_id
  AND v01.nb_id = v04.nb_id
  AND v01.mandant_id = v04.mandant_id
INNER JOIN kfl_production_dbp_view.v_wg_per AS v05
  ON v03.wg_id = v05.wg_id
  AND v03.mandant_id = v05.mandant_id
  AND v05.arthiertyp_id = 2
  AND v05.dat_bis = CAST('9999-12-31' AS DATE)
WHERE
  v01.mandant_id = 1
  AND v03.arthiertyp_id = 2
  AND v03.dat_bis = CAST('9999-12-31' AS DATE)
GROUP BY
  v01.mandant_id,
  v03.wg_id,
  v05.owg_id,
  v01.art_id,
  v01.wup_id,
  v01.nb_id,
  v04.kreistyp_gruppe_id,
  v02.kjwo;
