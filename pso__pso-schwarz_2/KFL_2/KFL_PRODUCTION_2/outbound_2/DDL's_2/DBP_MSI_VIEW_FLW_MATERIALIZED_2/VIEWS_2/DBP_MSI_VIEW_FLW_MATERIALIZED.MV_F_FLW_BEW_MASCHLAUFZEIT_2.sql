CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_bew_maschlaufzeit_2 AS WITH BASIC AS (SELECT
   werk_id,
   dat_erfasst,
   zeit_erfasst,
   flw_arbeitsplatz_id,
   auftrag_id,
   loesch_fg,
   dat_haltbarkeit,
   in_art_id,
   mandant_id,
   betrag_bew,
   CAST(REPLACE(CAST(dat_erfasst AS STRING) || ' ' || CAST(zeit_erfasst AS STRING), ',', ':') AS DATETIME) AS new_tss,
    CASE
    WHEN zeit_erfasst < '05:00:00'
    THEN DATE_SUB(dat_erfasst, INTERVAL 1 DAY)
    ELSE dat_erfasst
    END AS produktionstag,
   menge_bme,
   nettogew
  FROM kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_bew_2
  WHERE flw_arbeitsplatz_id IS NOT NULL
   AND flw_beleg_typ_id = 'SE'
   AND dat_erfasst >= PARSE_DATE('%d.%m.%Y', '01.03.' || CAST(EXTRACT(YEAR FROM CURRENT_DATE) - 2 AS STRING))
   AND (werk_id = 5 OR werk_id <> 5 AND loesch_fg = 1)), WECHSEL_TAB AS (SELECT werk_id,
   dat_erfasst,
   zeit_erfasst,
   flw_arbeitsplatz_id,
   auftrag_id,
   loesch_fg,
   dat_haltbarkeit,
   in_art_id,
   mandant_id,
   betrag_bew,
   new_tss,
   produktionstag,
   menge_bme,
   nettogew,
   LAG(new_tss) OVER (PARTITION BY werk_id, produktionstag, flw_arbeitsplatz_id ORDER BY werk_id IS NULL, werk_id,
      dat_erfasst IS NULL, dat_erfasst, zeit_erfasst IS NULL, zeit_erfasst, flw_arbeitsplatz_id IS NULL,
      flw_arbeitsplatz_id) AS time_davor,
   LAG(in_art_id) OVER (PARTITION BY werk_id, produktionstag, flw_arbeitsplatz_id ORDER BY werk_id IS NULL, werk_id,
      dat_erfasst IS NULL, dat_erfasst, zeit_erfasst IS NULL, zeit_erfasst, flw_arbeitsplatz_id IS NULL,
      flw_arbeitsplatz_id) AS mat_vorher,
   LAG(betrag_bew) OVER (PARTITION BY werk_id, produktionstag, flw_arbeitsplatz_id, in_art_id ORDER BY werk_id IS NULL,
      werk_id, dat_erfasst IS NULL, dat_erfasst, zeit_erfasst IS NULL, zeit_erfasst, flw_arbeitsplatz_id IS NULL,
      flw_arbeitsplatz_id) AS preis_vorher,
   LAG(dat_haltbarkeit) OVER (PARTITION BY werk_id, produktionstag, flw_arbeitsplatz_id, in_art_id, betrag_bew ORDER BY
      werk_id IS NULL, werk_id, dat_erfasst IS NULL, dat_erfasst, zeit_erfasst IS NULL, zeit_erfasst,
      flw_arbeitsplatz_id IS NULL, flw_arbeitsplatz_id) AS mhd_vorher,
   LAG(auftrag_id) OVER (PARTITION BY werk_id, produktionstag, flw_arbeitsplatz_id, in_art_id, betrag_bew,
      dat_haltbarkeit ORDER BY werk_id IS NULL, werk_id, dat_erfasst IS NULL, dat_erfasst, zeit_erfasst IS NULL,
      zeit_erfasst, flw_arbeitsplatz_id IS NULL, flw_arbeitsplatz_id) AS auftrag_vorher
  FROM BASIC), TAB2 AS (SELECT werk_id,
   dat_erfasst,
   zeit_erfasst,
   flw_arbeitsplatz_id,
   auftrag_id,
   loesch_fg,
   dat_haltbarkeit,
   in_art_id,
   mandant_id,
   betrag_bew,
   new_tss,
   produktionstag,
   menge_bme,
   nettogew,
   time_davor,
   mat_vorher,
   preis_vorher,
   mhd_vorher,
   auftrag_vorher,
   TIMESTAMP_DIFF(new_tss, time_davor, SECOND) AS zeitdiff_sec,
    CASE
    WHEN mat_vorher <> in_art_id OR mat_vorher IS NULL
    THEN 1
    ELSE 0
    END AS mat_flag,
    CASE
    WHEN betrag_bew <> preis_vorher AND CASE
       WHEN mat_vorher <> in_art_id OR mat_vorher IS NULL
       THEN 1
       ELSE 0
       END = 0
    THEN 1
    ELSE 0
    END AS preis_flag,
    CASE
    WHEN dat_haltbarkeit <> mhd_vorher AND CASE
        WHEN mat_vorher <> in_art_id OR mat_vorher IS NULL
        THEN 1
        ELSE 0
        END = 0 AND CASE
       WHEN betrag_bew <> preis_vorher AND CASE
          WHEN mat_vorher <> in_art_id OR mat_vorher IS NULL
          THEN 1
          ELSE 0
          END = 0
       THEN 1
       ELSE 0
       END = 0
    THEN 1
    ELSE 0
    END AS mhd_flag,
    CASE
    WHEN auftrag_id <> auftrag_vorher AND CASE
         WHEN mat_vorher <> in_art_id OR mat_vorher IS NULL
         THEN 1
         ELSE 0
         END = 0 AND CASE
        WHEN betrag_bew <> preis_vorher AND CASE
           WHEN mat_vorher <> in_art_id OR mat_vorher IS NULL
           THEN 1
           ELSE 0
           END = 0
        THEN 1
        ELSE 0
        END = 0 AND CASE
       WHEN dat_haltbarkeit <> mhd_vorher AND CASE
           WHEN mat_vorher <> in_art_id OR mat_vorher IS NULL
           THEN 1
           ELSE 0
           END = 0 AND CASE
          WHEN betrag_bew <> preis_vorher AND CASE
             WHEN mat_vorher <> in_art_id OR mat_vorher IS NULL
             THEN 1
             ELSE 0
             END = 0
          THEN 1
          ELSE 0
          END = 0
       THEN 1
       ELSE 0
       END = 0
    THEN 1
    ELSE 0
    END AS auftrag_flag,
   SUM(CASE
     WHEN mat_vorher <> in_art_id OR mat_vorher IS NULL
     THEN 1
     ELSE 0
     END) OVER (PARTITION BY werk_id, produktionstag, flw_arbeitsplatz_id ORDER BY werk_id IS NULL, werk_id, dat_erfasst
      IS NULL, dat_erfasst, zeit_erfasst IS NULL, zeit_erfasst ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   anz_wechsel
  FROM WECHSEL_TAB AS t3), TAB03 AS (SELECT werk_id,
   dat_erfasst,
   zeit_erfasst,
   flw_arbeitsplatz_id,
   auftrag_id,
   loesch_fg,
   dat_haltbarkeit,
   in_art_id,
   mandant_id,
   betrag_bew,
   new_tss,
   produktionstag,
   menge_bme,
   nettogew,
   time_davor,
   mat_vorher,
   preis_vorher,
   mhd_vorher,
   auftrag_vorher,
   zeitdiff_sec,
   mat_flag,
   preis_flag,
   mhd_flag,
   auftrag_flag,
   anz_wechsel,
   MAX(new_tss) OVER (PARTITION BY anz_wechsel RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS end_time,
     TRIM(flw_arbeitsplatz_id) || '_' || TRIM(CAST(anz_wechsel AS STRING FORMAT '000')) AS produktionszyklusid,
    CASE
    WHEN mat_flag = 1 AND zeitdiff_sec <= 600
    THEN CAST(zeitdiff_sec AS BIGNUMERIC)
    WHEN mat_flag = 1 AND zeitdiff_sec > 600
    THEN 600.0
    ELSE 0.0
    END AS mat_wechseltime,
    CASE
    WHEN preis_flag = 1 AND zeitdiff_sec <= 600
    THEN CAST(zeitdiff_sec AS BIGNUMERIC)
    WHEN preis_flag = 1 AND zeitdiff_sec > 600
    THEN 600.0
    ELSE 0.0
    END AS preis_wechseltime,
    CASE
    WHEN mhd_flag = 1 AND zeitdiff_sec <= 600
    THEN CAST(zeitdiff_sec AS BIGNUMERIC)
    WHEN mhd_flag = 1 AND zeitdiff_sec > 600
    THEN 600.0
    ELSE 0.0
    END AS mhd_wechseltime,
    CASE
    WHEN auftrag_flag = 1 AND zeitdiff_sec <= 600
    THEN CAST(zeitdiff_sec AS BIGNUMERIC)
    WHEN auftrag_flag = 1 AND zeitdiff_sec > 600
    THEN 600.0
    ELSE 0.0
    END AS auftrag_wechseltime,
    CASE
    WHEN zeitdiff_sec > 180 AND mat_flag = 0 AND preis_flag = 0 AND mhd_flag = 0 AND auftrag_flag = 0 OR zeitdiff_sec >
       600 AND (mat_flag = 1 OR preis_flag = 1 OR mhd_flag = 1 OR auftrag_flag = 1)
    THEN 1
    ELSE 0
    END AS unterbrechungen,
    CASE
    WHEN CASE
       WHEN zeitdiff_sec > 180 AND mat_flag = 0 AND preis_flag = 0 AND mhd_flag = 0 AND auftrag_flag = 0 OR zeitdiff_sec
           > 600 AND (mat_flag = 1 OR preis_flag = 1 OR mhd_flag = 1 OR auftrag_flag = 1)
       THEN 1
       ELSE 0
       END = 1 AND (mat_flag = 1 OR preis_flag = 1 OR mhd_flag = 1 OR auftrag_flag = 1)
    THEN zeitdiff_sec - CASE
         WHEN mat_flag = 1 AND zeitdiff_sec <= 600
         THEN CAST(zeitdiff_sec AS BIGNUMERIC)
         WHEN mat_flag = 1 AND zeitdiff_sec > 600
         THEN 600.0
         ELSE 0.0
         END - CASE
        WHEN preis_flag = 1 AND zeitdiff_sec <= 600
        THEN CAST(zeitdiff_sec AS BIGNUMERIC)
        WHEN preis_flag = 1 AND zeitdiff_sec > 600
        THEN 600.0
        ELSE 0.0
        END - CASE
       WHEN mhd_flag = 1 AND zeitdiff_sec <= 600
       THEN CAST(zeitdiff_sec AS BIGNUMERIC)
       WHEN mhd_flag = 1 AND zeitdiff_sec > 600
       THEN 600.0
       ELSE 0.0
       END - CASE
      WHEN auftrag_flag = 1 AND zeitdiff_sec <= 600
      THEN CAST(zeitdiff_sec AS BIGNUMERIC)
      WHEN auftrag_flag = 1 AND zeitdiff_sec > 600
      THEN 600.0
      ELSE 0.0
      END
    WHEN CASE
          WHEN zeitdiff_sec > 180 AND mat_flag = 0 AND preis_flag = 0 AND mhd_flag = 0 AND auftrag_flag = 0 OR
             zeitdiff_sec > 600 AND (mat_flag = 1 OR preis_flag = 1 OR mhd_flag = 1 OR auftrag_flag = 1)
          THEN 1
          ELSE 0
          END = 1 AND mat_flag = 0 AND preis_flag = 0 AND mhd_flag = 0 AND auftrag_flag = 0
    THEN CAST(zeitdiff_sec AS BIGNUMERIC)
    ELSE 0
    END AS unterberechungszeit
  FROM TAB2 AS t5) (SELECT werk_id,
   flw_arbeitsplatz_id,
   produktionszyklusid,
   in_art_id,
   produktionstag,
   mandant_id,
   new_tss AS zeitstempel_erfasssung,
   dat_haltbarkeit,
   auftrag_id,
   SUM(mat_flag) AS mat_flag,
   SUM(preis_flag) AS preis_flag,
   SUM(mhd_flag) AS mhd_flag,
   SUM(auftrag_flag) AS auftrag_flag,
   COUNT(in_art_id) AS anzahl_kolli,
   SUM(menge_bme) AS menge_bme,
   SUM(nettogew) AS nettogew,
   SUM(betrag_bew) AS betrag_bew,
   SUM(zeitdiff_sec) AS dauer,
   SUM(unterberechungszeit) AS unterberechungszeit,
   SUM(unterbrechungen) AS unterbrechungen,
   SUM(mat_wechseltime) AS mat_wechseltime,
   SUM(preis_wechseltime) AS preis_wechseltime,
   SUM(mhd_wechseltime) AS mhd_wechseltime,
   SUM(auftrag_wechseltime) AS auftrag_wechseltime,
    CASE
    WHEN time_davor IS NULL
    THEN new_tss
    ELSE time_davor
    END AS start_ts,
   CAST(MAX(new_tss) AS TIME) AS end_ts
  FROM TAB03
  GROUP BY werk_id,
   flw_arbeitsplatz_id,
   produktionszyklusid,
   in_art_id,
   produktionstag,
   mandant_id,
   zeitstempel_erfasssung,
   dat_haltbarkeit,
   auftrag_id,
   time_davor);