CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_we_mv_distinct_zu_1 (
  mandant_id BIGNUMERIC(38, 0),
  mv_intreno STRING(20),
  we_intreno STRING(20)
) AS
SELECT DISTINCT
  mandant_id AS mandant_id,
  mv_intreno AS mv_intreno,
  we_intreno AS we_intreno
FROM (
  SELECT
    v2.mandant_id,
    v2.we_intreno,
    v1.mv_intreno
  FROM kfl_production_dbp_view.v_immo_mo_status_per_1 AS v1
  INNER JOIN kfl_production_dbp_view.v_immo_mietobjekt_1 AS v2
    ON v1.mo_intreno = v2.mo_intreno
  WHERE
    CURRENT_DATE BETWEEN v1.dat_status_von AND v1.dat_status_bis
  UNION ALL
  SELECT
    v2.mandant_id,
    v2.we_intreno,
    v1.mv_intreno
  FROM kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per_1 AS v1
  INNER JOIN kfl_production_dbp_view.v_immo_mietobjekt_1 AS v2
    ON v1.mo_intreno = v2.mo_intreno
  WHERE
    NOT v1.mv_intreno IN (
      SELECT
        mv_intreno
      FROM kfl_production_dbp_view.v_immo_mo_status_per_1
      WHERE
        CURRENT_DATE BETWEEN dat_status_von AND dat_status_bis
    )
  UNION ALL
  SELECT
    mandant_id,
    we_intreno,
    mv_intreno
  FROM kfl_production_dbp_view.v_immo_mietvertrag_we_zu_per_1 AS v1
  WHERE
    CURRENT_DATE BETWEEN dat_von AND dat_bis
) AS tmp;
