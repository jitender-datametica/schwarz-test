CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_ma_abwesenh_zu_per_2 (mandant_id, abwesenheit_id,
abwesenheit_bez, mitarbeiter_id, dat_von, dat_bis, kjmo, kjmo_von, kjmo_bis, dauer_tage, abwesenheit_stunden) AS SELECT
 V01.mandant_id,
 V01.abwesenheit_id,
 V03.abwesenheit_bez,
 V01.mitarbeiter_id,
 V01.dat_von,
 V01.dat_bis,
 V01.kjmo,
 ROUND(CAST(CAST(EXTRACT(YEAR FROM V01.dat_von) AS STRING) || CASE
     WHEN CAST(TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_von) AS STRING), 1, 19)) AS FLOAT64) < 10
     THEN '0' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_von) AS STRING), 1, 19))
     ELSE TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_von) AS STRING), 1, 19))
     END AS BIGNUMERIC), 0) AS kjmo_von,
  CASE
  WHEN V01.dat_bis < V02.max_dat AND (V01.mandant_id = 1 AND V01.abwesenheit_id IN ('0601') OR V01.mandant_id = 2 AND
             V01.abwesenheit_id IN ('0530', '0540') OR V01.mandant_id = 3 AND V01.abwesenheit_id IN ('0600', '0601') OR
           V01.mandant_id = 4 AND V01.abwesenheit_id IN ('0100') OR V01.mandant_id = 5 AND V01.abwesenheit_id IN ('0530'
           ) OR V01.mandant_id = 6 AND V01.abwesenheit_id IN ('0251') OR V01.mandant_id = 7 AND V01.abwesenheit_id IN ('0530'
         ) OR V01.mandant_id = 8 AND V01.abwesenheit_id IN ('0515', '0530', '0531'))
  THEN ROUND(CAST(CAST(EXTRACT(YEAR FROM V01.dat_bis) AS STRING) || CASE
       WHEN CAST(TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_bis) AS STRING), 1, 19)) AS FLOAT64) < 10
       THEN '0' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_bis) AS STRING), 1, 19))
       ELSE TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_bis) AS STRING), 1, 19))
       END AS BIGNUMERIC), 0) - 1
  ELSE ROUND(CAST(CAST(EXTRACT(YEAR FROM V01.dat_bis) AS STRING) || CASE
      WHEN CAST(TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_bis) AS STRING), 1, 19)) AS FLOAT64) < 10
      THEN '0' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_bis) AS STRING), 1, 19))
      ELSE TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_bis) AS STRING), 1, 19))
      END AS BIGNUMERIC), 0)
  END AS kjmo_bis,
  CASE
  WHEN V01.dat_bis <= DATE_SUB(V02.max_dat, INTERVAL 1 DAY)
  THEN 0
  WHEN V01.dat_bis >= V02.max_dat
  THEN DATE_DIFF(V02.max_dat, V01.dat_von, DAY)
  ELSE DATE_DIFF(V01.dat_bis, V01.dat_von, DAY)
  END AS dauer_tage,
 V01.abwesenheit_stunden
FROM kfl_production_dbp_view.v_ma_abwesenh_zu_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_monat_2 AS V02 ON V02.kjmo BETWEEN ROUND(CAST(CAST(EXTRACT(YEAR FROM V01.dat_von) AS STRING)
      || CASE
       WHEN CAST(TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_von) AS STRING), 1, 19)) AS FLOAT64) < 10
       THEN '0' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_von) AS STRING), 1, 19))
       ELSE TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_von) AS STRING), 1, 19))
       END AS BIGNUMERIC), 0) AND CASE
    WHEN V01.dat_bis < V02.max_dat AND (V01.mandant_id = 1 AND V01.abwesenheit_id IN ('0601') OR V01.mandant_id = 2 AND
               V01.abwesenheit_id IN ('0530', '0540') OR V01.mandant_id = 3 AND V01.abwesenheit_id IN ('0600', '0601')
           OR V01.mandant_id = 4 AND V01.abwesenheit_id IN ('0100') OR V01.mandant_id = 5 AND V01.abwesenheit_id IN ('0530'
             ) OR V01.mandant_id = 6 AND V01.abwesenheit_id IN ('0251') OR V01.mandant_id = 7 AND V01.abwesenheit_id IN
           ('0530') OR V01.mandant_id = 8 AND V01.abwesenheit_id IN ('0515', '0530', '0531'))
    THEN ROUND(CAST(CAST(EXTRACT(YEAR FROM V01.dat_bis) AS STRING) || CASE
         WHEN CAST(TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_bis) AS STRING), 1, 19)) AS FLOAT64) < 10
         THEN '0' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_bis) AS STRING), 1, 19))
         ELSE TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_bis) AS STRING), 1, 19))
         END AS BIGNUMERIC), 0) - 1
    ELSE ROUND(CAST(CAST(EXTRACT(YEAR FROM V01.dat_bis) AS STRING) || CASE
        WHEN CAST(TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_bis) AS STRING), 1, 19)) AS FLOAT64) < 10
        THEN '0' || TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_bis) AS STRING), 1, 19))
        ELSE TRIM(SUBSTR(CAST(EXTRACT(MONTH FROM V01.dat_bis) AS STRING), 1, 19))
        END AS BIGNUMERIC), 0)
    END AND V01.kjmo = V02.kjmo
 LEFT JOIN kfl_production_dbp_view.v_mitarbeiter_abwesenh_spr_zu_2 AS V03 ON V01.abwesenheit_id = V03.abwesenheit_id AND
    V01.mandant_id = V03.mandant_id AND V03.spr_id = 22;