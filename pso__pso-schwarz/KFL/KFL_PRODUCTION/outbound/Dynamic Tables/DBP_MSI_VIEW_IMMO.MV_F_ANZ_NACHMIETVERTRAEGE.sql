CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_f_anz_nachmietvertraege (
  mandant_id BIGNUMERIC(38, 0),
  mo_intreno STRING(20),
  mv_intreno STRING(20),
  konzessionaer_id STRING(10),
  nach_mv_intreno STRING(20),
  nach_mv_mietvertrag_nr STRING(20),
  nach_mv_status_id BIGNUMERIC(38, 0),
  anz_nach_mv INT64
) AS
SELECT
  v.mandant_id AS mandant_id,
  v.mo_intreno AS mo_intreno,
  v.mv_intreno AS mv_intreno,
  v.partner_id AS konzessionaer_id,
  CASE WHEN v.anz_nach_mv > 1 THEN '' ELSE v.nach_mv_intreno END AS nach_mv_intreno,
  CASE WHEN v.anz_nach_mv > 1 THEN '' ELSE v.nach_mv_mietvertrag_nr END AS nach_mv_mietvertrag_nr,
  CASE WHEN v.anz_nach_mv = 1 THEN w.mo_status_id ELSE CAST(-1 AS BIGNUMERIC) END AS nach_mv_status_id,
  v.anz_nach_mv AS anz_nach_mv
FROM (
  SELECT
    a.mandant_id,
    a.partner_id,
    b.mo_intreno,
    a.mv_intreno,
    COALESCE(t8.nach_mv_intreno, '') AS nach_mv_intreno,
    COALESCE(t8.nach_mv_mietvertrag_nr, '') AS nach_mv_mietvertrag_nr,
    COUNT(c.nach_mv_intreno) AS anz_nach_mv
  FROM kfl_production_dbp_view.v_immo_mietvertrag_per AS a
  INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per AS b
    ON a.mandant_id = b.mandant_id AND a.mv_intreno = b.mv_intreno
  LEFT JOIN (
    SELECT
      b.mandant_id,
      b.mo_intreno,
      b.mv_intreno AS nach_mv_intreno,
      a.mietvertrag_nr AS nach_mv_mietvertrag_nr,
      b.mo_status_id AS nach_mv_status_id,
      b.dat_status_von,
      b.dat_status_bis,
      a.dat_miet_beginn,
      a.dat_miet_ende
    FROM kfl_production_dbp_view.v_immo_mietvertrag_per AS a
    INNER JOIN kfl_production_dbp_view.v_immo_mo_status_per AS b
      ON a.mandant_id = b.mandant_id AND a.mv_intreno = b.mv_intreno
    WHERE
      a.dat_miet_beginn > CURRENT_DATE
      AND CURRENT_DATE BETWEEN b.dat_status_von AND b.dat_status_bis
    UNION ALL
    SELECT
      mandant_id,
      '' AS mo_intreno,
      '' AS nach_mv_intreno,
      '' AS nach_mv_mietvertrag_nr,
      -1 AS mo_status_id,
      CAST('01.01.1900' AS DATE) AS dat_status_von,
      CAST('31.12.9999' AS DATE) AS dat_status_bis,
      CAST('01.01.1900' AS DATE) AS dat_miet_beginn,
      CAST('31.12.9999' AS DATE) AS dat_miet_ende
    FROM kfl_production_dbp_view.v_mandant
  ) AS c
    ON b.mandant_id = c.mandant_id AND b.mo_intreno = c.mo_intreno
  LEFT JOIN (
    SELECT
      a.mandant_id,
      b.mo_intreno,
      a.mv_intreno,
      MAX(c.nach_mv_intreno) AS nach_mv_intreno,
      MAX(c.nach_mv_mietvertrag_nr) AS nach_mv_mietvertrag_nr
    FROM kfl_production_dbp_view.v_immo_mietvertrag_per AS a
    INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per AS b
      ON a.mandant_id = b.mandant_id AND a.mv_intreno = b.mv_intreno
    LEFT JOIN (
      SELECT
        b.mandant_id,
        b.mo_intreno,
        b.mv_intreno AS nach_mv_intreno,
        a.mietvertrag_nr AS nach_mv_mietvertrag_nr,
        b.mo_status_id AS nach_mv_status_id,
        b.dat_status_von,
        b.dat_status_bis,
        a.dat_miet_beginn,
        a.dat_miet_ende
      FROM kfl_production_dbp_view.v_immo_mietvertrag_per AS a
      INNER JOIN kfl_production_dbp_view.v_immo_mo_status_per AS b
        ON a.mandant_id = b.mandant_id AND a.mv_intreno = b.mv_intreno
      WHERE
        a.dat_miet_beginn > CURRENT_DATE
        AND CURRENT_DATE BETWEEN b.dat_status_von AND b.dat_status_bis
      UNION ALL
      SELECT
        mandant_id,
        '' AS mo_intreno,
        '' AS nach_mv_intreno,
        '' AS nach_mv_mietvertrag_nr,
        -1 AS mo_status_id,
        CAST('01.01.1900' AS DATE) AS dat_status_von,
        CAST('31.12.9999' AS DATE) AS dat_status_bis,
        CAST('01.01.1900' AS DATE) AS dat_miet_beginn,
        CAST('31.12.9999' AS DATE) AS dat_miet_ende
      FROM kfl_production_dbp_view.v_mandant
    ) AS c
      ON b.mandant_id = c.mandant_id AND b.mo_intreno = c.mo_intreno
    GROUP BY
      a.mandant_id,
      a.mv_intreno,
      b.mo_intreno
  ) AS t8
    ON b.mandant_id = t8.mandant_id
    AND b.mo_intreno = t8.mo_intreno
    AND b.mv_intreno = t8.mv_intreno
  GROUP BY
    a.mandant_id,
    a.partner_id,
    b.mo_intreno,
    a.mv_intreno,
    nach_mv_intreno,
    nach_mv_mietvertrag_nr
) AS v
LEFT JOIN (
  SELECT
    *
  FROM kfl_production_dbp_view.v_immo_mo_status_per
  WHERE
    CURRENT_DATE BETWEEN dat_status_von AND dat_status_bis
) AS w
  ON v.mandant_id = w.mandant_id
  AND v.mo_intreno = w.mo_intreno
  AND v.nach_mv_intreno = w.mv_intreno
UNION ALL
SELECT
  mandant_id,
  mo_intreno,
  '' AS mv_intreno,
  '' AS konzessionaer_id,
  '' AS nach_mv_intreno,
  '' AS nach_mv_mietvertrag_nr,
  -1 AS nach_mv_status_id,
  0 AS anz_nach_mv
FROM kfl_production_dbp_view.v_immo_mo_status_per AS t1
WHERE
  CURRENT_DATE BETWEEN dat_status_von AND dat_status_bis AND mo_status_id = 0;
