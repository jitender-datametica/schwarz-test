CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_kmo.mv_art_wup_list_zu_2 (
  mandant_id BIGNUMERIC(38, 0),
  art_id BIGNUMERIC(38, 0),
  wup_id BIGNUMERIC(38, 0),
  nb_id BIGNUMERIC(38, 0),
  bezugsweg_id BIGNUMERIC(38, 0),
  kdis_kz STRING(1),
  listung_markt STRING(16),
  listung_fct STRING(16)
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.art_id AS art_id,
  v01.wup_id AS wup_id,
  v01.nb_id AS nb_id,
  v01.bezugsweg_id AS bezugsweg_id,
  CASE WHEN v01.kdis IS NULL OR v01.kdis = 0 THEN ' ' ELSE 'K' END AS kdis_kz,
  CASE
    WHEN t1.art_id IS NULL
    THEN 'war nie gelistet'
    ELSE CASE
      WHEN v01.listung_id = 1
      THEN CASE
        WHEN v01.bezugsweg_id = 1
        THEN CASE WHEN v01.kdis = 0 THEN '1' ELSE '5' END
        WHEN v01.bezugsweg_id = 4
        THEN CASE WHEN v01.kdis = 0 THEN '4' ELSE '8' END
        ELSE 'ausgelistet'
      END
      ELSE 'ausgelistet'
    END
  END AS listung_markt,
  CASE
    WHEN CASE
      WHEN t1.art_id IS NULL
      THEN 'war nie gelistet'
      ELSE CASE
        WHEN v01.listung_id = 1
        THEN CASE
          WHEN v01.bezugsweg_id = 1
          THEN CASE WHEN v01.kdis = 0 THEN '1' ELSE '5' END
          WHEN v01.bezugsweg_id = 4
          THEN CASE WHEN v01.kdis = 0 THEN '4' ELSE '8' END
          ELSE 'ausgelistet'
        END
        ELSE 'ausgelistet'
      END
    END IN ('ausgelistet', 'war nie gelistet')
    THEN NULL
    ELSE CASE
      WHEN t1.art_id IS NULL
      THEN 'war nie gelistet'
      ELSE CASE
        WHEN v01.listung_id = 1
        THEN CASE
          WHEN v01.bezugsweg_id = 1
          THEN CASE WHEN v01.kdis = 0 THEN '1' ELSE '5' END
          WHEN v01.bezugsweg_id = 4
          THEN CASE WHEN v01.kdis = 0 THEN '4' ELSE '8' END
          ELSE 'ausgelistet'
        END
        ELSE 'ausgelistet'
      END
    END
  END AS listung_fct
FROM kfl_production_dbp_view.v_art_wup_zu_per_2 AS v01
LEFT JOIN (
  SELECT
    mandant_id,
    art_id,
    wup_id
  FROM kfl_production_dbp_view.v_art_list_wup_zu_per_2
  WHERE
    mandant_id <> 1
  GROUP BY
    art_id,
    wup_id,
    mandant_id
) AS t1_2
  ON v01.mandant_id = t1.mandant_id
  AND v01.art_id = t1.art_id
  AND v01.wup_id = t1.wup_id
INNER JOIN kfl_production_dbp_view.v_wup_2 AS v03
  ON v01.mandant_id = v03.mandant_id
  AND v01.wup_id = v03.wup_id
  AND v01.nb_id = v03.nb_id
WHERE
  v01.mandant_id <> 1
  AND v01.dat_bis = CAST('9999-12-31' AS DATE)
  AND (
    (
      v03.dat_eroeffnung < CURRENT_DATE
      OR v03.dat_eroeffnung < DATE_ADD(CURRENT_DATE, INTERVAL '45' DAY)
    )
    AND NOT v03.dat_von IS NULL
    OR v03.nb_id <> 0
    OR v03.wup_id = 9203
  )
  AND v03.nb_id <> 99
  AND NOT v03.wup_id BETWEEN 1 AND 999;
