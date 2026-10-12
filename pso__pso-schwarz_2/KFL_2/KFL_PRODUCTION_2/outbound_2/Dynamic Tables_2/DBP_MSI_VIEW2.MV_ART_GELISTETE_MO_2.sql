CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_art_gelistete_mo_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.art_id AS art_id,
  v01.mandant_id AS mandant_id,
  v01.listung_id AS listung_id,
  v02.kjmo AS kjmo
FROM (
  SELECT
    art_id,
    wup_id,
    dat_von,
    dat_bis,
    mandant_id,
    listung_id
  FROM kfl_production_dbp_view.v_art_wup_zu_per_2
  WHERE
    mandant_id = 1
    AND listung_id = 1
    AND nb_id = 0
    AND dat_bis = CAST('9999-12-31' AS DATE)
) AS v01
INNER JOIN kfl_production_dbp_view.v_monat_2 AS v02
  ON v02.kjmo BETWEEN ROUND(CAST(FORMAT_DATE('%Y%m', v01.dat_von) AS BIGNUMERIC), 0) AND (
    ROUND(CAST(FORMAT_DATE('%Y%m', v01.dat_bis) AS BIGNUMERIC), 0)
  )
WHERE
  v02.akt_mo <= 0;
