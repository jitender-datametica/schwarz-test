CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_we_mo_mv_zu_2 (
  mandant_id BIGNUMERIC(38, 0),
  we_intreno STRING(20),
  mo_intreno STRING(20),
  mv_intreno STRING(20)
) AS
SELECT
  v2.mandant_id,
  v2.we_intreno,
  v2.mo_intreno,
  v1.mv_intreno
FROM kfl_production_dbp_view.v_immo_mo_status_per_2 AS v1
INNER JOIN kfl_production_dbp_view.v_immo_mietobjekt_2 AS v2
  ON v1.mo_intreno = v2.mo_intreno
WHERE
  CURRENT_DATE BETWEEN v1.dat_status_von AND v1.dat_status_bis
UNION ALL
SELECT
  v2.mandant_id,
  v2.we_intreno,
  v2.mo_intreno,
  v1.mv_intreno
FROM kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per_2 AS v1
INNER JOIN kfl_production_dbp_view.v_immo_mietobjekt_2 AS v2
  ON v1.mo_intreno = v2.mo_intreno
WHERE
  NOT v1.mv_intreno IN (
    SELECT
      mv_intreno
    FROM kfl_production_dbp_view.v_immo_mo_status_per_2
    WHERE
      CURRENT_DATE BETWEEN dat_status_von AND dat_status_bis
  )
UNION ALL
SELECT
  mandant_id AS mandant_id,
  we_intreno AS we_intreno,
  'Dummy_2' AS mo_intreno,
  mv_intreno AS mv_intreno
FROM kfl_production_dbp_view.v_immo_mietvertrag_we_zu_per_2 AS v1
WHERE
  CURRENT_DATE BETWEEN dat_von AND dat_bis;
