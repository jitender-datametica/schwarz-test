CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_wrg_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  von_wrg_id AS wrg_id,
  kurstyp_id AS kurstyp_id,
  dat_von AS dat_von,
  dat_bis AS dat_bis,
  1 / umrechnungskurs AS kurs_zu_euro
FROM kfl_production_dbp_view.v_kurs_1
WHERE
  dat_bis = CAST('9999-12-31' AS DATE) AND kurstyp_id = 3;
