CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_art_umrechnung_faktor_per_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  mandant_id AS mandant_id,
  altnv_menge_einh_id AS altnv_menge_einh_id,
  art_id AS art_id,
  dat_von AS dat_von,
  bruttogew AS bruttogew,
  umrech_faktor AS umrech_faktor,
  gew_einh_id AS gew_einh_id,
  dat_bis AS dat_bis,
  laenge AS laenge,
  breite AS breite,
  hoehe AS hoehe
FROM kfl_production_dbp_view.v_art_umrechnung_faktor_per_2
WHERE
  mandant_id = 1
  AND dat_bis = CAST('9999-12-31' AS DATE)
  AND CASE
    WHEN NOT ROUND(SAFE_CAST(altnv_menge_einh_id AS BIGNUMERIC), 0) IS NULL
    THEN 1
    ELSE 0
  END = 1
QUALIFY
  (
    ROW_NUMBER() OVER (
      PARTITION BY CAST(mandant_id AS STRING), CAST(art_id AS STRING)
      ORDER BY CASE
        WHEN IF(ROUND(ROUND(SAFE_CAST(altnv_menge_einh_id AS BIGNUMERIC), 0), 0) IS NULL, 0, 1) = 1
        THEN ROUND(ROUND(CAST(altnv_menge_einh_id AS BIGNUMERIC), 0), 0)
        ELSE 9999999
      END IS NULL, CASE
        WHEN IF(ROUND(ROUND(SAFE_CAST(altnv_menge_einh_id AS BIGNUMERIC), 0), 0) IS NULL, 0, 1) = 1
        THEN ROUND(ROUND(CAST(altnv_menge_einh_id AS BIGNUMERIC), 0), 0)
        ELSE 9999999
      END
    )
  ) = 1
UNION DISTINCT
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
FROM kfl_production_dbp_view.v_art_umrechnung_faktor_per_2
WHERE
  mandant_id = 1
  AND dat_bis = CAST('9999-12-31' AS DATE)
  AND TRIM(altnv_menge_einh_id) = 'ST';
