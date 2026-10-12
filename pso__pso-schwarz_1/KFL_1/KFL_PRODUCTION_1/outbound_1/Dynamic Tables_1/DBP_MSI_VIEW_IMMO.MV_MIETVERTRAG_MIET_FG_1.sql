CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_mietvertrag_miet_fg_1 (
  mandant_id BIGNUMERIC(38, 0),
  mv_intreno STRING(20),
  miet_fg INT64
) AS
SELECT
  v1.mandant_id AS mandant_id,
  v1.mv_intreno AS mv_intreno,
  CASE
    WHEN t0.dat_rueckgabe < CURRENT_DATE OR t0.dat_rueckgabe IS NULL
    THEN 0
    ELSE 1
  END AS miet_fg
FROM kfl_production_dbp_view.v_immo_mietvertrag_per_1 AS v1
LEFT JOIN (
  SELECT
    mv_intreno,
    mandant_id,
    MAX(dat_rueckgabe_am) AS dat_rueckgabe
  FROM kfl_production_dbp_view.v_immo_mietvertrag_sicherheit_1 AS v3
  GROUP BY
    mandant_id,
    mv_intreno
) AS t0
  ON v1.mandant_id = t0.mandant_id AND v1.mv_intreno = t0.mv_intreno
UNION ALL
SELECT
  mandant_id,
  '' AS mv_intreno,
  1 AS miet_fg
FROM kfl_production_dbp_view.v_mandant_1;
