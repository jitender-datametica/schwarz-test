/* #----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of warehouse/product group/partial week.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     17.08.2022      Michael Morris             Initial Versiuon
#
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_miss_wgi_wh_wk_2 (client_id OPTIONS(description='MIS Client ID'),
loc_sid_wh OPTIONS(description='S-Key der Gesellschaft'), wh_id OPTIONS(description='Gesellschaft ID'), item_grp_int_sid
OPTIONS(description='S-Key für Internationale Warengruppe'), itemgroup_int_id OPTIONS(description='Warengruppe ID'),
aspect_id OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), cy_week_partial_week_id
OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), cy_month
OPTIONS(description='Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
miss_item_cnt_d1 OPTIONS(description='Anzahl der Fehlartikel Tag_2 1 (Montag)'), miss_item_cnt_d2
OPTIONS(description='Anzahl der Fehlartikel Tag_2 2 (Dienstag)'), miss_item_cnt_d3
OPTIONS(description='Anzahl der Fehlartikel Tag_2 3 (Mittwoch)'), miss_item_cnt_d4
OPTIONS(description='Anzahl der Fehlartikel Tag_2 4 (Donnerstag)'), miss_item_cnt_d5
OPTIONS(description='Anzahl der Fehlartikel Tag_2 5 (Freitag)'), miss_item_cnt_d6
OPTIONS(description='Anzahl der Fehlartikel Tag_2 6 (Samstag)'), miss_item_cnt_d7
OPTIONS(description='Anzahl der Fehlartikel Tag_2 7 (Sonntag)'), store_day_cnt
OPTIONS(description='Anzahl der öffenen Tage der Woche_2'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt OPTIONS(description='Gesamt Anzahl der Fehlartikeln der Woche_2'), miss_item_cnt_avg_day
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der augelaufenen Fehlartikel der Woche_2)'),
store_day_cnt_vj OPTIONS(description='Anzahl der öffenen Tage der Woche_2 aus dem Vorjahr'), skipped_cnt_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_vj OPTIONS(description='Gesamt Anzahl der Fehlartikeln der Woche_2 aus dem Vorjahr'),
miss_item_cnt_avg_day_vj
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der augelaufenen Fehlartikel der Woche_2 aus dem Vorjahr)'),
miss_item_cnt_avg_day_diff
OPTIONS(description='Differenz zwischen den Durschnittswert (aktuell) und dem Duchschnittswert (Vorjahr)'),
store_day_cnt_mtd OPTIONS(description='Anzahl der öffenen Tagen aufgelaufen des Monats'), skipped_cnt_mtd
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_mtd OPTIONS(description='Gesamt Anzahl der Fehlartikeln aufgelaufen des Monats'), store_day_cnt_mtd_vj
OPTIONS(description='Anzahl der öffenen Tagen aufgelaufen des Monats aus dem Vorjahr'), skipped_cnt_mtd_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_mtd_vj OPTIONS(description='Gesamt Anzahl der Fehlartikeln aufgelaufen des Monats aus dem Vorjahr'),
miss_item_cnt_avg_day_mtd
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Monats)'),
miss_item_cnt_avg_day_mtd_vj
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Monats aus dem Vorjahr)'),
miss_item_cnt_avg_day_mtd_diff
OPTIONS(description='Differenz zwischen den Durschnittswert (aufgelaufen des Monats) und dem Duchschnittswert (aufgelaufen des Monats aus dem Vorjahr)'),
store_day_cnt_ytd OPTIONS(description='Anzahl der öffenen aufgelaufen Tagen des aktuellen Geschäftsjahrs'),
skipped_cnt_ytd
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_ytd OPTIONS(description='Gesamt Anzahl der aufgelaufenden Fehlartikeln des aktuellen Geschäftsjahres'),
store_day_cnt_ytd_vj OPTIONS(description='Anzahl der öffenen aufgelaufen Tagen des Vorgeschäftsjahres'),
skipped_cnt_ytd_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_ytd_vj OPTIONS(description='Gesamt Anzahl der aufgelaufenden Fehlartikeln des Vorgeschäftsjahres'),
miss_item_cnt_avg_day_ytd
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des aktuellen Geschäftsjahres)'),
miss_item_cnt_avg_day_ytd_vj
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Vorgeschäftsjahres)'),
miss_item_cnt_avg_day_ytd_diff
OPTIONS(description='Differenz zwischen den Durschnittswert (aufgelaufen aktuelles Geschäftsjahr) und dem Duchschnittswert (aufgelaufen Vorgeschäftsjahr)'))
OPTIONS(DESCRIPTION = `COUNTS THE MISSING ITEMS PER WAREHOUSE/WARENGRUPPE/PARTIAL WEEK`) AS SELECT client_id,
 loc_sid_wh,
 wh_id,
 item_grp_int_sid,
 itemgroup_int_id,
 aspect_id,
 cy_week_partial_week_id,
 cy_month,
 busyear,
 miss_item_cnt_d1,
 miss_item_cnt_d2,
 miss_item_cnt_d3,
 miss_item_cnt_d4,
 miss_item_cnt_d5,
 miss_item_cnt_d6,
 miss_item_cnt_d7,
 store_day_cnt_wtd AS store_day_cnt,
 skipped_cnt_wtd AS skipped_cnt,
 miss_item_cnt_wtd AS miss_item_cnt,
 miss_item_cnt_avg_day_wtd AS miss_item_cnt_avg_day,
 store_day_cnt_wtd_vj AS store_day_cnt_vj,
 skipped_cnt_wtd_vj AS skipped_cnt_vj,
 miss_item_cnt_wtd_vj AS miss_item_cnt_vj,
 miss_item_cnt_avg_day_wtd_vj AS miss_item_cnt_avg_day_vj,
  miss_item_cnt_avg_day_wtd - miss_item_cnt_avg_day_wtd_vj AS miss_item_cnt_avg_day_wtd_diff,
 store_day_cnt_mtd,
 skipped_cnt_mtd,
 miss_item_cnt_mtd,
 store_day_cnt_mtd_vj,
 skipped_cnt_mtd_vj,
 miss_item_cnt_mtd_vj,
  CASE
  WHEN store_day_cnt_mtd > 0
  THEN miss_item_cnt_mtd / store_day_cnt_mtd
  ELSE 0
  END AS miss_item_cnt_avg_day_mtd,
  CASE
  WHEN store_day_cnt_mtd_vj > 0
  THEN miss_item_cnt_mtd_vj / store_day_cnt_mtd_vj
  ELSE 0
  END AS miss_item_cnt_avg_day_mtd_vj,
   CASE
   WHEN store_day_cnt_mtd > 0
   THEN miss_item_cnt_mtd / store_day_cnt_mtd
   ELSE 0
   END - CASE
   WHEN store_day_cnt_mtd_vj > 0
   THEN miss_item_cnt_mtd_vj / store_day_cnt_mtd_vj
   ELSE 0
   END AS miss_item_cnt_avg_day_mtd_diff,
  store_day_cnt_ytdr + store_day_cnt_mtd AS store_day_cnt_ytd,
  skipped_cnt_ytdr + skipped_cnt_mtd AS skipped_cnt_ytd,
  miss_item_cnt_ytdr + miss_item_cnt_mtd AS miss_item_cnt_ytd,
  store_day_cnt_ytdr_vj + store_day_cnt_mtd_vj AS store_day_cnt_ytd_vj,
  skipped_cnt_ytdr_vj + skipped_cnt_mtd_vj AS skipped_cnt_ytd_vj,
  miss_item_cnt_ytdr_vj + miss_item_cnt_mtd_vj AS miss_item_cnt_ytd_vj,
  CASE
  WHEN store_day_cnt_ytdr + store_day_cnt_mtd > 0
  THEN (miss_item_cnt_ytdr + miss_item_cnt_mtd) / (store_day_cnt_ytdr + store_day_cnt_mtd)
  ELSE 0
  END AS miss_item_cnt_avg_day_ytd,
  CASE
  WHEN store_day_cnt_ytdr_vj + store_day_cnt_mtd_vj > 0
  THEN (miss_item_cnt_ytdr_vj + miss_item_cnt_mtd_vj) / (store_day_cnt_ytdr_vj + store_day_cnt_mtd_vj)
  ELSE 0
  END AS miss_item_cnt_avg_day_ytd_vj,
   CASE
   WHEN store_day_cnt_ytdr + store_day_cnt_mtd > 0
   THEN (miss_item_cnt_ytdr + miss_item_cnt_mtd) / (store_day_cnt_ytdr + store_day_cnt_mtd)
   ELSE 0
   END - CASE
   WHEN store_day_cnt_ytdr_vj + store_day_cnt_mtd_vj > 0
   THEN (miss_item_cnt_ytdr_vj + miss_item_cnt_mtd_vj) / (store_day_cnt_ytdr_vj + store_day_cnt_mtd_vj)
   ELSE 0
   END AS miss_item_cnt_avg_day_ytd_diff
FROM (SELECT DISTINCT w.client_id,
   w.loc_sid_wh,
   w.wh_id,
   w.item_grp_int_sid,
   w.itemgroup_int_id,
   w.aspect_id,
   w.skipped_cnt_wtd,
   w.store_day_cnt_wtd,
   w.cy_week_partial_week_id,
   w.cy_month,
   w.busyear,
   w.miss_item_cnt_d1,
   w.miss_item_cnt_d2,
   w.miss_item_cnt_d3,
   w.miss_item_cnt_d4,
   w.miss_item_cnt_d5,
   w.miss_item_cnt_d6,
   w.miss_item_cnt_d7,
   w.miss_item_cnt_wtd,
   w.store_day_cnt_wtd_vj,
   w.skipped_cnt_wtd_vj,
   w.miss_item_cnt_wtd_vj,
    CASE
    WHEN w.store_day_cnt_wtd > 0
    THEN w.miss_item_cnt_wtd / w.store_day_cnt_wtd
    ELSE 0
    END AS miss_item_cnt_avg_day_wtd,
    CASE
    WHEN w.store_day_cnt_wtd_vj > 0
    THEN w.miss_item_cnt_wtd_vj / w.store_day_cnt_wtd_vj
    ELSE 0
    END AS miss_item_cnt_avg_day_wtd_vj,
   SUM(COALESCE(MTD.store_day_cnt, 0)) OVER (PARTITION BY CAST(w.client_id AS STRING), w.loc_sid_wh, CAST(w.aspect_id AS STRING)
      , CAST(w.item_grp_int_sid AS STRING), CAST(w.cy_week_partial_week_id AS STRING), CAST(w.busyear AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS store_day_cnt_mtd,
   SUM(COALESCE(MTD.skipped_cnt, 0)) OVER (PARTITION BY CAST(w.client_id AS STRING), w.loc_sid_wh, CAST(w.aspect_id AS STRING)
      , CAST(w.item_grp_int_sid AS STRING), CAST(w.cy_week_partial_week_id AS STRING), CAST(w.busyear AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt_mtd,
   SUM(COALESCE(MTD.miss_item_cnt, 0)) OVER (PARTITION BY CAST(w.client_id AS STRING), w.loc_sid_wh, CAST(w.aspect_id AS STRING)
      , CAST(w.item_grp_int_sid AS STRING), CAST(w.cy_week_partial_week_id AS STRING), CAST(w.busyear AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_mtd,
   SUM(COALESCE(MTD.store_day_cnt_vj, 0)) OVER (PARTITION BY CAST(w.client_id AS STRING), w.loc_sid_wh, CAST(w.aspect_id AS STRING)
      , CAST(w.item_grp_int_sid AS STRING), CAST(w.cy_week_partial_week_id AS STRING), CAST(w.busyear AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS store_day_cnt_mtd_vj,
   SUM(COALESCE(MTD.skipped_cnt_vj, 0)) OVER (PARTITION BY CAST(w.client_id AS STRING), w.loc_sid_wh, CAST(w.aspect_id AS STRING)
      , CAST(w.item_grp_int_sid AS STRING), CAST(w.cy_week_partial_week_id AS STRING), CAST(w.busyear AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt_mtd_vj,
   SUM(COALESCE(MTD.miss_item_cnt_vj, 0)) OVER (PARTITION BY CAST(w.client_id AS STRING), w.loc_sid_wh, CAST(w.aspect_id AS STRING)
      , CAST(w.item_grp_int_sid AS STRING), CAST(w.cy_week_partial_week_id AS STRING), CAST(w.busyear AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_mtd_vj,
   COALESCE(ytd.store_day_cnt, 0) AS store_day_cnt_ytdr,
   COALESCE(ytd.skipped_cnt, 0) AS skipped_cnt_ytdr,
   COALESCE(ytd.miss_item_cnt, 0) AS miss_item_cnt_ytdr,
   COALESCE(ytd.store_day_cnt_vj, 0) AS store_day_cnt_ytdr_vj,
   COALESCE(ytd.skipped_cnt_vj, 0) AS skipped_cnt_ytdr_vj,
   COALESCE(ytd.miss_item_cnt_vj, 0) AS miss_item_cnt_ytdr_vj
  FROM (SELECT DISTINCT client_id,
     loc_sid_wh,
     wh_id,
     item_grp_int_sid,
     itemgroup_int_id,
     aspect_id,
     SUM(skipped_cnt) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
        , CAST(cy_week_partial_week_id AS STRING), CAST(busyear AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS skipped_cnt_wtd,
     SUM(store_cnt) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
        , CAST(cy_week_partial_week_id AS STRING), CAST(busyear AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS store_day_cnt_wtd,
     cy_week_partial_week_id,
     cy_month,
     busyear,
     SUM(CASE
       WHEN day_of_week = 1
       THEN miss_item_cnt
       ELSE 0
       END) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
        , CAST(cy_week_partial_week_id AS STRING), CAST(busyear AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS miss_item_cnt_d1,
     SUM(CASE
       WHEN day_of_week = 2
       THEN miss_item_cnt
       ELSE 0
       END) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
        , CAST(cy_week_partial_week_id AS STRING), CAST(busyear AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS miss_item_cnt_d2,
     SUM(CASE
       WHEN day_of_week = 3
       THEN miss_item_cnt
       ELSE 0
       END) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
        , CAST(cy_week_partial_week_id AS STRING), CAST(busyear AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS miss_item_cnt_d3,
     SUM(CASE
       WHEN day_of_week = 4
       THEN miss_item_cnt
       ELSE 0
       END) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
        , CAST(cy_week_partial_week_id AS STRING), CAST(busyear AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS miss_item_cnt_d4,
     SUM(CASE
       WHEN day_of_week = 5
       THEN miss_item_cnt
       ELSE 0
       END) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
        , CAST(cy_week_partial_week_id AS STRING), CAST(busyear AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS miss_item_cnt_d5,
     SUM(CASE
       WHEN day_of_week = 6
       THEN miss_item_cnt
       ELSE 0
       END) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
        , CAST(cy_week_partial_week_id AS STRING), CAST(busyear AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS miss_item_cnt_d6,
     SUM(CASE
       WHEN day_of_week = 7
       THEN miss_item_cnt
       ELSE 0
       END) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
        , CAST(cy_week_partial_week_id AS STRING), CAST(busyear AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS miss_item_cnt_d7,
     SUM(miss_item_cnt) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
        , CAST(cy_week_partial_week_id AS STRING), CAST(busyear AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS miss_item_cnt_wtd,
     SUM(store_cnt_vj) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
        , CAST(cy_week_partial_week_id AS STRING), CAST(busyear AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS store_day_cnt_wtd_vj,
     SUM(skipped_cnt_vj) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
        , CAST(cy_week_partial_week_id AS STRING), CAST(busyear AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS skipped_cnt_wtd_vj,
     SUM(miss_item_cnt_vj) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(item_grp_int_sid AS STRING), CAST(aspect_id AS STRING)
        , CAST(cy_week_partial_week_id AS STRING), CAST(busyear AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS miss_item_cnt_wtd_vj
    FROM ldl_p_lew_mart_lead.v_agg_miss_wgi_wh_day_2) AS w
   LEFT JOIN ldl_p_lew_mart_lead.v_agg_miss_wgi_wh_partial_week_2 AS MTD ON w.client_id = MTD.client_id AND w.loc_sid_wh =
          MTD.loc_sid_wh AND w.item_grp_int_sid = MTD.item_grp_int_sid AND w.aspect_id = MTD.aspect_id AND w.busyear =
       MTD.busyear AND w.cy_month = MTD.cy_month AND w.cy_week_partial_week_id >= MTD.cy_week_partial_week_id
   LEFT JOIN (SELECT DISTINCT CAL.cy_month,
     MTH.client_id,
     MTH.loc_sid_wh,
     MTH.item_grp_int_sid,
     MTH.aspect_id,
     MTH.busyear,
     SUM(COALESCE(MTH.store_day_cnt, 0)) OVER (PARTITION BY CAST(CAL.cy_month AS STRING), CAST(MTH.client_id AS STRING)
        , MTH.loc_sid_wh, CAST(MTH.item_grp_int_sid AS STRING), CAST(MTH.aspect_id AS STRING), CAST(MTH.busyear AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS store_day_cnt,
     SUM(COALESCE(MTH.skipped_cnt, 0)) OVER (PARTITION BY CAST(CAL.cy_month AS STRING), CAST(MTH.client_id AS STRING),
        MTH.loc_sid_wh, CAST(MTH.item_grp_int_sid AS STRING), CAST(MTH.aspect_id AS STRING), CAST(MTH.busyear AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt,
     SUM(COALESCE(MTH.miss_item_cnt, 0)) OVER (PARTITION BY CAST(CAL.cy_month AS STRING), CAST(MTH.client_id AS STRING)
        , MTH.loc_sid_wh, CAST(MTH.item_grp_int_sid AS STRING), CAST(MTH.aspect_id AS STRING), CAST(MTH.busyear AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt,
     SUM(COALESCE(MTH.store_day_cnt_vj, 0)) OVER (PARTITION BY CAST(CAL.cy_month AS STRING), CAST(MTH.client_id AS STRING)
        , MTH.loc_sid_wh, CAST(MTH.item_grp_int_sid AS STRING), CAST(MTH.aspect_id AS STRING), CAST(MTH.busyear AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS store_day_cnt_vj,
     SUM(COALESCE(MTH.skipped_cnt_vj, 0)) OVER (PARTITION BY CAST(CAL.cy_month AS STRING), CAST(MTH.client_id AS STRING)
        , MTH.loc_sid_wh, CAST(MTH.item_grp_int_sid AS STRING), CAST(MTH.aspect_id AS STRING), CAST(MTH.busyear AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt_vj,
     SUM(COALESCE(MTH.miss_item_cnt_vj, 0)) OVER (PARTITION BY CAST(CAL.cy_month AS STRING), CAST(MTH.client_id AS STRING)
        , MTH.loc_sid_wh, CAST(MTH.item_grp_int_sid AS STRING), CAST(MTH.aspect_id AS STRING), CAST(MTH.busyear AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_vj
    FROM ldl_p_lew_core_ac.v_cal_month_2 AS CAL
     INNER JOIN ldl_p_lew_mart_lead.v_agg_miss_wgi_wh_mth_2 AS MTH ON CAL.busyear = MTH.busyear AND CAL.cy_month > MTH.cy_month
       ) AS ytd ON w.client_id = ytd.client_id AND w.loc_sid_wh = ytd.loc_sid_wh AND w.item_grp_int_sid = ytd.item_grp_int_sid
         AND w.aspect_id = ytd.aspect_id AND w.busyear = ytd.busyear AND w.cy_month = ytd.cy_month) AS d;