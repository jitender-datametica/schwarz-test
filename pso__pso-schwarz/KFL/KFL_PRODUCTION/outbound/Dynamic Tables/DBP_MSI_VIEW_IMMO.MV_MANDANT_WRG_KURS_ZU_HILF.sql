CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mwt.mandant_id AS mandant_id,
  mwt.wrg_id AS wrg_id,
  mwt.wrg_typ_id AS wrg_typ_id,
  CASE WHEN mwt.wrg_typ_id = 0 THEN lw.umrechnungskurs ELSE 1.0000000 END AS kurs,
  ROUND(1 / CASE WHEN mwt.wrg_typ_id = 0 THEN lw.umrechnungskurs ELSE 1.0000000 END, 2) AS umrechnungskurs,
  DATE('1900-01-01') AS kurs_dat_von,
  DATE('9999-12-31') AS kurs_dat_bis
FROM kfl_production_dbp_view.v_mandant_wrg_typ_zu AS mwt
INNER JOIN kfl_production_dbp_view.v_mandant AS m
  ON mwt.mandant_id = m.mandant_id
INNER JOIN kfl_production_dbp_view.v_kurs AS lw
  ON m.default_wrg = lw.von_wrg_id
  AND lw.nach_wrg_id = 'EUR'
  AND lw.kurstyp_id = 3
  AND lw.dat_bis = CAST('9999-12-31' AS DATE);
