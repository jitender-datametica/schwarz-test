CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_ma_kreis_zu_per_2 (mandant_id, mitarbeiter_kreis_id,
mitarbeiter_id, dat_von, dat_bis, kjmo, kjmo_von, kjmo_bis) AS SELECT v01.mandant_id,
 v01.mitarbeiter_kreis_id,
 v01.mitarbeiter_id,
 v01.dat_von,
 v01.dat_bis,
 v01.kjmo,
 ROUND(CAST(CAST(EXTRACT(YEAR FROM v01.dat_von) AS STRING) || CASE
     WHEN CAST(TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_von) AS STRING), 1, 19)) AS FLOAT64) < 10
     THEN '0' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_von) AS STRING), 1, 19))
     ELSE TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_von) AS STRING), 1, 19))
     END AS BIGNUMERIC), 0) AS kjmo_von,
 ROUND(CAST(CAST(EXTRACT(YEAR FROM v01.dat_bis) AS STRING) || CASE
     WHEN CAST(TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_bis) AS STRING), 1, 19)) AS FLOAT64) < 10
     THEN '0' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_bis) AS STRING), 1, 19))
     ELSE TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_bis) AS STRING), 1, 19))
     END AS BIGNUMERIC), 0) AS kjmo_bis
FROM kfl_production_dbp_view.v_ma_kreis_zu_per_2 AS v01
 INNER JOIN kfl_production_dbp_view.v_monat_2 AS v02 ON v02.kjmo BETWEEN ROUND(CAST(CAST(EXTRACT(YEAR FROM v01.dat_von) AS STRING)
      || CASE
       WHEN CAST(TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_von) AS STRING), 1, 19)) AS FLOAT64) < 10
       THEN '0' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_von) AS STRING), 1, 19))
       ELSE TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_von) AS STRING), 1, 19))
       END AS BIGNUMERIC), 0) AND (ROUND(CAST(CAST(EXTRACT(YEAR FROM v01.dat_bis) AS STRING) || CASE
        WHEN CAST(TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_bis) AS STRING), 1, 19)) AS FLOAT64) < 10
        THEN '0' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_bis) AS STRING), 1, 19))
        ELSE TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_bis) AS STRING), 1, 19))
        END AS BIGNUMERIC), 0)) AND v01.kjmo = v02.kjmo;