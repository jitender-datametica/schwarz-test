CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_konzessionaer_per_1 AS SELECT mandant_id,
 konzessionaer_id,
 LENGTH(konzessionaer_name) AS k_len,
 SUBSTR(kfl_production_dbp_process.transcriptc(konzessionaer_name), 1, 6) AS k_006,
 SUBSTR(kfl_production_dbp_process.transcriptc(konzessionaer_name), 1, 3) AS k_003,
 kfl_production_dbp_process.transcriptc(CASE
   WHEN konzessionaer_id = '0'
   THEN ' '
   WHEN SUBSTR(kfl_production_dbp_process.transcriptc(konzessionaer_name), 1, 6) = 'KK MB ' OR SUBSTR(kfl_production_dbp_process.transcriptc(konzessionaer_name
       ), 1, 6) = 'KK  MB'
   THEN TRIM(SUBSTR(konzessionaer_name, 7, LENGTH(konzessionaer_name) - 7))
   WHEN SUBSTR(kfl_production_dbp_process.transcriptc(konzessionaer_name), 1, 3) = 'KK ' OR SUBSTR(kfl_production_dbp_process.transcriptc(konzessionaer_name
       ), 1, 3) = 'MB '
   THEN TRIM(SUBSTR(konzessionaer_name, 4, LENGTH(konzessionaer_name) - 3))
   ELSE konzessionaer_name
   END) AS konzessionaer_name,
  CASE
  WHEN konzessionaer_id = '0'
  THEN '0'
  ELSE konzessionaer_gruppe_id
  END AS konz_gruppe_id,
  CASE
  WHEN konzessionaer_id = '0'
  THEN '0'
  ELSE konzessionaer_holding_id
  END AS konzessionaer_holding_id,
 dat_von,
 dat_bis,
 SUBSTR(CAST(COALESCE(konzessionaer_branche_id, '000') AS STRING), 1, 3) AS konzessionaer_branche_id,
 SUBSTR(CAST(CASE
    WHEN konzessionaer_id = '0'
    THEN 'E'
    ELSE intern_fg
    END AS STRING), 1, 1) AS intern_fg,
 land_id,
 konzessionaer_plz,
 kfl_production_dbp_process.transcriptc(konzessionaer_ort) AS konzessionaer_ort,
 kfl_production_dbp_process.transcriptc(konzessionaer_strasse) AS konzessionaer_strasse,
 konzessionaer_rechtsform,
 dat_insolvenz_eintritt,
 konzessionaer_topmieter_fg
FROM kfl_production_dbp_view.v_ivs_konzessionaer_per_1
WHERE dat_bis = DATE('9999-12-31');