CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_int.mv_aktionthema_1 AS
WITH ranked_aktionen AS (
  SELECT
    v01.mandant_id,
    v01.aktion_id,
    v01.art_id,
    v03.kl_art_id,
    v01.aktion_thema_id,
    v01.vk_aktion_brutto,
    v02.dat_von,
    v02.dat_bis,
    COUNT(*) AS anzahl,
    ROW_NUMBER() OVER (
      PARTITION BY CAST(v01.mandant_id AS STRING), v01.aktion_id, CAST(v01.art_id AS STRING)
      ORDER BY COUNT(*) IS NULL DESC, COUNT(*) DESC
    ) AS rank
  FROM kfl_production_dbp_view.v_aktion_art_wup_zu_1 AS v01
  INNER JOIN kfl_production_dbp_view.v_aktion_1 AS v02
    ON v01.mandant_id = v02.mandant_id AND v01.aktion_id = v02.aktion_id
  INNER JOIN kfl_production_dbp_view.v_art_1 AS v03
    ON v01.mandant_id = v03.mandant_id
    AND v01.art_id = v03.art_id
    AND v03.dat_bis = CAST('9999-12-31' AS DATE)
  WHERE
    v01.nb_id = 0 AND v02.dat_bis >= CAST('2019-01-01' AS DATE) AND v01.mandant_id = 1
  GROUP BY
    v01.mandant_id,
    v01.aktion_id,
    v01.art_id,
    v01.vk_aktion_brutto,
    v01.aktion_thema_id,
    v02.dat_von,
    v02.dat_bis,
    v03.kl_art_id
)
(
  SELECT
    *
  FROM (
    (
      SELECT
        mandant_id,
        aktion_id,
        art_id,
        kl_art_id,
        aktion_thema_id,
        vk_aktion_brutto,
        dat_von,
        dat_bis
      FROM ranked_aktionen
      WHERE
        rank = 1
      UNION DISTINCT
      SELECT
        mandant_id,
        aktion_id,
        CAST(NULL AS BIGNUMERIC) AS art_id,
        CAST(NULL AS INT64) AS kl_art_id,
        'nicht vorhanden' AS aktion_thema_id,
        CAST(NULL AS NUMERIC) AS vk_aktion_brutto,
        dat_von,
        dat_bis
      FROM kfl_production_dbp_view.v_l_bonuskauf_1 AS v01
      WHERE
        dat_bis >= CAST('2019-01-01' AS DATE)
        AND mandant_id = 1
        AND NOT (CAST(mandant_id AS INT64), CAST(aktion_id AS INT64)) IN (
          SELECT
            (CAST(v010.mandant_id AS INT64), CAST(v010.aktion_id AS INT64))
          FROM kfl_production_dbp_view.v_aktion_art_wup_zu_1 AS v010
          INNER JOIN kfl_production_dbp_view.v_aktion_1 AS v02
            ON v010.mandant_id = v02.mandant_id AND v010.aktion_id = v02.aktion_id
          INNER JOIN kfl_production_dbp_view.v_art_1 AS v03
            ON v010.mandant_id = v03.mandant_id
            AND v010.art_id = v03.art_id
            AND v03.dat_bis = CAST('9999-12-31' AS DATE)
            AND v02.dat_bis >= CAST('2019-01-01' AS DATE)
          WHERE
            v010.nb_id = 0 AND v010.mandant_id = 1
          GROUP BY
            v010.mandant_id,
            v010.aktion_id
        )
    )
    UNION DISTINCT
    SELECT
      mandant_id,
      '' AS aktion_id,
      art_id,
      kl_art_id,
      'nicht vorhanden' AS aktion_thema_id,
      CAST(NULL AS NUMERIC) AS vk_aktion_brutto,
      CAST(NULL AS DATE) AS dat_von,
      CAST(NULL AS DATE) AS dat_bis
    FROM kfl_production_dbp_view.v_art_1 AS v01
    WHERE
      dat_bis = CAST('9999-12-31' AS DATE) AND mandant_id = 1
  )
  ORDER BY
    1 NULLS LAST,
    2 NULLS LAST,
    3 NULLS LAST
);