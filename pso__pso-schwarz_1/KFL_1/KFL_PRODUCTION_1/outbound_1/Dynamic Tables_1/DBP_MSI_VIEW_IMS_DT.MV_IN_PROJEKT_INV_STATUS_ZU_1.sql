CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ims_dt.mv_in_projekt_inv_status_zu_1 (
  mandant_id BIGNUMERIC(38, 0),
  in_projekt_id BIGNUMERIC(38, 0),
  status_id INT64,
  status_bez STRING(4)
) AS
SELECT
  t00.mandant_id AS mandant_id,
  t00.in_projekt_id AS in_projekt_id,
  COALESCE(t14.status_id, 0) AS status_id,
  COALESCE(t14.status_bez, '') AS status_bez
FROM kfl_production_dbp_view.v_in_projekt_1 AS t00
LEFT JOIN (
  SELECT
    mandant_id,
    in_projekt_id,
    status_id,
    status_bez
  FROM (
    SELECT
      *
    FROM (
      (
        (
          SELECT
            v01.mandant_id,
            v02.in_projekt_id,
            v04.in_projekt_id_char,
            2 AS status_id,
            'GuB' AS status_bez,
            MIN(v01.dat_buch) AS dat
          FROM kfl_production_dbp_view.v_ist_kosten_det_1 AS v01
          INNER JOIN kfl_production_dbp_view.v_in_psp_element_1 AS v02
            ON v01.psp_id = v02.psp_id AND v01.mandant_id = v02.mandant_id
          INNER JOIN kfl_production_dbp_view.v_anlage_klasse_zu_per_1 AS v03
            ON v01.anlage_id = v03.anlage_id
            AND v01.anlage_sub_id = v03.anlage_sub_id
            AND v01.mandant_id = v03.mandant_id
            AND v01.buchungskreis_id = v03.buchungskreis_id
            AND v03.dat_bis = CAST('9999-12-31' AS DATE)
            AND v03.anlage_klasse_id = '11000000'
          INNER JOIN kfl_production_dbp_view.v_in_projekt_1 AS v04
            ON v02.in_projekt_id = v04.in_projekt_id AND v02.mandant_id = v04.mandant_id
          WHERE
            v04.ims_projekt_typ_id = 'B' OR v04.ims_projekt_typ_id = 'E'
          GROUP BY
            v01.mandant_id,
            v02.in_projekt_id,
            v04.in_projekt_id_char
          UNION DISTINCT
          SELECT
            v01.mandant_id,
            v02.in_projekt_id,
            v02.in_projekt_id_char,
            3 AS status_id,
            'Bau' AS status_bez,
            MIN(v01.dat_von) AS dat
          FROM kfl_production_dbp_view.v_rpm_element_per_1 AS v01
          INNER JOIN kfl_production_dbp_view.v_in_projekt_1 AS v02
            ON v01.projekt_id = v02.projekt_ext_id
          INNER JOIN kfl_production_dbp_view.v_rpm_phase_spr_zu_1 AS v03
            ON v01.rpm_phase_id = v03.rpm_phase_id
            AND v01.rpm_projekt_typ_id = v03.rpm_projekt_typ_id
            AND v03.spr_id = 22
            AND v03.rpm_phase_bez = 'Im Bau'
          WHERE
            v02.ims_projekt_typ_id = 'B' OR v02.ims_projekt_typ_id = 'E'
          GROUP BY
            v01.mandant_id,
            v02.in_projekt_id,
            v02.in_projekt_id_char
        )
        UNION DISTINCT
        SELECT
          mandant_id,
          in_projekt_id,
          in_projekt_id_char,
          4 AS status_id,
          'EÖ' AS status_bez,
          dat_massnahme_ende AS dat
        FROM kfl_production_dbp_view.v_in_projekt_1 AS v01
        WHERE
          (
            ims_projekt_typ_id = 'B' OR ims_projekt_typ_id = 'E'
          )
          AND dat_massnahme_ende < CURRENT_DATE
      )
      UNION DISTINCT
      SELECT
        v01.mandant_id,
        v01.in_projekt_id,
        v01.in_projekt_id_char,
        5 AS status_id,
        'Abr.' AS status_bez,
        MAX(v02.dat_abschluss) AS dat
      FROM kfl_production_dbp_view.v_in_projekt_1 AS v01
      INNER JOIN kfl_production_dbp_view.v_in_psp_element_1 AS v02
        ON v01.in_projekt_id = v02.in_projekt_id AND v01.mandant_id = v02.mandant_id
      WHERE
        (
          v01.ims_projekt_typ_id = 'B' OR v01.ims_projekt_typ_id = 'E'
        )
        AND NOT (v01.mandant_id, v01.in_projekt_id) IN (
          SELECT
            (mandant_id, in_projekt_id)
          FROM kfl_production_dbp_view.v_in_psp_element_1
          WHERE
            dat_abschluss IS NULL
        )
      GROUP BY
        v01.mandant_id,
        v01.in_projekt_id,
        v01.in_projekt_id_char
    )
    QUALIFY
      status_id = (
        MAX(status_id) OVER (
          PARTITION BY CAST(mandant_id AS STRING), CAST(in_projekt_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )
      )
  ) AS t13
) AS t14
  ON t00.in_projekt_id = t14.in_projekt_id AND t00.mandant_id = t14.mandant_id
WHERE
  (t00.mandant_id, t00.in_projekt_id) IN (
    SELECT
      (mandant_id, in_projekt_id)
    FROM kfl_production_dbp_view.v_in_psp_element_1
    WHERE
      statistisch_fg = 1
  );
