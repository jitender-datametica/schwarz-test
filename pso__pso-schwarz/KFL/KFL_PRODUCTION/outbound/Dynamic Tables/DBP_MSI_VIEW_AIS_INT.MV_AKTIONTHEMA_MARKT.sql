CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_aktionthema_markt
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
(
  SELECT DISTINCT
    v01.mandant_id,
    v01.aktion_id,
    v01.wup_id,
    v01.nb_id,
    v01.art_id,
    v03.kl_art_id,
    v01.aktion_thema_id,
    v01.vk_aktion_brutto,
    CAST(NULL AS DATE) AS dat_von,
    CAST(NULL AS DATE) AS dat_bis
  FROM kfl_production_dbp_view.v_aktion_art_wup_zu AS v01
  INNER JOIN kfl_production_dbp_view.v_aktion AS v02
    ON v01.mandant_id = v02.mandant_id AND v01.aktion_id = v02.aktion_id
  INNER JOIN kfl_production_dbp_view.v_art AS v03
    ON v01.mandant_id = v03.mandant_id AND v01.art_id = v03.art_id
  WHERE
    v01.nb_id = 0
    AND v03.dat_bis = CAST('9999-12-31' AS DATE)
    AND v02.dat_bis >= CAST('2019-01-01' AS DATE)
    AND v01.mandant_id = 1
  UNION DISTINCT
  SELECT
    mandant_id,
    aktion_id,
    CAST(NULL AS BIGNUMERIC) AS wup_id,
    CAST(NULL AS BIGNUMERIC) AS nb_id,
    CAST(NULL AS BIGNUMERIC) AS art_id,
    CAST(NULL AS INT64) AS kl_art_id,
    'nicht vorhanden' AS aktion_thema_id,
    CAST(NULL AS NUMERIC) AS vk_aktion_brutto,
    dat_von,
    dat_bis
  FROM kfl_production_dbp_view.v_l_bonuskauf AS v04
  WHERE
    dat_bis >= CAST('2019-01-01' AS DATE)
    AND mandant_id = 1
    AND NOT (CAST(mandant_id AS INT64), aktion_id) IN (
      SELECT
        (cast (a.mandant_id as INT64), a.aktion_id)
      FROM kfl_production_dbp_view.v_aktion_art_wup_zu AS a
      INNER JOIN kfl_production_dbp_view.v_aktion AS b
        ON a.mandant_id = b.mandant_id AND a.aktion_id = b.aktion_id
      INNER JOIN kfl_production_dbp_view.v_art AS c
        ON a.mandant_id = c.mandant_id AND a.art_id = c.art_id
      WHERE
        a.nb_id = 0
        AND c.dat_bis = CAST('9999-12-31' AS DATE)
        AND b.dat_bis >= CAST('2019-01-01' AS DATE)
        AND a.mandant_id = 1
      GROUP BY
        a.mandant_id,
        a.aktion_id
    )
  GROUP BY
    mandant_id,
    aktion_id,
    wup_id,
    nb_id,
    art_id,
    kl_art_id,
    aktion_thema_id,
    vk_aktion_brutto,
    dat_von,
    dat_bis
)
UNION DISTINCT
SELECT
  v01.mandant_id AS mandant_id,
  '' AS aktion_id,
  v02.wup_id AS wup_id,
  v02.nb_id AS nb_id,
  v01.art_id AS art_id,
  v01.kl_art_id AS kl_art_id,
  'nicht vorhanden' AS aktion_thema_id,
  CAST(NULL AS NUMERIC) AS vk_aktion_brutto,
  CAST(NULL AS DATE) AS dat_von,
  CAST(NULL AS DATE) AS dat_bis
FROM kfl_production_dbp_view.v_art AS v01
INNER JOIN kfl_production_dbp_view.v_wup AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v02.nb_id = 0
  AND v01.dat_bis = CAST('9999-12-31' AS DATE)
  AND v01.mandant_id = 1;
