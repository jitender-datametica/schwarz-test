CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_art_lagemenge_zu
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.art_id AS art_id,
  COALESCE(v02.lagemenge, 1) AS lagemenge
FROM kfl_production_dbp_view.v_art AS v01
LEFT JOIN (
  SELECT
    mandant_id,
    art_id,
    CAST(1 / umrech_faktor AS BIGNUMERIC) AS lagemenge
  FROM kfl_production_dbp_view.v_art_umrechnung_faktor_per
  WHERE
    altnv_menge_einh_id = 'VST' AND dat_bis = CAST('9999-12-31' AS DATE)
) AS v02
  ON v01.mandant_id = v02.mandant_id AND v01.art_id = v02.art_id;
