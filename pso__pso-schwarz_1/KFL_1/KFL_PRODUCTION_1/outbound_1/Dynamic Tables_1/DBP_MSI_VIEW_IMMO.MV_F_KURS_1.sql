CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_f_kurs_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  dat_bis AS dat_bis,
  dat_von AS dat_von,
  kurstyp_id AS kurstyp_id,
  nach_wrg_id AS nach_wrg_id,
  von_wrg_id AS von_wrg_id,
  umrechnungskurs AS umrechnungskurs,
  TRUNC(CAST(1 / umrechnungskurs AS BIGNUMERIC)) AS kurs_1
FROM kfl_production_dbp_view.v_kurs_1
WHERE
  dat_bis = CAST('9999-12-31' AS DATE) AND kurstyp_id = 3;
