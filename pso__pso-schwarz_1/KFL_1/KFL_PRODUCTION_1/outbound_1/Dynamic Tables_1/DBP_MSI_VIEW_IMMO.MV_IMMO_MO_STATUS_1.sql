CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_immo_mo_status_1 (
  mandant_id BIGNUMERIC(38, 0),
  mo_status_id BIGNUMERIC(38, 0),
  mo_intreno STRING(20),
  mv_intreno STRING(20),
  dat_status_von DATE,
  dat_status_bis DATE,
  dat_uebergabe DATE,
  dat_rueckgabe DATE,
  td_update TIMESTAMP,
  td_insert TIMESTAMP
) AS
SELECT
  *
FROM kfl_production_dbp_view.v_immo_mo_status_per_1 AS v00
WHERE
  CURRENT_DATE BETWEEN dat_status_von AND dat_status_bis;