CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_art_gelistete_mo_1
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
  FROM kfl_production_dbp_view.v_art_wup_zu_per_1
  WHERE
    mandant_id <> 1
    AND listung_id = 1
    AND nb_id = 0
    AND dat_bis = CAST('9999-12-31' AS DATE)
) AS v01
INNER JOIN kfl_production_dbp_view.v_monat_1 AS v02
  ON PARSE_DATE('%Y%m', CAST(v02.kjmo AS STRING)) BETWEEN v01.dat_von AND v01.dat_bis
WHERE
  v02.akt_mo <= 0;
