CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_l_mietobjekt_1 (
  mandant_id BIGNUMERIC(38, 0),
  mo_intreno STRING(20),
  mo_smenr STRING(8),
  mo_objekt_nr STRING(30),
  dat_letzte_uebergabe DATE
) AS
SELECT
  v0.mandant_id AS mandant_id,
  v0.mo_intreno AS mo_intreno,
  v0.mo_smenr AS mo_smenr,
  v0.mo_objekt_nr AS mo_objekt_nr,
  v1.dat_letzte_uebergabe AS dat_letzte_uebergabe
FROM kfl_production_dbp_view.v_immo_mietobjekt_1 AS v0
INNER JOIN (
  SELECT
    mandant_id,
    mo_intreno,
    MAX(mo_status_id) AS mo_status_id
  FROM kfl_production_dbp_view.v_immo_mo_status_per_1
  WHERE
    CURRENT_DATE BETWEEN dat_status_von AND dat_status_bis
  GROUP BY
    mandant_id,
    mo_intreno
) AS v5
  ON v0.mandant_id = v5.mandant_id AND v0.mo_intreno = v5.mo_intreno
LEFT JOIN (
  SELECT
    mandant_id,
    mo_status_id,
    mo_intreno,
    MAX(dat_status_von) AS dat_letzte_uebergabe
  FROM kfl_production_dbp_view.v_immo_mo_status_per_1
  WHERE
    mo_status_id = 4 AND CURRENT_DATE BETWEEN dat_status_von AND dat_status_bis
  GROUP BY
    mandant_id,
    mo_status_id,
    mo_intreno
) AS v1
  ON v0.mandant_id = v1.mandant_id AND v0.mo_intreno = v1.mo_intreno;
