CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_MISS_WGI_INT_WK_1 COMMENT = 'Counts the missing items per Land_1/Warengruppe/Teilwoche'
(
  client_id                       COMMENT 'MIS Client ID'
, item_grp_int_sid                COMMENT 'S-Key für Internationale Warengruppe'
, itemgroup_int_id                COMMENT 'Warengruppe ID'
, aspect_id                       COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, cy_week_partial_week_id         COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_month                        COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'
, busyear                         COMMENT 'Geschäftsjahr'
, miss_item_cnt_d1                COMMENT 'Anzahl der Fehlartikel Tag_1 1 (Montag)'
, miss_item_cnt_d2                COMMENT 'Anzahl der Fehlartikel Tag_1 2 (Dienstag)'
, miss_item_cnt_d3                COMMENT 'Anzahl der Fehlartikel Tag_1 3 (Mittwoch)'
, miss_item_cnt_d4                COMMENT 'Anzahl der Fehlartikel Tag_1 4 (Donnerstag)'
, miss_item_cnt_d5                COMMENT 'Anzahl der Fehlartikel Tag_1 5 (Freitag)'
, miss_item_cnt_d6                COMMENT 'Anzahl der Fehlartikel Tag_1 6 (Samstag)'
, miss_item_cnt_d7                COMMENT 'Anzahl der Fehlartikel Tag_1 7 (Sonntag)'
, store_day_cnt                   COMMENT 'Anzahl der öffenen Tage der Woche_1'
, skipped_cnt                     COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt                   COMMENT 'Gesamt Anzahl der Fehlartikeln der Woche_1'
, miss_item_cnt_avg_day           COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der augelaufenen Fehlartikel der Woche_1)'
, store_day_cnt_vj                COMMENT 'Anzahl der öffenen Tage der Woche_1 aus dem Vorjahr'
, skipped_cnt_vj                  COMMENT 'Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'
, miss_item_cnt_vj                COMMENT 'Gesamt Anzahl der Fehlartikeln der Woche_1 aus dem Vorjahr'
, miss_item_cnt_avg_day_vj        COMMENT 'Durchschnittliche Fehlartikeltageswert (basiert auf der augelaufenen Fehlartikel der Woche_1 aus dem Vorjahr)'
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
# This view provides an aggregated list of missing items with the granularity of country_1/product group/partial week.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     17.08.2022      Michael Morris             Initial Versiuon
#
#-----------------------------------------------------------------------------
*/
SELECT   d.client_id
       , d.item_grp_int_sid
       , d.itemgroup_int_id
       , d.aspect_id
       , d.cy_week_partial_week_id
       , d.cy_month
       , d.busyear
       , d.miss_item_cnt_d1
       , d.miss_item_cnt_d2
       , d.miss_item_cnt_d3
       , d.miss_item_cnt_d4
       , d.miss_item_cnt_d5
       , d.miss_item_cnt_d6
       , d.miss_item_cnt_d7
       , d.store_day_cnt_wtd
       , d.skipped_cnt_wtd
       , d.miss_item_cnt_wtd
       , d.miss_item_cnt_avg_day_wtd
       , d.store_day_cnt_wtd_vj
       , d.skipped_cnt_wtd_vj
       , d.miss_item_cnt_wtd_vj
       , d.miss_item_cnt_avg_day_wtd_vj
       , d.miss_item_cnt_avg_day_wtd - d.miss_item_cnt_avg_day_wtd_vj AS miss_item_cnt_avg_day_wtd_diff
       , d.store_day_cnt_mtd
       , d.skipped_cnt_mtd
       , d.miss_item_cnt_mtd
       , d.store_day_cnt_mtd_vj
       , d.skipped_cnt_mtd_vj
       , d.miss_item_cnt_mtd_vj

       , CASE WHEN d.store_day_cnt_mtd    > 0 THEN d.miss_item_cnt_mtd    / d.store_day_cnt_mtd    ELSE 0 END AS miss_item_cnt_avg_day_mtd
       , CASE WHEN d.store_day_cnt_mtd_vj > 0 THEN d.miss_item_cnt_mtd_vj / d.store_day_cnt_mtd_vj ELSE 0 END AS miss_item_cnt_avg_day_mtd_vj

       , miss_item_cnt_avg_day_mtd - miss_item_cnt_avg_day_mtd_vj                                             AS miss_item_cnt_avg_day_mtd_diff

       , d.store_day_cnt_ytdr    + d.store_day_cnt_mtd                                                        AS store_day_cnt_ytd
       , d.skipped_cnt_ytdr      + d.skipped_cnt_mtd                                                          AS skipped_cnt_ytd
       , d.miss_item_cnt_ytdr    + d.miss_item_cnt_mtd                                                        AS miss_item_cnt_ytd
       , d.store_day_cnt_ytdr_vj + d.store_day_cnt_mtd_vj                                                     AS store_day_cnt_ytd_vj
       , d.skipped_cnt_ytdr_vj   + d.skipped_cnt_mtd_vj                                                       AS skipped_cnt_ytd_vj
       , d.miss_item_cnt_ytdr_vj + d.miss_item_cnt_mtd_vj                                                     AS miss_item_cnt_ytd_vj


       , CASE WHEN store_day_cnt_ytd    > 0 THEN miss_item_cnt_ytd    / store_day_cnt_ytd    ELSE 0 END       AS miss_item_cnt_avg_day_ytd
       , CASE WHEN store_day_cnt_ytd_vj > 0 THEN miss_item_cnt_ytd_vj / store_day_cnt_ytd_vj ELSE 0 END       AS miss_item_cnt_avg_day_ytd_vj
       , miss_item_cnt_avg_day_ytd - miss_item_cnt_avg_day_ytd_vj                                             AS miss_item_cnt_avg_day_ytd_diff

  FROM (
        SELECT DISTINCT  w.client_id
               , w.item_grp_int_sid
               , w.itemgroup_int_id
               , w.aspect_id
               , w.skipped_cnt_wtd
               , w.store_day_cnt_wtd
               , w.cy_week_partial_week_id
               , w.cy_month
               , w.busyear
               , w.miss_item_cnt_d1
               , w.miss_item_cnt_d2
               , w.miss_item_cnt_d3
               , w.miss_item_cnt_d4
               , w.miss_item_cnt_d5
               , w.miss_item_cnt_d6
               , w.miss_item_cnt_d7
               , w.miss_item_cnt_wtd
               , w.store_day_cnt_wtd_vj
               , w.skipped_cnt_wtd_vj
               , w.miss_item_cnt_wtd_vj                                                                                 AS miss_item_cnt_wtd_vj
               , CASE WHEN w.store_day_cnt_wtd    > 0 THEN (w.miss_item_cnt_wtd    / w.store_day_cnt_wtd)    ELSE 0 END AS miss_item_cnt_avg_day_wtd
               , CASE WHEN w.store_day_cnt_wtd_vj > 0 THEN (w.miss_item_cnt_wtd_vj / w.store_day_cnt_wtd_vj) ELSE 0 END AS miss_item_cnt_avg_day_wtd_vj

               , SUM(COALESCE(mtd.store_day_cnt,0))    OVER (PARTITION BY w.client_id, w.aspect_id, w.item_grp_int_sid, w.cy_week_partial_week_id, w.busyear)  AS store_day_cnt_mtd
               , SUM(COALESCE(mtd.skipped_cnt,0))      OVER (PARTITION BY w.client_id, w.aspect_id, w.item_grp_int_sid, w.cy_week_partial_week_id, w.busyear)  AS skipped_cnt_mtd
               , SUM(COALESCE(mtd.miss_item_cnt,0))    OVER (PARTITION BY w.client_id, w.aspect_id, w.item_grp_int_sid, w.cy_week_partial_week_id, w.busyear)  AS miss_item_cnt_mtd

               , SUM(COALESCE(mtd.store_day_cnt_vj,0)) OVER (PARTITION BY w.client_id, w.aspect_id, w.item_grp_int_sid, w.cy_week_partial_week_id, w.busyear)  AS store_day_cnt_mtd_vj
               , SUM(COALESCE(mtd.skipped_cnt_vj,0))   OVER (PARTITION BY w.client_id, w.aspect_id, w.item_grp_int_sid, w.cy_week_partial_week_id, w.busyear)  AS skipped_cnt_mtd_vj
               , SUM(COALESCE(mtd.miss_item_cnt_vj,0)) OVER (PARTITION BY w.client_id, w.aspect_id, w.item_grp_int_sid, w.cy_week_partial_week_id, w.busyear)  AS miss_item_cnt_mtd_vj

               , COALESCE(ytd.store_day_cnt,0)    AS store_day_cnt_ytdr
               , COALESCE(ytd.skipped_cnt  ,0)    AS skipped_cnt_ytdr
               , COALESCE(ytd.miss_item_cnt,0)    AS miss_item_cnt_ytdr

               , COALESCE(ytd.store_day_cnt_vj,0) AS store_day_cnt_ytdr_vj
               , COALESCE(ytd.skipped_cnt_vj  ,0) AS skipped_cnt_ytdr_vj
               , COALESCE(ytd.miss_item_cnt_vj,0) AS miss_item_cnt_ytdr_vj

          FROM (
                 SELECT DISTINCT client_id
                         , item_grp_int_sid
                         , itemgroup_int_id
                         , aspect_id
                         , SUM(skipped_cnt)                                              OVER (PARTITION BY client_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, busyear) AS skipped_cnt_wtd
                         , SUM(store_cnt)                                                OVER (PARTITION BY client_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, busyear) AS store_day_cnt_wtd
                         , cy_week_partial_week_id
                         , cy_month
                         , busyear
                         , SUM(CASE WHEN day_of_week = 1 THEN miss_item_cnt ELSE 0 END)  OVER (PARTITION BY client_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, busyear) AS miss_item_cnt_d1
                         , SUM(CASE WHEN day_of_week = 2 THEN miss_item_cnt ELSE 0 END)  OVER (PARTITION BY client_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, busyear) AS miss_item_cnt_d2
                         , SUM(CASE WHEN day_of_week = 3 THEN miss_item_cnt ELSE 0 END)  OVER (PARTITION BY client_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, busyear) AS miss_item_cnt_d3
                         , SUM(CASE WHEN day_of_week = 4 THEN miss_item_cnt ELSE 0 END)  OVER (PARTITION BY client_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, busyear) AS miss_item_cnt_d4
                         , SUM(CASE WHEN day_of_week = 5 THEN miss_item_cnt ELSE 0 END)  OVER (PARTITION BY client_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, busyear) AS miss_item_cnt_d5
                         , SUM(CASE WHEN day_of_week = 6 THEN miss_item_cnt ELSE 0 END)  OVER (PARTITION BY client_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, busyear) AS miss_item_cnt_d6
                         , SUM(CASE WHEN day_of_week = 7 THEN miss_item_cnt ELSE 0 END)  OVER (PARTITION BY client_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, busyear) AS miss_item_cnt_d7
                         , SUM(miss_item_cnt)                                            OVER (PARTITION BY client_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, busyear) AS miss_item_cnt_wtd

                         , SUM(store_cnt_vj)                                             OVER (PARTITION BY client_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, busyear) AS store_day_cnt_wtd_vj
                         , SUM(skipped_cnt_vj)                                           OVER (PARTITION BY client_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, busyear) AS skipped_cnt_wtd_vj
                         , SUM(miss_item_cnt_vj)                                         OVER (PARTITION BY client_id, item_grp_int_sid, aspect_id, cy_week_partial_week_id, busyear) AS miss_item_cnt_wtd_vj

                   FROM P_LEW_MART_LEAD.v_agg_miss_wgi_int_day_1
               )           AS w
          LEFT OUTER JOIN P_LEW_MART_LEAD.v_agg_miss_wgi_int_partial_week_1 AS mtd
            ON w.client_id                = mtd.client_id
           AND w.item_grp_int_sid         = mtd.item_grp_int_sid
           AND w.aspect_id                = mtd.aspect_id
           AND w.busyear                  = mtd.busyear
           AND w.cy_month                 = mtd.cy_month
           AND w.cy_week_partial_week_id >= mtd.cy_week_partial_week_id

          LEFT OUTER JOIN (
                           SELECT DISTINCT cal.cy_month
                                   , mth.client_id
                                   , mth.item_grp_int_sid
                                   , mth.aspect_id
                                   , mth.busyear
                                   , SUM(COALESCE(store_day_cnt   ,0)) OVER (PARTITION BY cal.cy_month, mth.client_id, mth.item_grp_int_sid, mth.aspect_id, mth.busyear) AS store_day_cnt
                                   , SUM(COALESCE(skipped_cnt     ,0)) OVER (PARTITION BY cal.cy_month, mth.client_id, mth.item_grp_int_sid, mth.aspect_id, mth.busyear) AS skipped_cnt
                                   , SUM(COALESCE(miss_item_cnt   ,0)) OVER (PARTITION BY cal.cy_month, mth.client_id, mth.item_grp_int_sid, mth.aspect_id, mth.busyear) AS miss_item_cnt

                                   , SUM(COALESCE(store_day_cnt_vj,0)) OVER (PARTITION BY cal.cy_month, mth.client_id, mth.item_grp_int_sid, mth.aspect_id, mth.busyear) AS store_day_cnt_vj
                                   , SUM(COALESCE(skipped_cnt_vj  ,0)) OVER (PARTITION BY cal.cy_month, mth.client_id, mth.item_grp_int_sid, mth.aspect_id, mth.busyear) AS skipped_cnt_vj
                                   , SUM(COALESCE(miss_item_cnt_vj,0)) OVER (PARTITION BY cal.cy_month, mth.client_id, mth.item_grp_int_sid, mth.aspect_id, mth.busyear) AS miss_item_cnt_vj

                             FROM P_LEW_CORE_AC.v_cal_month_1                      AS cal
                            INNER JOIN P_LEW_MART_LEAD.v_agg_miss_wgi_int_mth_1 AS mth
                               ON cal.busyear  = mth.busyear
                              AND cal.cy_month > mth.cy_month
                          ) AS ytd
            ON w.client_id                = ytd.client_id
           AND w.item_grp_int_sid         = ytd.item_grp_int_sid
           AND w.aspect_id                = ytd.aspect_id
           AND w.busyear                  = ytd.busyear
           AND w.cy_month                 = ytd.cy_month
       ) AS d
;