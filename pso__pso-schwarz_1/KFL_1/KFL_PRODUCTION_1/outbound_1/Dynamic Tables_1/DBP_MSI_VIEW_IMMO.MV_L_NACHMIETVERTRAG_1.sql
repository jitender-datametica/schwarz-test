CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_l_nachmietvertrag_1 (
  mandant_id BIGNUMERIC(38, 0),
  mo_intreno STRING(20),
  nach_mv_intreno STRING(20),
  nach_mv_mietvertrag_nr STRING(20),
  mo_status_id BIGNUMERIC(38, 0),
  dat_status_von DATE,
  dat_status_bis DATE,
  dat_miet_beginn DATE,
  dat_miet_ende DATE
) AS
SELECT
  b.mandant_id AS mandant_id,
  b.mo_intreno AS mo_intreno,
  b.mv_intreno AS nach_mv_intreno,
  a.mietvertrag_nr AS nach_mv_mietvertrag_nr,
  b.mo_status_id AS mo_status_id,
  b.dat_status_von AS dat_status_von,
  b.dat_status_bis AS dat_status_bis,
  a.dat_miet_beginn AS dat_miet_beginn,
  a.dat_miet_ende AS dat_miet_ende
FROM kfl_production_dbp_view.v_immo_mietvertrag_per_1 AS a
INNER JOIN kfl_production_dbp_view.v_immo_mo_status_per_1 AS b
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
  CAST('1900-01-01' AS DATE) AS dat_status_von,
  CAST('9999-12-31' AS DATE) AS dat_status_bis,
  CAST('1900-01-01' AS DATE) AS dat_miet_beginn,
  CAST('9999-12-31' AS DATE) AS dat_miet_ende
FROM kfl_production_dbp_view.v_mandant_1;
