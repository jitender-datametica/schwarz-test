CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_MISS_ITEM_WH_WK COMMENT = 'Counts the missing items per warehouse/partial week'
(
  client_id                       COMMENT 'MIS Client ID'
, loc_sid_wh                      COMMENT 'S-Key der Gesellschaft'
, wh_id                           COMMENT 'Gesellschaft ID'
, aspect_id                       COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, currency_iso_cd                 COMMENT '3 stelliger Währungs-Code'
, curr_tot_id                     COMMENT 'Interner Währungs-Code'
, cy_week_partial_week_id         COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_month                        COMMENT 'Geschäftsjahr - Woche Id - Format "JJJJMM"'
, busyear                         COMMENT 'Geschäftsjahr'
, skipped_cnt                     COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'
, day_cnt                         COMMENT 'Anzahl der öffenen Tage der Woche'
, store_day_cnt                   COMMENT 'Anzahl der öffenen Filialen-Tage der Woche'
, miss_item_cnt_d1                COMMENT 'Anzahl der Fehlartikel Tag 1 (Montag)'
, miss_item_cnt_d2                COMMENT 'Anzahl der Fehlartikel Tag 2 (Dienstag)'
, miss_item_cnt_d3                COMMENT 'Anzahl der Fehlartikel Tag 3 (Mittwoch)'
, miss_item_cnt_d4                COMMENT 'Anzahl der Fehlartikel Tag 4 (Donnerstag)'
, miss_item_cnt_d5                COMMENT 'Anzahl der Fehlartikel Tag 5 (Freitag)'
, miss_item_cnt_d6                COMMENT 'Anzahl der Fehlartikel Tag 6 (Samstag)'
, miss_item_cnt_d7                COMMENT 'Anzahl der Fehlartikel Tag 7 (Sonntag)'
, miss_item_cnt                   COMMENT 'Gesamt Anzahl der Fehlartikeln der Woche'
, miss_item_cnt_avg_day           COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der augelaufenen Fehlartikel der Woche)'
, store_day_cnt_vj                COMMENT 'Anzahl der öffenen Tage der Woche aus dem Vorjahr'
, skipped_cnt_vj                  COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_vj                COMMENT 'Gesamt Anzahl der Fehlartikeln der Woche aus dem Vorjahr'
, miss_item_cnt_avg_day_vj        COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der augelaufenen Fehlartikel der Woche aus dem Vorjahr)'
, miss_item_cnt_avg_day_diff      COMMENT 'Differenz zwischen den Durschnittswert (aktuell) und dem Duchschnittswert (Vorjahr)'
, store_day_cnt_mtd               COMMENT 'Anzahl der öffenen Tagen aufgelaufen des Monats'
, skipped_cnt_mtd                 COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_mtd               COMMENT 'Gesamt Anzahl der Fehlartikeln aufgelaufen des Monats'
, store_day_cnt_mtd_vj            COMMENT 'Anzahl der öffenen Tagen aufgelaufen des Monats aus dem Vorjahr'
, skipped_cnt_mtd_vj              COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_mtd_vj            COMMENT 'Gesamt Anzahl der Fehlartikeln aufgelaufen des Monats aus dem Vorjahr'
, miss_item_cnt_avg_day_mtd       COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Monats)'
, miss_item_cnt_avg_day_mtd_vj    COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Monats aus dem Vorjahr)'
, miss_item_cnt_avg_day_mtd_diff  COMMENT 'Differenz zwischen den Durschnittswert (aufgelaufen des Monats) und dem Duchschnittswert (aufgelaufen des Monats aus dem Vorjahr)'
, store_day_cnt_ytd               COMMENT 'Anzahl der öffenen aufgelaufen Tagen des aktuellen Geschäftsjahrs'
, skipped_cnt_ytd                 COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_ytd               COMMENT 'Gesamt Anzahl der aufgelaufenden Fehlartikeln des aktuellen Geschäftsjahres'
, store_day_cnt_ytd_vj            COMMENT 'Anzahl der öffenen aufgelaufen Tagen des Vorgeschäftsjahres'
, skipped_cnt_ytd_vj              COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_ytd_vj            COMMENT 'Gesamt Anzahl der aufgelaufenden Fehlartikeln des Vorgeschäftsjahres'
, miss_item_cnt_avg_day_ytd       COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des aktuellen Geschäftsjahres)'
, miss_item_cnt_avg_day_ytd_vj    COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Vorgeschäftsjahres)'
, miss_item_cnt_avg_day_ytd_diff  COMMENT 'Differenz zwischen den Durschnittswert (aufgelaufen aktuelles Geschäftsjahr) und dem Duchschnittswert (aufgelaufen Vorgeschäftsjahr)'
)
AS
/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/partial week.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     17.08.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#-----------------------------------------------------------------------------
*/
SELECT   d.client_id
       , d.loc_sid_wh
       , d.wh_id
       , d.aspect_id
       , d.currency_iso_cd
       , d.curr_tot_id
       , d.cy_week_partial_week_id
       , d.cy_month
       , d.busyear
       , d.skipped_cnt_wtd
       , d.day_cnt_wtd
       , d.store_day_cnt_wtd
       , d.miss_item_cnt_d1
       , d.miss_item_cnt_d2
       , d.miss_item_cnt_d3
       , d.miss_item_cnt_d4
       , d.miss_item_cnt_d5
       , d.miss_item_cnt_d6
       , d.miss_item_cnt_d7
       , d.miss_item_cnt_wtd
       , CASE WHEN d.store_day_cnt_wtd > 0 THEN (d.miss_item_cnt_wtd / d.store_day_cnt_wtd) ELSE 0 END        AS miss_item_cnt_avg_day_wtd
       , d.store_day_cnt_wtd_vj
       , d.skipped_cnt_wtd_vj
       , d.miss_item_cnt_wtd_vj
       , CASE WHEN d.store_day_cnt_wtd_vj > 0 THEN (d.miss_item_cnt_wtd_vj / d.store_day_cnt_wtd_vj) ELSE 0 END AS miss_item_cnt_avg_day_wtd_vj
       , miss_item_cnt_avg_day_wtd - miss_item_cnt_avg_day_wtd_vj                                             AS miss_item_cnt_avg_day_wtd_diff
       , d.mtd_store_day_cnt                                                                                  AS store_day_cnt_mtd
       , d.mtd_skipped_cnt                                                                                    AS skipped_cnt_mtd
       , d.mtd_miss_item_cnt                                                                                  AS miss_item_cnt_mtd
       , d.mtd_store_day_cnt_vj                                                                               AS store_day_cnt_mtd_vj
       , d.mtd_skipped_cnt_vj                                                                                 AS skipped_cnt_mtd_vj
       , d.mtd_miss_item_cnt_vj                                                                               AS miss_item_cnt_mtd_vj
       , CASE WHEN d.mtd_store_day_cnt    > 0 THEN d.mtd_miss_item_cnt    / d.mtd_store_day_cnt    ELSE 0 END AS miss_item_cnt_avg_day_mtd
       , CASE WHEN d.mtd_store_day_cnt_vj > 0 THEN d.mtd_miss_item_cnt_vj / d.mtd_store_day_cnt_vj ELSE 0 END AS miss_item_cnt_avg_day_mtd_vj
       , miss_item_cnt_avg_day_mtd - miss_item_cnt_avg_day_mtd_vj                                             AS miss_item_cnt_avg_day_mtd_diff
       , d.ytd_store_day_cnt     + d.mtd_store_day_cnt                                                        AS store_day_cnt_ytd
       , d.ytd_skipped_cnt       + d.mtd_skipped_cnt                                                          AS skipped_cnt_ytd
       , d.ytd_miss_item_cnt     + d.mtd_miss_item_cnt                                                        AS miss_item_cnt_ytd
       , d.ytd_store_day_cnt_vj  + d.mtd_store_day_cnt_vj                                                     AS store_day_cnt_ytd_vj
       , d.ytd_skipped_cnt_vj    + d.mtd_skipped_cnt_vj                                                       AS skipped_cnt_ytd_vj
       , d.ytd_miss_item_cnt_vj  + d.mtd_miss_item_cnt_vj                                                     AS miss_item_cnt_ytd_vj
       , CASE WHEN store_day_cnt_ytd     > 0 THEN miss_item_cnt_ytd    / store_day_cnt_ytd    ELSE 0 END      AS miss_item_cnt_avg_day_ytd
       , CASE WHEN store_day_cnt_ytd_vj  > 0 THEN miss_item_cnt_ytd_vj / store_day_cnt_ytd_vj ELSE 0 END      AS miss_item_cnt_avg_day_ytd_vj
       , miss_item_cnt_avg_day_ytd - miss_item_cnt_avg_day_ytd_vj                                             AS miss_item_cnt_avg_day_ytd_diff

  FROM (
         SELECT DISTINCT  w.client_id
               , w.loc_sid_wh
               , w.wh_id
               , w.aspect_id
               , w.currency_iso_cd
               , w.curr_tot_id
               , w.cy_week_partial_week_id
               , w.cy_month
               , w.busyear
               , SUM(w.skipped_cnt_wtd     ) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS skipped_cnt_wtd
               , SUM(w.day_cnt_wtd         ) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS day_cnt_wtd
               , SUM(w.store_day_cnt_wtd   ) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS store_day_cnt_wtd
               , SUM(w.miss_item_cnt_d1    ) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS miss_item_cnt_d1
               , SUM(w.miss_item_cnt_d2    ) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS miss_item_cnt_d2
               , SUM(w.miss_item_cnt_d3    ) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS miss_item_cnt_d3
               , SUM(w.miss_item_cnt_d4    ) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS miss_item_cnt_d4
               , SUM(w.miss_item_cnt_d5    ) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS miss_item_cnt_d5
               , SUM(w.miss_item_cnt_d6    ) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS miss_item_cnt_d6
               , SUM(w.miss_item_cnt_d7    ) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS miss_item_cnt_d7
               , SUM(w.miss_item_cnt_wtd   ) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS miss_item_cnt_wtd
               , SUM(w.store_day_cnt_wtd_vj) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS store_day_cnt_wtd_vj
               , SUM(w.skipped_cnt_wtd_vj  ) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS skipped_cnt_wtd_vj
               , SUM(w.miss_item_cnt_wtd_vj) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS miss_item_cnt_wtd_vj
               , SUM(COALESCE(mtd_skipped_cnt     ,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS mtd_skipped_cnt
               , SUM(COALESCE(mtd_miss_item_cnt   ,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS mtd_miss_item_cnt
               , SUM(COALESCE(mtd_store_day_cnt   ,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS mtd_store_day_cnt
               , SUM(COALESCE(mtd_skipped_cnt_vj  ,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS mtd_skipped_cnt_vj
               , SUM(COALESCE(mtd_miss_item_cnt_vj,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS mtd_miss_item_cnt_vj
               , SUM(COALESCE(mtd_store_day_cnt_vj,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS mtd_store_day_cnt_vj
               , SUM(COALESCE(ytd_skipped_cnt     ,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS ytd_skipped_cnt
               , SUM(COALESCE(ytd_miss_item_cnt   ,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS ytd_miss_item_cnt
               , SUM(COALESCE(ytd_store_day_cnt   ,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS ytd_store_day_cnt
               , SUM(COALESCE(ytd_skipped_cnt_vj  ,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS ytd_skipped_cnt_vj
               , SUM(COALESCE(ytd_miss_item_cnt_vj,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS ytd_miss_item_cnt_vj
               , SUM(COALESCE(ytd_store_day_cnt_vj,0)) OVER (PARTITION BY w.client_id, w.wh_id, w.aspect_id, w.cy_week_partial_week_id, w.curr_tot_id) AS ytd_store_day_cnt_vj

          FROM (
                 SELECT DISTINCT client_id
                         , loc_sid_wh
                         , wh_id
                         , aspect_id
                         , currency_iso_cd
                         , curr_tot_id
                         , cy_week_partial_week_id
                         , cy_month
                         , busyear
                         , SUM(skipped_cnt)                                              OVER (PARTITION BY client_id, wh_id, aspect_id, cy_week_partial_week_id, curr_tot_id) AS skipped_cnt_wtd
                         , SUM(CASE WHEN miss_item_cnt IS NOT NULL THEN 1   ELSE 0 END)  OVER (PARTITION BY client_id, wh_id, aspect_id, cy_week_partial_week_id, curr_tot_id) AS day_cnt_wtd
                         , SUM(store_cnt)                                                OVER (PARTITION BY client_id, wh_id, aspect_id, cy_week_partial_week_id, curr_tot_id) AS store_day_cnt_wtd
                         , SUM(CASE WHEN day_of_week = 1 THEN miss_item_cnt ELSE 0 END)  OVER (PARTITION BY client_id, wh_id, aspect_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_d1
                         , SUM(CASE WHEN day_of_week = 2 THEN miss_item_cnt ELSE 0 END)  OVER (PARTITION BY client_id, wh_id, aspect_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_d2
                         , SUM(CASE WHEN day_of_week = 3 THEN miss_item_cnt ELSE 0 END)  OVER (PARTITION BY client_id, wh_id, aspect_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_d3
                         , SUM(CASE WHEN day_of_week = 4 THEN miss_item_cnt ELSE 0 END)  OVER (PARTITION BY client_id, wh_id, aspect_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_d4
                         , SUM(CASE WHEN day_of_week = 5 THEN miss_item_cnt ELSE 0 END)  OVER (PARTITION BY client_id, wh_id, aspect_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_d5
                         , SUM(CASE WHEN day_of_week = 6 THEN miss_item_cnt ELSE 0 END)  OVER (PARTITION BY client_id, wh_id, aspect_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_d6
                         , SUM(CASE WHEN day_of_week = 7 THEN miss_item_cnt ELSE 0 END)  OVER (PARTITION BY client_id, wh_id, aspect_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_d7
                         , SUM(miss_item_cnt)                                            OVER (PARTITION BY client_id, wh_id, aspect_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_wtd
                         , SUM(store_cnt_vj)                                             OVER (PARTITION BY client_id, wh_id, aspect_id, cy_week_partial_week_id, curr_tot_id) AS store_day_cnt_wtd_vj
                         , SUM(skipped_cnt_vj)                                           OVER (PARTITION BY client_id, wh_id, aspect_id, cy_week_partial_week_id, curr_tot_id) AS skipped_cnt_wtd_vj
                         , SUM(miss_item_cnt_vj)                                         OVER (PARTITION BY client_id, wh_id, aspect_id, cy_week_partial_week_id, curr_tot_id) AS miss_item_cnt_wtd_vj
                         , CAST(NULL AS NUMBER(38,0))   AS mtd_skipped_cnt
                         , CAST(NULL AS NUMBER(38,0))   AS mtd_miss_item_cnt
                         , CAST(NULL AS NUMBER(38,0))   AS mtd_store_day_cnt
                         , CAST(NULL AS NUMBER(38,0))   AS mtd_skipped_cnt_vj
                         , CAST(NULL AS NUMBER(38,0))   AS mtd_miss_item_cnt_vj
                         , CAST(NULL AS NUMBER(38,0))   AS mtd_store_day_cnt_vj
                         , CAST(NULL AS NUMBER(38,0))   AS ytd_skipped_cnt
                         , CAST(NULL AS NUMBER(38,0))   AS ytd_miss_item_cnt
                         , CAST(NULL AS NUMBER(38,0))   AS ytd_store_day_cnt
                         , CAST(NULL AS NUMBER(38,0))   AS ytd_skipped_cnt_vj
                         , CAST(NULL AS NUMBER(38,0))   AS ytd_miss_item_cnt_vj
                         , CAST(NULL AS NUMBER(38,0))   AS ytd_store_day_cnt_vj

                   FROM P_LEW_MART_LEAD.v_agg_miss_item_wh_day

                  UNION ALL

                 SELECT DISTINCT pw.client_id
                         , pw.loc_sid_wh
                         , pw.wh_id
                         , pw.aspect_id
                         , pw.currency_iso_cd
                         , pw.curr_tot_id
                         , cal.cy_week_partial_week_id
                         , pw.cy_month
                         , pw.busyear
                         , CAST(NULL AS NUMBER(38,0))   AS skipped_cnt_wtd
                         , CAST(NULL AS NUMBER(38,0))   AS day_cnt_wtd
                         , CAST(NULL AS NUMBER(38,0))   AS store_day_cnt_wtd
                         , CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d1
                         , CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d2
                         , CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d3
                         , CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d4
                         , CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d5
                         , CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d6
                         , CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d7
                         , CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_wtd
                         , CAST(NULL AS NUMBER(38,0))   AS store_day_cnt_wtd_vj
                         , CAST(NULL AS NUMBER(38,0))   AS skipped_cnt_wtd_vj
                         , CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_wtd_vj

                         , SUM(COALESCE(pw.skipped_cnt,0))      OVER (PARTITION BY pw.client_id, pw.wh_id, pw.aspect_id, cal.cy_week_partial_week_id, pw.curr_tot_id)  AS mtd_skipped_cnt
                         , SUM(COALESCE(pw.miss_item_cnt,0))    OVER (PARTITION BY pw.client_id, pw.wh_id, pw.aspect_id, cal.cy_week_partial_week_id, pw.curr_tot_id)  AS mtd_miss_item_cnt
                         , SUM(COALESCE(pw.store_day_cnt,0))    OVER (PARTITION BY pw.client_id, pw.wh_id, pw.aspect_id, cal.cy_week_partial_week_id, pw.curr_tot_id)  AS mtd_store_day_cnt
                         , SUM(COALESCE(pw.skipped_cnt_vj,0))   OVER (PARTITION BY pw.client_id, pw.wh_id, pw.aspect_id, cal.cy_week_partial_week_id, pw.curr_tot_id)  AS mtd_skipped_cnt_vj
                         , SUM(COALESCE(pw.miss_item_cnt_vj,0)) OVER (PARTITION BY pw.client_id, pw.wh_id, pw.aspect_id, cal.cy_week_partial_week_id, pw.curr_tot_id)  AS mtd_miss_item_cnt_vj
                         , SUM(COALESCE(pw.store_day_cnt_vj,0)) OVER (PARTITION BY pw.client_id, pw.wh_id, pw.aspect_id, cal.cy_week_partial_week_id, pw.curr_tot_id)  AS mtd_store_day_cnt_vj

                         , CAST(NULL AS NUMBER(38,0))   AS ytd_skipped_cnt
                         , CAST(NULL AS NUMBER(38,0))   AS ytd_miss_item_cnt
                         , CAST(NULL AS NUMBER(38,0))   AS ytd_store_day_cnt
                         , CAST(NULL AS NUMBER(38,0))   AS ytd_skipped_cnt_vj
                         , CAST(NULL AS NUMBER(38,0))   AS ytd_miss_item_cnt_vj
                         , CAST(NULL AS NUMBER(38,0))   AS ytd_store_day_cnt_vj

                   FROM P_LEW_MART_LEAD.v_agg_miss_item_wh_partial_week    AS pw

                  INNER JOIN P_LEW_BIL_AC.v_cal_week_partial_week             AS cal
                     ON pw.busyear                  = cal.busyear
                    AND pw.cy_month                 = cal.cy_month
                    AND pw.cy_week_partial_week_id <= cal.cy_week_partial_week_id

                  UNION ALL

                 SELECT DISTINCT m.client_id
                         , m.loc_sid_wh
                         , m.wh_id
                         , m.aspect_id
                         , m.currency_iso_cd
                         , m.curr_tot_id
                         , cal.cy_week_partial_week_id
                         , cal.cy_month
                         , m.busyear
                         , CAST(NULL AS NUMBER(38,0))   AS skipped_cnt_wtd
                         , CAST(NULL AS NUMBER(38,0))   AS day_cnt_wtd
                         , CAST(NULL AS NUMBER(38,0))   AS store_day_cnt_wtd
                         , CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d1
                         , CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d2
                         , CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d3
                         , CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d4
                         , CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d5
                         , CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d6
                         , CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_d7
                         , CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_wtd
                         , CAST(NULL AS NUMBER(38,0))   AS store_day_cnt_wtd_vj
                         , CAST(NULL AS NUMBER(38,0))   AS skipped_cnt_wtd_vj
                         , CAST(NULL AS NUMBER(38,0))   AS miss_item_cnt_wtd_vj
                         , CAST(NULL AS NUMBER(38,0))   AS mtd_skipped_cnt
                         , CAST(NULL AS NUMBER(38,0))   AS mtd_miss_item_cnt
                         , CAST(NULL AS NUMBER(38,0))   AS mtd_store_day_cnt
                         , CAST(NULL AS NUMBER(38,0))   AS mtd_skipped_cnt_vj
                         , CAST(NULL AS NUMBER(38,0))   AS mtd_miss_item_cnt_vj
                         , CAST(NULL AS NUMBER(38,0))   AS mtd_store_day_cnt_vj

                         , SUM(COALESCE(m.skipped_cnt,0))      OVER (PARTITION BY m.client_id, m.wh_id, m.aspect_id, cal.cy_week_partial_week_id, m.curr_tot_id) AS ytd_skipped_cnt
                         , SUM(COALESCE(m.miss_item_cnt,0))    OVER (PARTITION BY m.client_id, m.wh_id, m.aspect_id, cal.cy_week_partial_week_id, m.curr_tot_id) AS ytd_miss_item_cnt
                         , SUM(COALESCE(m.store_day_cnt,0))    OVER (PARTITION BY m.client_id, m.wh_id, m.aspect_id, cal.cy_week_partial_week_id, m.curr_tot_id) AS ytd_store_day_cnt
                         , SUM(COALESCE(m.skipped_cnt_vj,0))   OVER (PARTITION BY m.client_id, m.wh_id, m.aspect_id, cal.cy_week_partial_week_id, m.curr_tot_id) AS ytd_skipped_cnt_vj
                         , SUM(COALESCE(m.miss_item_cnt_vj,0)) OVER (PARTITION BY m.client_id, m.wh_id, m.aspect_id, cal.cy_week_partial_week_id, m.curr_tot_id) AS ytd_miss_item_cnt_vj
                         , SUM(COALESCE(m.store_day_cnt_vj,0)) OVER (PARTITION BY m.client_id, m.wh_id, m.aspect_id, cal.cy_week_partial_week_id, m.curr_tot_id) AS ytd_store_day_cnt_vj

                    FROM P_LEW_BIL_AC.v_cal_week_partial_week           AS cal

                  INNER JOIN  P_LEW_MART_LEAD.v_agg_miss_item_wh_mth AS m
                      ON m.busyear    = cal.busyear
                     AND m.cy_month   < cal.cy_month

                 ) AS w
        ) AS d
;