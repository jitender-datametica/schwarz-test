CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_aktion
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.aktion_id AS aktion_id,
  v01.mandant_id AS mandant_id,
  v01.bewart_id AS bewart_id,
  v01.aktionsart_id AS aktionsart_id,
  v01.werbe_kat_id AS werbe_kat_id,
  v01.dat_von AS dat_von,
  v01.dat_bis AS dat_bis,
  v01.kjwo_von AS ww_kjwo
FROM kfl_production_dbp_view.v_aktion AS v01
INNER JOIN kfl_production_dbp_view.v_woche_kj_kl AS v02
  ON v01.kjwo_von = v02.kjwo
WHERE
  v01.mandant_id = 1 AND v02.akt_kj BETWEEN -3 AND 0;
