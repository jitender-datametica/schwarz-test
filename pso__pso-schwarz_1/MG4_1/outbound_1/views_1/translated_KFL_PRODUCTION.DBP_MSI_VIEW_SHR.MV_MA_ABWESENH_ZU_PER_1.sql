CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_ma_abwesenh_zu_per_1 (mandant_id, abwesenheit_id,
abwesenheit_bez, mitarbeiter_id, dat_von, dat_bis, kjmo, kjmo_von, kjmo_bis, dauer_tage, abwesenheit_stunden) AS SELECT
 v01.mandant_id,
 v01.abwesenheit_id,
 v03.abwesenheit_bez,
 v01.mitarbeiter_id,
 v01.dat_von,
 v01.dat_bis,
 v01.kjmo,
 ROUND(CAST(CAST(EXTRACT(YEAR FROM v01.dat_von) AS STRING) || CASE
     WHEN CAST(TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_von) AS STRING), 1, 19)) AS FLOAT64) < 10
     THEN '0' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_von) AS STRING), 1, 19))
     ELSE TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_von) AS STRING), 1, 19))
     END AS BIGNUMERIC), 0) AS kjmo_von,
  CASE
  WHEN v01.dat_bis < v02.max_dat AND (v01.mandant_id = 1 AND v01.abwesenheit_id IN ('0601') OR v01.mandant_id = 2 AND
             v01.abwesenheit_id IN ('0530', '0540') OR v01.mandant_id = 3 AND v01.abwesenheit_id IN ('0600', '0601') OR
           v01.mandant_id = 4 AND v01.abwesenheit_id IN ('0100') OR v01.mandant_id = 5 AND v01.abwesenheit_id IN ('0530'
           ) OR v01.mandant_id = 6 AND v01.abwesenheit_id IN ('0251') OR v01.mandant_id = 7 AND v01.abwesenheit_id IN ('0530'
         ) OR v01.mandant_id = 8 AND v01.abwesenheit_id IN ('0515', '0530', '0531'))
  THEN ROUND(CAST(CAST(EXTRACT(YEAR FROM v01.dat_bis) AS STRING) || CASE
       WHEN CAST(TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_bis) AS STRING), 1, 19)) AS FLOAT64) < 10
       THEN '0' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_bis) AS STRING), 1, 19))
       ELSE TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_bis) AS STRING), 1, 19))
       END AS BIGNUMERIC), 0) - 1
  ELSE ROUND(CAST(CAST(EXTRACT(YEAR FROM v01.dat_bis) AS STRING) || CASE
      WHEN CAST(TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_bis) AS STRING), 1, 19)) AS FLOAT64) < 10
      THEN '0' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_bis) AS STRING), 1, 19))
      ELSE TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_bis) AS STRING), 1, 19))
      END AS BIGNUMERIC), 0)
  END AS kjmo_bis,
  CASE
  WHEN v01.dat_bis <= DATE_SUB(v02.max_dat, INTERVAL 1 DAY)
  THEN 0
  WHEN v01.dat_bis >= v02.max_dat
  THEN DATE_DIFF(v02.max_dat, v01.dat_von, DAY)
  ELSE DATE_DIFF(v01.dat_bis, v01.dat_von, DAY)
  END AS dauer_tage,
 v01.abwesenheit_stunden
FROM kfl_production_dbp_view.v_ma_abwesenh_zu_per_1 AS v01
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS v02 ON v02.kjmo BETWEEN ROUND(CAST(CAST(EXTRACT(YEAR FROM v01.dat_von) AS STRING)
      || CASE
       WHEN CAST(TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_von) AS STRING), 1, 19)) AS FLOAT64) < 10
       THEN '0' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_von) AS STRING), 1, 19))
       ELSE TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_von) AS STRING), 1, 19))
       END AS BIGNUMERIC), 0) AND CASE
    WHEN v01.dat_bis < v02.max_dat AND (v01.mandant_id = 1 AND v01.abwesenheit_id IN ('0601') OR v01.mandant_id = 2 AND
               v01.abwesenheit_id IN ('0530', '0540') OR v01.mandant_id = 3 AND v01.abwesenheit_id IN ('0600', '0601')
           OR v01.mandant_id = 4 AND v01.abwesenheit_id IN ('0100') OR v01.mandant_id = 5 AND v01.abwesenheit_id IN ('0530'
             ) OR v01.mandant_id = 6 AND v01.abwesenheit_id IN ('0251') OR v01.mandant_id = 7 AND v01.abwesenheit_id IN
           ('0530') OR v01.mandant_id = 8 AND v01.abwesenheit_id IN ('0515', '0530', '0531'))
    THEN ROUND(CAST(CAST(EXTRACT(YEAR FROM v01.dat_bis) AS STRING) || CASE
         WHEN CAST(TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_bis) AS STRING), 1, 19)) AS FLOAT64) < 10
         THEN '0' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_bis) AS STRING), 1, 19))
         ELSE TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_bis) AS STRING), 1, 19))
         END AS BIGNUMERIC), 0) - 1
    ELSE ROUND(CAST(CAST(EXTRACT(YEAR FROM v01.dat_bis) AS STRING) || CASE
        WHEN CAST(TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_bis) AS STRING), 1, 19)) AS FLOAT64) < 10
        THEN '0' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_bis) AS STRING), 1, 19))
        ELSE TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM v01.dat_bis) AS STRING), 1, 19))
        END AS BIGNUMERIC), 0)
    END AND v01.kjmo = v02.kjmo
 LEFT JOIN kfl_production_dbp_view.v_mitarbeiter_abwesenh_spr_zu_1 AS v03 ON v01.abwesenheit_id = v03.abwesenheit_id AND
    v01.mandant_id = v03.mandant_id AND v03.spr_id = 22;