CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_wug_restlaufzeit_kunde_zu_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.art_id AS art_id,
  v02.arthiertyp_id AS arthiertyp_id,
  v02.wg_id AS wg_id,
  v02.wug_id AS wug_id,
  MAX(v03.mhd_zeitraum_ab) AS max_mhd_zeitraum_ab,
  MAX(v03.restlaufzeit_ist) AS max_restlaufzeit_ist
FROM kfl_production_dbp_view.v_art_1 AS v01
INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.art_id = v02.art_id
  AND v02.dat_bis = CAST('9999-12-31' AS DATE)
INNER JOIN kfl_production_dbp_view.v_wug_restlaufzeit_kunde_zu_1 AS v03
  ON v02.mandant_id = v03.mandant_id
  AND v02.arthiertyp_id = v03.arthiertyp_id
  AND v02.wg_id = v03.wg_id
  AND v02.wug_id = v03.wug_id
WHERE
  v01.mandant_id = 1
  AND v02.arthiertyp_id = 2
  AND v03.einstellung_schema = 'Z001'
  AND v03.mhd_zeitraum_ab <= v01.mhd_zeitraum
GROUP BY
  v01.mandant_id,
  v01.art_id,
  v02.arthiertyp_id,
  v02.wg_id,
  v02.wug_id
UNION DISTINCT
SELECT
  t01.mandant_id,
  t01.art_id,
  t01.arthiertyp_id,
  t01.wg_id,
  t01.wug_id,
  MAX(v04.mhd_zeitraum_ab) AS max_mhd_zeitraum_ab,
  MAX(v04.restlaufzeit_ist) AS max_restlaufzeit_ist
FROM (
  SELECT
    v01.mandant_id,
    v01.art_id,
    v01.mhd_zeitraum,
    v02.arthiertyp_id,
    v02.wg_id,
    v02.wug_id
  FROM kfl_production_dbp_view.v_art_1 AS v01
  INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS v02
    ON v01.mandant_id = v02.mandant_id
    AND v01.art_id = v02.art_id
    AND v02.dat_bis = CAST('9999-12-31' AS DATE)
    AND v02.arthiertyp_id = 2
  WHERE
    v01.mandant_id = 1
    AND NOT (CAST(v01.mandant_id AS BIGNUMERIC), v02.arthiertyp_id, v02.wg_id, v02.wug_id) IN (
      SELECT
        (mandant_id, arthiertyp_id, wg_id, wug_id)
      FROM kfl_production_dbp_view.v_wug_restlaufzeit_kunde_zu_1 AS v03
      WHERE
        arthiertyp_id = 2 AND einstellung_schema = 'Z001'
    )
) AS t01
LEFT JOIN kfl_production_dbp_view.v_wug_restlaufzeit_kunde_zu_1 AS v04
  ON t01.mandant_id = v04.mandant_id
  AND v04.arthiertyp_id = -1
  AND t01.mhd_zeitraum >= v04.mhd_zeitraum_ab
WHERE
  v04.einstellung_schema = 'Z001'
GROUP BY
  t01.mandant_id,
  t01.art_id,
  t01.arthiertyp_id,
  t01.wg_id,
  t01.wug_id;
