CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_soll_kz_fbb_wup_zu_1 (
  mandant_id BIGNUMERIC(38, 0),
  wup_id BIGNUMERIC(38, 0),
  nb_id BIGNUMERIC(38, 0),
  fbb_nr STRING(20),
  soll_ist_kz INT64
) AS
SELECT
  mandant_id AS mandant_id,
  wup_id_ AS wup_id,
  nb_id_ AS nb_id,
  fbb_nr AS fbb_nr,
  CASE
    WHEN si_kz = 1
    AND (
      MAX(si_kz) OVER (
        PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id_ AS STRING), SUBSTR(fbb_nr, 1, 4)
        ORDER BY mandant_id IS NULL, mandant_id
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      )
    ) = 3
    THEN 2
    ELSE si_kz
  END AS soll_ist_kz
FROM (
  SELECT
    r.mandant_id,
    COALESCE(r.wup_id, lwz.wup_id) AS wup_id_,
    COALESCE(r.nb_id, lwz.nb_id) AS nb_id_,
    r.fbb_nr,
    r.layoutbaustein_version,
    MAX(r.layoutbaustein_version) OVER (
      PARTITION BY CAST(r.mandant_id AS STRING), CAST(COALESCE(r.wup_id, lwz.wup_id) AS STRING), r.fbb_nr
      ORDER BY r.dat_von IS NULL, r.dat_von
      RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS max_wup_art_version,
    CASE WHEN r.wup_id IS NULL THEN 1 ELSE 3 END AS si_kz
  FROM kfl_production_dbp_view.v_regalachse_1 AS r
  LEFT JOIN kfl_production_dbp_view.v_layoutbaustein_wup_zu_per_1 AS lwz
    ON r.mandant_id = lwz.mandant_id
    AND r.layoutbaustein_id = lwz.layoutbaustein_id
    AND CURRENT_DATE BETWEEN lwz.dat_von AND lwz.dat_bis
    AND lwz.aktiv_fg = 1
    AND r.wup_id IS NULL
    AND NOT r.platzierungsstufe_id IS NULL
  LEFT JOIN kfl_production_dbp_view.v_wup_1 AS w
    ON r.mandant_id = w.mandant_id AND r.wup_id = w.wup_id AND r.nb_id = w.nb_id
  WHERE
    (
      NOT lwz.mandant_id IS NULL OR NOT w.mandant_id IS NULL
    )
    AND (r.mandant_id, r.regalachse_id) IN (
      SELECT
        (mandant_id, regalachse_id)
      FROM kfl_production_dbp_view.v_regalachse_art_zu_1
    )
  QUALIFY
    r.layoutbaustein_version = (
      MAX(r.layoutbaustein_version) OVER (
        PARTITION BY CAST(r.mandant_id AS STRING), CAST(COALESCE(r.wup_id, lwz.wup_id) AS STRING), r.fbb_nr
        ORDER BY r.dat_von IS NULL, r.dat_von
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      )
    )
    AND r.mandant_id = 1
) AS t2;
