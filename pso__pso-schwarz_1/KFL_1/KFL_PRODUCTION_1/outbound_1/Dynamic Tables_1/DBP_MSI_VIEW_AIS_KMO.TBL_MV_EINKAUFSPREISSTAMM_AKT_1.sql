CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_einkaufspreisstamm_akt_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.art_id AS art_id,
  v01.ek_nettonetto AS ek_nettonetto,
  v01.einstandspreis AS einstandspreis,
  v300.umrechnungskurs AS umrechnungskurs
FROM (
  SELECT
    v011.mandant_id,
    v011.art_id,
    v011.ek_nettonetto,
    v011.einstandspreis
  FROM kfl_production_dbp_view.v_art_gp_wup_zu_per_1 AS v011
  INNER JOIN (
    SELECT
      mandant_id,
      art_id,
      gp_id,
      COUNT(*) AS anz_wup
    FROM kfl_production_dbp_view.v_art_gp_nm_zu_per_1 AS v011
    WHERE
      dat_bis = CAST('9999-12-31' AS DATE)
    GROUP BY
      mandant_id,
      art_id,
      gp_id
    QUALIFY
      (
        ROW_NUMBER() OVER (
          PARTITION BY CAST(mandant_id AS STRING), CAST(art_id AS STRING)
          ORDER BY anz_wup IS NULL, anz_wup
        )
      ) = 1
  ) AS v014
    ON v011.art_id = v014.art_id
    AND v011.mandant_id = v014.mandant_id
    AND v011.gp_id = v014.gp_id
  WHERE
    v011.wup_id = -1 AND v011.dat_bis = CAST('9999-12-31' AS DATE)
) AS v01
INNER JOIN kfl_production_dbp_view.v_mandant_1 AS v100
  ON v01.mandant_id = v100.mandant_id
INNER JOIN kfl_production_dbp_view.v_kurs_1 AS v300
  ON v300.dat_bis = CAST('9999-12-31' AS DATE)
  AND v100.default_wrg = v300.von_wrg_id
  AND v300.kurstyp_id = 3
  AND v300.nach_wrg_id = 'EUR'
WHERE
  v01.mandant_id > 1;
