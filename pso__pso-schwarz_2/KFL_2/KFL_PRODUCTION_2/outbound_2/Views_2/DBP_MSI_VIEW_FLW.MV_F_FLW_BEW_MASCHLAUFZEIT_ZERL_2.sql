-- 04.10.2023 twie: SPEC0208428 spezielle Logik für Zerlegung, angelehnt an MV_F_FLW_BEW_MASCHLAUFZEIT_2

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_bew_maschlaufzeit_zerl_2 AS WITH BASIC AS (SELECT werk_id
   ,
   dat_erfasst,
   zeit_erfasst,
   terminal_id,
   ext_tiernummer,
   in_art_id,
   mandant_id,
   betrag_bew,
   CAST(REPLACE(CAST(dat_erfasst AS STRING) || ' ' || CAST(zeit_erfasst AS STRING), ',', ':') AS DATETIME) AS new_tss,
    CASE
    WHEN zeit_erfasst < '04:00:00'
    THEN DATE_SUB(dat_erfasst, INTERVAL 1 DAY)
    ELSE dat_erfasst
    END AS produktionstag,
   menge_bme,
   menge_dme,
   nettogew
  FROM kfl_production_dbp_msi_view_flw.mv_f_flw_bew_2
  WHERE flw_beleg_typ_id = 'WA' -- Einschrankung auf die letzten beiden GJ und das aktuelle GJ

   AND dat_erfasst >= PARSE_DATE('%d.%m.%Y', '01.03.' || CAST(EXTRACT(YEAR FROM CURRENT_DATE) - 2 AS STRING))),
 WECHSEL_TAB AS (SELECT werk_id,
   dat_erfasst,
   zeit_erfasst,
   terminal_id,
   ext_tiernummer,
   in_art_id,
   mandant_id,
   betrag_bew,
   new_tss,
   produktionstag,
   menge_bme,
   menge_dme,
   nettogew,
   LAG(new_tss) OVER (PARTITION BY CAST(werk_id AS STRING), produktionstag, terminal_id ORDER BY werk_id IS NULL,
      werk_id, dat_erfasst IS NULL, dat_erfasst, zeit_erfasst IS NULL, zeit_erfasst, terminal_id IS NULL, terminal_id)
   AS time_davor,
   LAG(ext_tiernummer) OVER (PARTITION BY CAST(werk_id AS STRING), produktionstag, terminal_id ORDER BY werk_id IS NULL
      , werk_id, dat_erfasst IS NULL, dat_erfasst, zeit_erfasst IS NULL, zeit_erfasst, terminal_id IS NULL, terminal_id
    ) AS ident_vorher
  FROM BASIC), TAB2 AS (SELECT werk_id,
   dat_erfasst,
   zeit_erfasst,
   terminal_id,
   ext_tiernummer,
   in_art_id,
   mandant_id,
   betrag_bew,
   new_tss,
   produktionstag,
   menge_bme,
   menge_dme,
   nettogew,
   time_davor,
   ident_vorher,
   TIMESTAMP_DIFF(new_tss, time_davor, SECOND) AS zeitdiff_sec,
    CASE
    WHEN ident_vorher <> ext_tiernummer OR ident_vorher IS NULL
    THEN 1
    ELSE 0
    END AS ident_flag,
   SUM(CASE
     WHEN ident_vorher <> ext_tiernummer OR ident_vorher IS NULL
     THEN 1
     ELSE 0
     END) OVER (PARTITION BY CAST(werk_id AS STRING), produktionstag, terminal_id ORDER BY werk_id IS NULL, werk_id,
      dat_erfasst IS NULL, dat_erfasst, zeit_erfasst IS NULL, zeit_erfasst ROWS BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW) AS anz_wechsel
  FROM WECHSEL_TAB AS t3), TAB03 AS (SELECT werk_id,
   dat_erfasst,
   zeit_erfasst,
   terminal_id,
   ext_tiernummer,
   in_art_id,
   mandant_id,
   betrag_bew,
   new_tss,
   produktionstag,
   menge_bme,
   menge_dme,
   nettogew,
   time_davor,
   ident_vorher,
   zeitdiff_sec,
   ident_flag,
   anz_wechsel,
   MAX(new_tss) OVER (PARTITION BY anz_wechsel RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS end_time,
     TRIM(terminal_id) || '_' || TRIM(CAST(anz_wechsel AS STRING FORMAT '000')) AS produktionszyklusid,
    CASE
    WHEN ident_flag = 1 AND zeitdiff_sec <= 600
    THEN CAST(zeitdiff_sec AS BIGNUMERIC)
    WHEN ident_flag = 1 AND zeitdiff_sec > 600
    THEN 600.0
    ELSE 0.0
    END AS ident_wechseltime,
    CASE
    WHEN zeitdiff_sec > 60 AND ident_flag = 0 OR zeitdiff_sec > 600 AND ident_flag = 1
    THEN 1
    ELSE 0
    END AS unterbrechungen,
    CASE
    WHEN CASE
       WHEN zeitdiff_sec > 60 AND ident_flag = 0 OR zeitdiff_sec > 600 AND ident_flag = 1
       THEN 1
       ELSE 0
       END = 1 AND ident_flag = 1
    THEN zeitdiff_sec - CASE
      WHEN ident_flag = 1 AND zeitdiff_sec <= 600
      THEN CAST(zeitdiff_sec AS BIGNUMERIC)
      WHEN ident_flag = 1 AND zeitdiff_sec > 600
      THEN 600.0
      ELSE 0.0
      END
    WHEN CASE
       WHEN zeitdiff_sec > 60 AND ident_flag = 0 OR zeitdiff_sec > 600 AND ident_flag = 1
       THEN 1
       ELSE 0
       END = 1 AND ident_flag = 0
    THEN CAST(zeitdiff_sec AS BIGNUMERIC)
    ELSE 0
    END AS unterberechungszeit
  FROM TAB2 AS t5) (-- auszeichnungspreis
 -- Zeit_2 davor
 -- Identwechsel
 -- Identwechsel
 -- 
 -- timegaps
 -- Ident

  -- Unterbrechung
 -- wenn kein Wechsel vorliegt, dann liegt eine_2 Unterbrechung vor bei einer Dauer ueber 1 min

  -- wenn ein Wechsel vorliegt, dann werden 10 min dem Wechsel zu geschrieben und alles darueberhinaus der Unterbrechung

  -- Unterbrechungszeit.
 -- unterbrechungen
 -- Wechselzeit
 SELECT werk_id,
   terminal_id,
   ext_tiernummer,
   produktionszyklusid,
   in_art_id,
   produktionstag,
   mandant_id,
   new_tss AS zeitstempel_erfasssung,
   SUM(ident_flag) AS ident_flag,
   COUNT(in_art_id) AS anzahl_kolli,
   SUM(menge_bme) AS menge_bme,
   SUM(menge_dme) AS menge_dme,
   SUM(nettogew) AS nettogew,
   SUM(betrag_bew) AS betrag_bew,
   SUM(zeitdiff_sec) AS dauer,
   SUM(unterberechungszeit) AS unterberechungszeit,
   SUM(unterbrechungen) AS unterbrechungen,
   SUM(ident_wechseltime) AS ident_wechseltime,
    CASE
    WHEN time_davor IS NULL
    THEN new_tss
    ELSE time_davor
    END AS start_ts,
   CAST(MAX(new_tss) AS TIME) AS end_ts
  FROM TAB03
  GROUP BY werk_id,
   terminal_id,
   ext_tiernummer,
   produktionszyklusid,
   in_art_id,
   produktionstag,
   mandant_id,
   zeitstempel_erfasssung,
   time_davor);