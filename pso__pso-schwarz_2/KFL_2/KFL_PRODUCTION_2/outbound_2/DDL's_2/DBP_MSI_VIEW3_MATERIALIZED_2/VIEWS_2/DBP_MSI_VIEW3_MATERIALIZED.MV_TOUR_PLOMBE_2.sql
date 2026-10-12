CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_tour_plombe_2 (mandant_id, wup_id, nb_id, tour_id,
plombe_id, mandant_id_kunde, kunde_id, status_tour, cd_fg, tour_kunde_id, dat_scan, max_dat_scan, zeit_scan, scan_dt,
max_scan_dt, plombe_prozess_id, plombe_prozess_bez, dat_plan_ankunft, zeit_plan_ankunft, diff_plan_scan_minuten,
diff_plan_scan_minuten_karenz, nachtfenster_flg, taganlieferung_fg, tour_enthaelt_oug, start_zeit, ende_zeit,
zeit_relevant_fg) AS SELECT dt1.mandant_id,
 dt1.wup_id,
 dt1.nb_id,
 dt1.tour_id,
 dt1.plombe_id,
 dt1.mandant_id_kunde,
 V05.aktuell_wup_id AS kunde_id,
 dt1.status_tour,
 dt1.cd_fg,
 dt1.tour_kunde_id,
 dt1.dat_scan,
 MAX(dt1.dat_scan) OVER (PARTITION BY dt1.wup_id, dt1.tour_id, dt1.kunde_id RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS max_dat_scan,
 dt1.zeit_scan,
 DATETIME(dt1.dat_scan, CAST(TRIM(COALESCE(CAST(dt1.zeit_scan AS STRING), '00:00:00')) AS TIME)) AS scan_dt,
 DATETIME(MAX(dt1.max_dat_scan) OVER (PARTITION BY dt1.wup_id, dt1.tour_id, dt1.kunde_id RANGE BETWEEN
   UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), CAST(TRIM(COALESCE(CAST(MAX(dt1.ende_zeit) OVER (PARTITION BY dt1.wup_id, dt1.tour_id, dt1.kunde_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS STRING)
     , '00:00:00')) AS TIME)) AS max_scan_dt,
 dt1.plombe_prozess_id,
 dt1.plombe_prozess_bez,
 dt1.dat_plan_ankunft,
 dt1.zeit_plan_ankunft,
 dt1.diff_plan_scan_minuten,
 dt1.diff_plan_scan_minuten_karenz,
 dt1.nachtfenster_flg,
 dt1.taganlieferung_fg,
 dt1.tour_enthaelt_oug,
 dt1.start_zeit,
 dt1.ende_zeit,
 dt1.zeit_relevant_fg
FROM (SELECT v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.tour_id,
   t9.plombe_id,
   v01.mandant_id_kunde,
   v01.kunde_id,
   v01.status_tour,
   v01.cd_fg,
      TRIM(SUBSTR(CAST(v01.mandant_id AS STRING), 1, 39)) || TRIM(SUBSTR(CAST(v01.tour_id AS STRING), 1, 10)) || TRIM(SUBSTR(CAST(v01.mandant_id_kunde AS STRING)
       , 1, 39)) || TRIM(v01.kunde_id) AS tour_kunde_id,
   t9.dat_scan,
   t9.max_dat_scan,
   PARSE_TIME('%I:%M:%S', CAST(t9.zeit_scan AS STRING)) AS zeit_scan,
   t9.plombe_prozess_id,
    CASE
    WHEN t9.plombe_prozess_id IN (1, 3)
    THEN 'Plombe'
    WHEN t9.plombe_prozess_id = 2
    THEN 'WE-Palette'
    ELSE NULL
    END AS plombe_prozess_bez,
   v01.dat_tour AS dat_plan_ankunft,
   TIME(v01.zeit_plan_ankunft) AS zeit_plan_ankunft,
   t9.timestamp_scan,
   v01.timestamp_plan_ankunft AS timestamp_plan_ankunft_,
    CASE
    WHEN DATE(v01.timestamp_plan_ankunft) = DATE '9999-12-31'
    THEN NULL
    ELSE CASE
     WHEN v01.timestamp_plan_ankunft IS NOT NULL AND t9.timestamp_scan IS NOT NULL
     THEN TRUNC(CAST(TIMESTAMP_DIFF(t9.timestamp_scan, v01.timestamp_plan_ankunft, SECOND) / 60 AS BIGNUMERIC))
     ELSE NULL
     END
    END AS diff_plan_scan_minuten,
    CAST(CASE
      WHEN DATE(v01.timestamp_plan_ankunft) = DATE '9999-12-31'
      THEN NULL
      ELSE CASE
       WHEN v01.timestamp_plan_ankunft IS NOT NULL AND t9.timestamp_scan IS NOT NULL
       THEN TRUNC(CAST(TIMESTAMP_DIFF(t9.timestamp_scan, v01.timestamp_plan_ankunft, SECOND) / 60 AS BIGNUMERIC))
       ELSE NULL
       END
      END AS BIGNUMERIC) - 15 AS diff_plan_scan_minuten_karenz,
   DATETIME(DATE_ADD(v01.dat_tour, INTERVAL -1 DAY), '23:59:59') AS timestamp_nacht_start,
   DATETIME(v01.dat_tour, '06:00:00') AS timestamp_nacht_ende,
    CASE
    WHEN v01.timestamp_plan_ankunft IS NOT NULL
    THEN CASE
     WHEN v01.timestamp_plan_ankunft BETWEEN DATETIME(DATE_ADD(v01.dat_tour, INTERVAL -1 DAY), '23:59:59') AND (DATETIME(v01
        .dat_tour, '06:00:00'))
     THEN 1
     ELSE 0
     END
    ELSE NULL
    END AS nachtfenster_flg,
    CASE
    WHEN v01.mandant_id = 1 AND CAST(snowconvert_public.time_to_int_udf(v01.zeit_plan_ankunft) AS INTEGER) BETWEEN 54500
       AND 220000 OR v01.mandant_id <> 1
    THEN 1
    ELSE 0
    END AS taganlieferung_fg,
   v01a.tour_enthaelt_oug,
   t9.start_zeit,
   t9.ende_zeit,
   v01.zeit_relevant_fg
  FROM (SELECT mandant_id,
     nb_id,
     wup_id,
     tour_id,
     kunde_id,
     mandant_id_kunde,
     status_tour,
     cd_fg,
     zeit_plan_ankunft,
     dat_tour,
     DATETIME(dat_tour, CAST(TRIM(CAST(zeit_plan_ankunft AS STRING)) AS TIME)) AS timestamp_plan_ankunft,
     zeit_relevant_fg
    FROM kfl_production_dbp_view.v_tour_det_zlv_vttkl_2 AS V011
    WHERE zeit_relevant_fg = 1) AS v01
   LEFT JOIN (SELECT V0110.mandant_id,
     V0110.nb_id,
     V0110.wup_id,
     V0110.tour_id,
     V0110.kunde_id,
     V0110.mandant_id_kunde,
     MAX(V012.oug_fg) AS tour_enthaelt_oug
    FROM kfl_production_dbp_view.v_tour_det_zlv_vttkl_2 AS V0110
     INNER JOIN kfl_production_dbp_view.v_l_lagernummer_2 AS V012 ON V0110.mandant_id = V012.mandant_id AND V0110.lagernummer_id
        = V012.lagernummer_id
    WHERE V0110.menge_stp_geraeumt <> 0
    GROUP BY V0110.mandant_id,
     V0110.nb_id,
     V0110.wup_id,
     V0110.tour_id,
     V0110.kunde_id,
     V0110.mandant_id_kunde) AS v01a ON v01.mandant_id = v01a.mandant_id AND v01.tour_id = v01a.tour_id AND v01.wup_id =
      v01a.wup_id AND v01.kunde_id = v01a.kunde_id
   LEFT JOIN (SELECT mandant_id,
     tour_id,
     plombe_id,
     wup_id,
     nb_id,
     dat_scan_ AS dat_scan,
     max_dat_scan_ AS max_dat_scan,
      CASE
      WHEN CAST(start_zeit_ AS STRING) < CAST(zeit_scan_ AS STRING)
      THEN CAST(start_zeit_ AS STRING)
      ELSE CAST(zeit_scan_ AS STRING)
      END AS zeit_scan,
     start_zeit_ AS start_zeit,
     ende_zeit_ AS ende_zeit,
     plombe_prozess_id,
     plombe_aktivitaet,
     info_code,
     timestamp_scan_ AS timestamp_scan
    FROM (SELECT mandant_id,
       tour_id,
       plombe_id,
       wup_id,
       nb_id,
       plombe_prozess_id,
       plombe_aktivitaet,
       info_code,
       dat_scan_,
       zeit_scan__,
       zeit_scan_,
       timestamp_scan_,
       MIN(timestamp_scan_) OVER (PARTITION BY mandant_id, tour_id, wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING) AS min_timestamp_scan_,
       MAX(dat_scan_) OVER (PARTITION BY mandant_id, tour_id, wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING) AS max_dat_scan_,
       CAST(MIN(timestamp_scan_) OVER (PARTITION BY mandant_id, tour_id, wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS TIME)
       AS start_zeit_,
       MAX(CASE
         WHEN plombe_prozess_id = 2
         THEN timestamp_scan_
         ELSE NULL
         END) OVER (PARTITION BY mandant_id, tour_id, wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
       AS tmp_max_2,
       MAX(CASE
         WHEN plombe_prozess_id = 3
         THEN timestamp_scan_
         ELSE NULL
         END) OVER (PARTITION BY mandant_id, tour_id, wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
       AS tmp_max_3,
       SUM(CASE
         WHEN plombe_prozess_id = 2 AND dat_scan_ IS NOT NULL
         THEN 1
         ELSE 0
         END) OVER (PARTITION BY mandant_id, tour_id, wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
       AS tmp_anz_pid_2,
       CAST(CASE
         WHEN (SUM(CASE
             WHEN plombe_prozess_id = 2 AND dat_scan_ IS NOT NULL
             THEN 1
             ELSE 0
             END) OVER (PARTITION BY mandant_id, tour_id, wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
         THEN MAX(CASE
           WHEN plombe_prozess_id = 2
           THEN timestamp_scan_
           ELSE NULL
           END) OVER (PARTITION BY mandant_id, tour_id, wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         ELSE MAX(CASE
           WHEN plombe_prozess_id = 3
           THEN timestamp_scan_
           ELSE NULL
           END) OVER (PARTITION BY mandant_id, tour_id, wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
         END AS TIME) AS ende_zeit_
      FROM (SELECT mandant_id,
         tour_id,
         plombe_id,
         wup_id,
         nb_id,
         plombe_prozess_id,
         plombe_aktivitaet,
         info_code,
          CASE
          WHEN mandant_id IN (4, 7, 8) AND COALESCE(snowconvert_public.time_to_int_udf(zeit_scan), 0) >= 230000
          THEN DATE_ADD(dat_scan, INTERVAL 1 DAY)
          ELSE dat_scan
          END AS dat_scan_,
          CASE
          WHEN mandant_id IN (4, 7, 8)
          THEN CASE
           WHEN COALESCE(snowconvert_public.time_to_int_udf(zeit_scan), 0) >= 230000
           THEN snowconvert_public.int_to_time_udf(snowconvert_public.time_to_int_udf(zeit_scan) - 230000)
           ELSE snowconvert_public.int_to_time_udf(snowconvert_public.time_to_int_udf(zeit_scan) + 10000)
           END
          ELSE zeit_scan 
          END AS zeit_scan__,
          CASE
          WHEN mandant_id IN (4, 7, 8)
          THEN CASE
           WHEN COALESCE(snowconvert_public.time_to_int_udf(zeit_scan), 0) >= 230000
           THEN snowconvert_public.int_to_time_udf(snowconvert_public.time_to_int_udf(zeit_scan) - 230000)
           ELSE snowconvert_public.int_to_time_udf(snowconvert_public.time_to_int_udf(zeit_scan) + 10000)
           END
          ELSE zeit_scan 
          END AS zeit_scan_,
         MIN(CASE
           WHEN CASE
            WHEN mandant_id IN (4, 7, 8) AND COALESCE(snowconvert_public.time_to_int_udf(zeit_scan), 0) >= 230000
            THEN DATE_ADD(dat_scan, INTERVAL 1 DAY)
            ELSE dat_scan
            END IS NOT NULL
           THEN DATETIME(CASE
             WHEN mandant_id IN (4, 7, 8) AND COALESCE(snowconvert_public.time_to_int_udf(zeit_scan), 0) >= 230000
             THEN DATE_ADD(dat_scan, INTERVAL 1 DAY)
             ELSE dat_scan
             END, CASE
             WHEN mandant_id IN (4, 7, 8)
             THEN CASE
              WHEN COALESCE(snowconvert_public.time_to_int_udf(zeit_scan), 0) >= 230000
              THEN snowconvert_public.int_to_time_udf(snowconvert_public.time_to_int_udf(zeit_scan) - 230000)
              ELSE snowconvert_public.int_to_time_udf(snowconvert_public.time_to_int_udf(zeit_scan) + 10000)
              END
             ELSE zeit_scan
             END)
           ELSE NULL
           END) AS timestamp_scan_
        FROM kfl_production_dbp_view.v_tour_plombe_ziel_2 AS V022
        WHERE dat_scan IS NOT NULL
         AND (plombe_aktivitaet <> 13 OR info_code <= 0)
        GROUP BY mandant_id,
         tour_id,
         plombe_id,
         wup_id,
         nb_id,
         plombe_prozess_id,
         plombe_aktivitaet,
         info_code,
         dat_scan_,
         zeit_scan__,
         zeit_scan_) AS t5) AS v021
    WHERE dat_scan_ IS NOT NULL
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY mandant_id, tour_id, wup_id, nb_id ORDER BY timestamp_scan_ IS NULL,
          timestamp_scan_, plombe_prozess_id IS NULL, plombe_prozess_id)) = 1) AS t9 ON v01.mandant_id_kunde = t9.mandant_id
       AND v01.tour_id = t9.tour_id AND CAST(ROUND(CAST(SUBSTR(v01.kunde_id, 7, 4) AS FLOAT64)) AS INTEGER) = t9.wup_id
  ) AS dt1
 LEFT JOIN kfl_production_dbp_view.v_wup_2 AS V05 ON V05.mandant_id = CASE
     WHEN dt1.mandant_id_kunde IS NULL OR dt1.mandant_id_kunde = 0
     THEN dt1.mandant_id
     ELSE dt1.mandant_id_kunde
     END AND V05.wup_id = CASE
     WHEN SAFE_CAST(ROUND(CAST(dt1.kunde_id AS FLOAT64)) AS INTEGER) = 0
     THEN NULL
     ELSE SAFE_CAST(ROUND(CAST(dt1.kunde_id AS FLOAT64)) AS INTEGER)
     END AND (V05.nb_id IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id = 0);