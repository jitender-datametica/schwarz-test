CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_regalachse (
  mandant_id BIGNUMERIC(38, 0),
  regalachse_id BIGNUMERIC(38, 0),
  layoutbaustein_id BIGNUMERIC(38, 0),
  layoutbaustein_version BIGNUMERIC(38, 0),
  dat_von DATE,
  dat_bis_neu DATE,
  fbb_nr STRING(20),
  platzierungsstufe_id STRING(3),
  wup_id BIGNUMERIC(38, 0),
  nb_id BIGNUMERIC(38, 0),
  achsgruppe_id BIGNUMERIC(38, 0),
  regalachse_flaeche NUMERIC(9, 2),
  achs_nr STRING(20)
) AS
SELECT
  mandant_id AS mandant_id,
  regalachse_id AS regalachse_id,
  layoutbaustein_id AS layoutbaustein_id,
  layoutbaustein_version AS layoutbaustein_version,
  dat_von AS dat_von,
  CASE
    WHEN SUBSTR(fbb_nr, 1, 4) >= 'P150' AND dat_bis <> CAST('9999-12-31' AS DATE)
    THEN DATE_ADD(dat_bis, INTERVAL '150' DAY)
    ELSE dat_bis
  END AS dat_bis_neu,
  fbb_nr AS fbb_nr,
  platzierungsstufe_id AS platzierungsstufe_id,
  wup_id AS wup_id,
  nb_id AS nb_id,
  achsgruppe_id AS achsgruppe_id,
  regalachse_flaeche AS regalachse_flaeche,
  SUBSTR(fbb_nr, LENGTH(fbb_nr) - 3, 3) AS achs_nr
FROM kfl_production_dbp_view.v_regalachse
WHERE
  mandant_id = 1
  AND (
    SUBSTR(platzierungsstufe_id, 1, 1) IN ('X', 'Y', 'Z')
    OR CAST(SUBSTR(platzierungsstufe_id, 3, 1) AS FLOAT64) = 0
    AND NOT SUBSTR(platzierungsstufe_id, 1, 1) IN ('X', 'Y', 'Z')
  )
  AND CASE
    WHEN SUBSTR(fbb_nr, 1, 4) >= 'P150' AND dat_bis <> CAST('9999-12-31' AS DATE)
    THEN DATE_ADD(dat_bis, INTERVAL '150' DAY)
    ELSE dat_bis
  END >= CURRENT_DATE
QUALIFY
  (
    ROW_NUMBER() OVER (
      PARTITION BY CAST(mandant_id AS STRING), fbb_nr
      ORDER BY CASE
        WHEN SUBSTR(fbb_nr, 1, 4) >= 'P150' AND dat_bis <> CAST('9999-12-31' AS DATE)
        THEN DATE_ADD(dat_bis, INTERVAL '150' DAY)
        ELSE dat_bis
      END IS NULL, CASE
        WHEN SUBSTR(fbb_nr, 1, 4) >= 'P150' AND dat_bis <> CAST('9999-12-31' AS DATE)
        THEN DATE_ADD(dat_bis, INTERVAL '150' DAY)
        ELSE dat_bis
      END
    )
  ) = 1;
