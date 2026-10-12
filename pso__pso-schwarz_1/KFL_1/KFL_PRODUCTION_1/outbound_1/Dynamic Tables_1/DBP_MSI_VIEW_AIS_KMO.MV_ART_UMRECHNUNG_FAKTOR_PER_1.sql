CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_art_umrechnung_faktor_per_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id,
  altnv_menge_einh_id,
  art_id,
  dat_von,
  bruttogew,
  umrech_faktor,
  gew_einh_id,
  dat_bis,
  laenge,
  breite,
  hoehe
FROM kfl_production_dbp_view.v_art_umrechnung_faktor_per_1
WHERE
  mandant_id = 2
  AND dat_bis = CAST('9999-12-31' AS DATE)
  AND TRIM(altnv_menge_einh_id) IN ('ST', 'KAR');