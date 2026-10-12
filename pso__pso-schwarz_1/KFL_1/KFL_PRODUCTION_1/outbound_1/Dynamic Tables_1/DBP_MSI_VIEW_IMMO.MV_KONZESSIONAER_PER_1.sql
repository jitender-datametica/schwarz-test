CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_konzessionaer_per_1 AS
SELECT
  mandant_id AS mandant_id,
  konzessionaer_id AS konzessionaer_id,
  SUBSTR(kfl_production_dbp_process.transcriptc(konzessionaer_name), 1, 6) AS k_006,
  SUBSTR(kfl_production_dbp_process.transcriptc(konzessionaer_name), 1, 3) AS k_003,
  LENGTH(konzessionaer_name) AS k_len,
  kfl_production_dbp_process.transcriptc(
    CASE
      WHEN konzessionaer_id = '0'
      THEN ' '
      WHEN SUBSTR(kfl_production_dbp_process.transcriptc(konzessionaer_name), 1, 6) = 'KK MB '
      OR SUBSTR(kfl_production_dbp_process.transcriptc(konzessionaer_name), 1, 6) = 'KK  MB'
      THEN TRIM(SUBSTR(konzessionaer_name, 7, LENGTH(konzessionaer_name) - 7))
      WHEN SUBSTR(kfl_production_dbp_process.transcriptc(konzessionaer_name), 1, 3) = 'KK '
      OR SUBSTR(kfl_production_dbp_process.transcriptc(konzessionaer_name), 1, 3) = 'MB '
      THEN TRIM(SUBSTR(konzessionaer_name, 4, LENGTH(konzessionaer_name) - 3))
      ELSE konzessionaer_name
    END
  ) AS konzessionaer_name,
  CASE WHEN konzessionaer_id = '0' THEN '0' ELSE konzessionaer_gruppe_id END AS konz_gruppe_id,
  CASE WHEN konzessionaer_id = '0' THEN '0' ELSE konzessionaer_holding_id END AS konzessionaer_holding_id,
  dat_von AS dat_von,
  dat_bis AS dat_bis,
  SUBSTR(CAST(COALESCE(konzessionaer_branche_id, '000') AS STRING), 1, 3) AS konzessionaer_branche_id,
  SUBSTR(CAST(CASE WHEN konzessionaer_id = '0' THEN 'E' ELSE intern_fg END AS STRING), 1, 1) AS intern_fg,
  land_id AS land_id,
  konzessionaer_plz AS konzessionaer_plz,
  kfl_production_dbp_process.transcriptc(konzessionaer_ort) AS konzessionaer_ort,
  kfl_production_dbp_process.transcriptc(konzessionaer_strasse) AS konzessionaer_strasse,
  konzessionaer_rechtsform AS konzessionaer_rechtsform,
  dat_insolvenz_eintritt AS dat_insolvenz_eintritt,
  konzessionaer_topmieter_fg AS konzessionaer_topmieter_fg,
  ROW_NUMBER() OVER (PARTITION BY konzessionaer_id ORDER BY dat_von IS NULL DESC, dat_von DESC) AS row_nr
FROM kfl_production_dbp_view.v_ivs_konzessionaer_per_1
WHERE
  dat_bis = CAST('9999-12-31' AS DATE)
QUALIFY
  (
    ROW_NUMBER() OVER (PARTITION BY konzessionaer_id ORDER BY dat_von IS NULL DESC, dat_von DESC)
  ) = 1;
