CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_r_mv_nachmietvertrag_1 (
  mandant_id BIGNUMERIC(38, 0),
  mv_intreno STRING(20),
  nach_mv_intreno STRING(20),
  nach_mv_dat_miet_beginn DATE,
  nach_mv_dat_miet_ende DATE
) AS
SELECT
  v1.mandant_id AS mandant_id,
  v1.mv_intreno AS mv_intreno,
  COALESCE(v2.nach_mv_intreno, '') AS nach_mv_intreno,
  MAX(v2.nach_mv_dat_miet_beginn) AS nach_mv_dat_miet_beginn,
  MAX(v2.nach_mv_dat_miet_ende) AS nach_mv_dat_miet_ende
FROM (
  SELECT
    a.mandant_id,
    b.mo_intreno,
    b.mv_intreno,
    a.dat_miet_beginn AS mv_dat_miet_beginn,
    a.dat_miet_ende AS mv_dat_miet_ende
  FROM kfl_production_dbp_view.v_immo_mietvertrag_per_1 AS a
  INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per_1 AS b
    ON a.mandant_id = b.mandant_id
    AND a.mv_intreno = b.mv_intreno
    AND CURRENT_DATE BETWEEN a.dat_miet_beginn AND a.dat_miet_ende
) AS v1
LEFT JOIN (
  SELECT
    a0.mandant_id,
    b0.mo_intreno,
    b0.mv_intreno AS nach_mv_intreno,
    a0.dat_miet_beginn AS nach_mv_dat_miet_beginn,
    a0.dat_miet_ende AS nach_mv_dat_miet_ende
  FROM kfl_production_dbp_view.v_immo_mietvertrag_per_1 AS a0
  INNER JOIN kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per_1 AS b0
    ON a0.mandant_id = b0.mandant_id
    AND a0.mv_intreno = b0.mv_intreno
    AND CURRENT_DATE < a0.dat_miet_beginn
) AS v2
  ON v1.mandant_id = v2.mandant_id AND v1.mo_intreno = v2.mo_intreno
GROUP BY
  v1.mandant_id,
  v1.mv_intreno,
  nach_mv_intreno;
