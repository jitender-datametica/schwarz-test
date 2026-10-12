/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/partial week.
#-----------------------------------------------------------------------------
# History:
#  1.0     17.08.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_miss_wgi_store_wk (client_id OPTIONS(description='MIS Client ID'),
loc_sid_wh OPTIONS(description='S-Key der Gesellschaft'), move_to_store_id
OPTIONS(description='S-Key der Location, hier der Filiale'), wh_id OPTIONS(description='Gesellschaft ID'), orig_store_nr
OPTIONS(description='Store ID'), item_grp_int_sid OPTIONS(description='S-Key für Internationale Warengruppe'),
itemgroup_int_id OPTIONS(description='Warengruppe ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'),
cy_week_partial_week_id OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), cy_month
OPTIONS(description='Geschäftsjahr - Woche Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
day_cnt OPTIONS(description='Anzahl der öffenen Tage der Woche'), miss_item_cnt_d1
OPTIONS(description='Anzahl der Fehlartikel Tag 1 (Montag)'), miss_item_cnt_d2
OPTIONS(description='Anzahl der Fehlartikel Tag 2 (Dienstag)'), miss_item_cnt_d3
OPTIONS(description='Anzahl der Fehlartikel Tag 3 (Mittwoch)'), miss_item_cnt_d4
OPTIONS(description='Anzahl der Fehlartikel Tag 4 (Donnerstag)'), miss_item_cnt_d5
OPTIONS(description='Anzahl der Fehlartikel Tag 5 (Freitag)'), miss_item_cnt_d6
OPTIONS(description='Anzahl der Fehlartikel Tag 6 (Samstag)'), miss_item_cnt_d7
OPTIONS(description='Anzahl der Fehlartikel Tag 7 (Sonntag)'), miss_item_cnt
OPTIONS(description='Gesamt Anzahl der Fehlartikeln der Woche'), miss_item_cnt_avg_day
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der augelaufenen Fehlartikel der Woche)'),
day_cnt_vj OPTIONS(description='Anzahl der öffenen Tage der Woche aus dem Vorjahr'), skipped_cnt_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_vj OPTIONS(description='Gesamt Anzahl der Fehlartikeln der Woche aus dem Vorjahr'),
miss_item_cnt_avg_day_vj
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der augelaufenen Fehlartikel der Woche aus dem Vorjahr)'),
miss_item_cnt_avg_day_diff
OPTIONS(description='Differenz zwischen den Durschnittswert (aktuell) und dem Duchschnittswert (Vorjahr)'), day_cnt_mtd
OPTIONS(description='Anzahl der öffenen Tagen aufgelaufen des Monats'), skipped_cnt_mtd
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_mtd OPTIONS(description='Gesamt Anzahl der Fehlartikeln aufgelaufen des Monats'), day_cnt_mtd_vj
OPTIONS(description='Anzahl der öffenen Tagen aufgelaufen des Monats aus dem Vorjahr'), skipped_cnt_mtd_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_mtd_vj OPTIONS(description='Gesamt Anzahl der Fehlartikeln aufgelaufen des Monats aus dem Vorjahr'),
miss_item_cnt_avg_day_mtd
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Monats)'),
miss_item_cnt_avg_day_mtd_vj
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Monats aus dem Vorjahr)'),
miss_item_cnt_avg_day_mtd_diff
OPTIONS(description='Differenz zwischen den Durschnittswert (aufgelaufen des Monats) und dem Duchschnittswert (aufgelaufen des Monats aus dem Vorjahr)'),
day_cnt_ytd OPTIONS(description='Anzahl der öffenen aufgelaufen Tagen des aktuellen Geschäftsjahrs'), skipped_cnt_ytd
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_ytd OPTIONS(description='Gesamt Anzahl der aufgelaufenden Fehlartikeln des aktuellen Geschäftsjahres'),
day_cnt_ytd_vj OPTIONS(description='Anzahl der öffenen aufgelaufen Tagen des Vorgeschäftsjahres'), skipped_cnt_ytd_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggregation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_ytd_vj OPTIONS(description='Gesamt Anzahl der aufgelaufenden Fehlartikeln des Vorgeschäftsjahres'),
miss_item_cnt_avg_day_ytd
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des aktuellen Geschäftsjahres)'),
miss_item_cnt_avg_day_ytd_vj
OPTIONS(description='Durchschnittliche Fehlartikeltageswert (basiert auf der aufgelaufenen Fehlartikel des Vorgeschäftsjahres)'),
miss_item_cnt_avg_day_ytd_diff
OPTIONS(description='Differenz zwischen den Durschnittswert (aufgelaufen aktuelles Geschäftsjahr) und dem Duchschnittswert (aufgelaufen Vorgeschäftsjahr)'))
OPTIONS(DESCRIPTION = `COUNTS THE MISSING ITEMS PER WAREHOUSE/PARTIAL WEEK`) AS SELECT client_id,
 loc_sid_wh,
 move_to_store_id,
 wh_id,
 orig_store_nr,
 item_grp_int_sid,
 itemgroup_int_id,
 aspect_id,
 currency_iso_cd,
 curr_tot_id,
 cy_week_partial_week_id,
 cy_month,
 busyear,
 skipped_cnt_wtd AS skipped_cnt,
 day_cnt_wtd AS day_cnt,
 miss_item_cnt_d1,
 miss_item_cnt_d2,
 miss_item_cnt_d3,
 miss_item_cnt_d4,
 miss_item_cnt_d5,
 miss_item_cnt_d6,
 miss_item_cnt_d7,
 miss_item_cnt_wtd AS miss_item_cnt,
  CASE
  WHEN day_cnt_wtd > 0
  THEN miss_item_cnt_wtd / day_cnt_wtd
  ELSE 0
  END AS miss_item_cnt_avg_day_wtd,
 day_cnt_wtd_vj AS day_cnt_vj,
 skipped_cnt_wtd_vj AS skipped_cnt_vj,
 miss_item_cnt_wtd_vj AS miss_item_cnt_vj,
  CASE
  WHEN day_cnt_wtd_vj > 0
  THEN miss_item_cnt_wtd_vj / day_cnt_wtd_vj
  ELSE 0
  END AS miss_item_cnt_avg_day_wtd_vj,
   CASE
   WHEN day_cnt_wtd > 0
   THEN miss_item_cnt_wtd / day_cnt_wtd
   ELSE 0
   END - CASE
   WHEN day_cnt_wtd_vj > 0
   THEN miss_item_cnt_wtd_vj / day_cnt_wtd_vj
   ELSE 0
   END AS miss_item_cnt_avg_day_wtd_diff,
 mtd_store_day_cnt AS day_cnt_mtd,
 mtd_skipped_cnt AS skipped_cnt_mtd,
 mtd_miss_item_cnt AS miss_item_cnt_mtd,
 mtd_store_day_cnt_vj AS day_cnt_mtd_vj,
 mtd_skipped_cnt_vj AS skipped_cnt_mtd_vj,
 mtd_miss_item_cnt_vj AS miss_item_cnt_mtd_vj,
  CASE
  WHEN mtd_store_day_cnt > 0
  THEN mtd_miss_item_cnt / mtd_store_day_cnt
  ELSE 0
  END AS miss_item_cnt_avg_day_mtd,
  CASE
  WHEN mtd_store_day_cnt_vj > 0
  THEN mtd_miss_item_cnt_vj / mtd_store_day_cnt_vj
  ELSE 0
  END AS miss_item_cnt_avg_day_mtd_vj,
   CASE
   WHEN mtd_store_day_cnt > 0
   THEN mtd_miss_item_cnt / mtd_store_day_cnt
   ELSE 0
   END - CASE
   WHEN mtd_store_day_cnt_vj > 0
   THEN mtd_miss_item_cnt_vj / mtd_store_day_cnt_vj
   ELSE 0
   END AS miss_item_cnt_avg_day_mtd_diff,
  ytd_store_day_cnt + mtd_store_day_cnt AS day_cnt_ytd,
  ytd_skipped_cnt + mtd_skipped_cnt AS skipped_cnt_ytd,
  ytd_miss_item_cnt + mtd_miss_item_cnt AS miss_item_cnt_ytd,
  ytd_store_day_cnt_vj + mtd_store_day_cnt_vj AS day_cnt_ytd_vj,
  ytd_skipped_cnt_vj + mtd_skipped_cnt_vj AS skipped_cnt_ytd_vj,
  ytd_miss_item_cnt_vj + mtd_miss_item_cnt_vj AS miss_item_cnt_ytd_vj,
  CASE
  WHEN ytd_store_day_cnt + mtd_store_day_cnt > 0
  THEN (ytd_miss_item_cnt + mtd_miss_item_cnt) / (ytd_store_day_cnt + mtd_store_day_cnt)
  ELSE 0
  END AS miss_item_cnt_avg_day_ytd,
  CASE
  WHEN ytd_store_day_cnt_vj + mtd_store_day_cnt_vj > 0
  THEN (ytd_miss_item_cnt_vj + mtd_miss_item_cnt_vj) / (ytd_store_day_cnt_vj + mtd_store_day_cnt_vj)
  ELSE 0
  END AS miss_item_cnt_avg_day_ytd_vj,
   CASE
   WHEN ytd_store_day_cnt + mtd_store_day_cnt > 0
   THEN (ytd_miss_item_cnt + mtd_miss_item_cnt) / (ytd_store_day_cnt + mtd_store_day_cnt)
   ELSE 0
   END - CASE
   WHEN ytd_store_day_cnt_vj + mtd_store_day_cnt_vj > 0
   THEN (ytd_miss_item_cnt_vj + mtd_miss_item_cnt_vj) / (ytd_store_day_cnt_vj + mtd_store_day_cnt_vj)
   ELSE 0
   END AS miss_item_cnt_avg_day_ytd_diff
FROM (SELECT DISTINCT client_id,
   loc_sid_wh,
   move_to_store_id,
   wh_id,
   orig_store_nr,
   item_grp_int_sid,
   itemgroup_int_id,
   aspect_id,
   currency_iso_cd,
   curr_tot_id,
   cy_week_partial_week_id,
   cy_month,
   busyear,
   SUM(skipped_cnt_wtd) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt_wtd,
   SUM(day_cnt_wtd) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS day_cnt_wtd,
   SUM(miss_item_cnt_d1) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_d1,
   SUM(miss_item_cnt_d2) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_d2,
   SUM(miss_item_cnt_d3) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_d3,
   SUM(miss_item_cnt_d4) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_d4,
   SUM(miss_item_cnt_d5) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_d5,
   SUM(miss_item_cnt_d6) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_d6,
   SUM(miss_item_cnt_d7) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_d7,
   SUM(miss_item_cnt_wtd) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_wtd,
   SUM(day_cnt_wtd_vj) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS day_cnt_wtd_vj,
   SUM(skipped_cnt_wtd_vj) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt_wtd_vj,
   SUM(miss_item_cnt_wtd_vj) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_wtd_vj,
   SUM(COALESCE(mtd_skipped_cnt, 0)) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING)
      , CAST(aspect_id AS STRING), CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS mtd_skipped_cnt,
   SUM(COALESCE(mtd_miss_item_cnt, 0)) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING)
      , CAST(aspect_id AS STRING), CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS mtd_miss_item_cnt,
   SUM(COALESCE(mtd_store_day_cnt, 0)) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING)
      , CAST(aspect_id AS STRING), CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS mtd_store_day_cnt,
   SUM(COALESCE(mtd_skipped_cnt_vj, 0)) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING)
      , CAST(aspect_id AS STRING), CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS mtd_skipped_cnt_vj,
   SUM(COALESCE(mtd_miss_item_cnt_vj, 0)) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING)
      , CAST(aspect_id AS STRING), CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS mtd_miss_item_cnt_vj,
   SUM(COALESCE(mtd_store_day_cnt_vj, 0)) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING)
      , CAST(aspect_id AS STRING), CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS mtd_store_day_cnt_vj,
   SUM(COALESCE(ytd_skipped_cnt, 0)) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING)
      , CAST(aspect_id AS STRING), CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ytd_skipped_cnt,
   SUM(COALESCE(ytd_miss_item_cnt, 0)) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING)
      , CAST(aspect_id AS STRING), CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ytd_miss_item_cnt,
   SUM(COALESCE(ytd_store_day_cnt, 0)) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING)
      , CAST(aspect_id AS STRING), CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ytd_store_day_cnt,
   SUM(COALESCE(ytd_skipped_cnt_vj, 0)) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING)
      , CAST(aspect_id AS STRING), CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ytd_skipped_cnt_vj,
   SUM(COALESCE(ytd_miss_item_cnt_vj, 0)) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING)
      , CAST(aspect_id AS STRING), CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ytd_miss_item_cnt_vj,
   SUM(COALESCE(ytd_store_day_cnt_vj, 0)) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING)
      , CAST(aspect_id AS STRING), CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ytd_store_day_cnt_vj
  FROM (SELECT DISTINCT client_id,
      loc_sid_wh,
      move_to_store_id,
      wh_id,
      orig_store_nr,
      item_grp_int_sid,
      itemgroup_int_id,
      aspect_id,
      currency_iso_cd,
      curr_tot_id,
      cy_week_partial_week_id,
      cy_month,
      busyear,
      SUM(skipped_fg) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
         , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt_wtd,
      SUM(CASE
        WHEN skipped_fg = 0 AND miss_item_cnt IS NOT NULL
        THEN 1
        ELSE 0
        END) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
         , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS day_cnt_wtd,
      SUM(CASE
        WHEN skipped_fg = 0 AND day_of_week = 1
        THEN miss_item_cnt
        ELSE 0
        END) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
         , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_d1,
      SUM(CASE
        WHEN skipped_fg = 0 AND day_of_week = 2
        THEN miss_item_cnt
        ELSE 0
        END) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
         , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_d2,
      SUM(CASE
        WHEN skipped_fg = 0 AND day_of_week = 3
        THEN miss_item_cnt
        ELSE 0
        END) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
         , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_d3,
      SUM(CASE
        WHEN skipped_fg = 0 AND day_of_week = 4
        THEN miss_item_cnt
        ELSE 0
        END) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
         , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_d4,
      SUM(CASE
        WHEN skipped_fg = 0 AND day_of_week = 5
        THEN miss_item_cnt
        ELSE 0
        END) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
         , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_d5,
      SUM(CASE
        WHEN skipped_fg = 0 AND day_of_week = 6
        THEN miss_item_cnt
        ELSE 0
        END) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
         , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_d6,
      SUM(CASE
        WHEN skipped_fg = 0 AND day_of_week = 7
        THEN miss_item_cnt
        ELSE 0
        END) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
         , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_d7,
      SUM(CASE
        WHEN skipped_fg = 0
        THEN miss_item_cnt
        ELSE 0
        END) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
         , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_wtd,
      SUM(CASE
        WHEN skipped_fg_vj_cal = 0 AND miss_item_cnt_vj_cal IS NOT NULL
        THEN 1
        ELSE 0
        END) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
         , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS day_cnt_wtd_vj,
      SUM(skipped_fg_vj_cal) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
         , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt_wtd_vj,
      SUM(CASE
        WHEN skipped_fg_vj_cal = 0
        THEN miss_item_cnt_vj_cal
        ELSE 0
        END) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(aspect_id AS STRING)
         , CAST(itemgroup_int_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_wtd_vj,
      CAST(NULL AS BIGNUMERIC) AS mtd_skipped_cnt,
      CAST(NULL AS BIGNUMERIC) AS mtd_miss_item_cnt,
      CAST(NULL AS BIGNUMERIC) AS mtd_store_day_cnt,
      CAST(NULL AS BIGNUMERIC) AS mtd_skipped_cnt_vj,
      CAST(NULL AS BIGNUMERIC) AS mtd_miss_item_cnt_vj,
      CAST(NULL AS BIGNUMERIC) AS mtd_store_day_cnt_vj,
      CAST(NULL AS BIGNUMERIC) AS ytd_skipped_cnt,
      CAST(NULL AS BIGNUMERIC) AS ytd_miss_item_cnt,
      CAST(NULL AS BIGNUMERIC) AS ytd_store_day_cnt,
      CAST(NULL AS BIGNUMERIC) AS ytd_skipped_cnt_vj,
      CAST(NULL AS BIGNUMERIC) AS ytd_miss_item_cnt_vj,
      CAST(NULL AS BIGNUMERIC) AS ytd_store_day_cnt_vj
     FROM ldl_p_lew_mart_lead.v_agg_miss_wgi_store_day
     UNION ALL
     SELECT DISTINCT PW.client_id,
      PW.loc_sid_wh,
      PW.move_to_store_id,
      PW.wh_id,
      PW.orig_store_nr,
      PW.item_grp_int_sid,
      PW.itemgroup_int_id,
      PW.aspect_id,
      PW.currency_iso_cd,
      PW.curr_tot_id,
      CAL.cy_week_partial_week_id,
      PW.cy_month,
      PW.busyear,
      CAST(NULL AS BIGNUMERIC) AS skipped_cnt_wtd,
      CAST(NULL AS BIGNUMERIC) AS day_cnt_wtd,
      CAST(NULL AS BIGNUMERIC) AS miss_item_cnt_d1,
      CAST(NULL AS BIGNUMERIC) AS miss_item_cnt_d2,
      CAST(NULL AS BIGNUMERIC) AS miss_item_cnt_d3,
      CAST(NULL AS BIGNUMERIC) AS miss_item_cnt_d4,
      CAST(NULL AS BIGNUMERIC) AS miss_item_cnt_d5,
      CAST(NULL AS BIGNUMERIC) AS miss_item_cnt_d6,
      CAST(NULL AS BIGNUMERIC) AS miss_item_cnt_d7,
      CAST(NULL AS BIGNUMERIC) AS miss_item_cnt_wtd,
      CAST(NULL AS BIGNUMERIC) AS day_cnt_wtd_vj,
      CAST(NULL AS BIGNUMERIC) AS skipped_cnt_wtd_vj,
      CAST(NULL AS BIGNUMERIC) AS miss_item_cnt_wtd_vj,
      SUM(COALESCE(PW.skipped_cnt, 0)) OVER (PARTITION BY CAST(PW.client_id AS STRING), PW.wh_id, CAST(PW.move_to_store_id AS STRING)
         , CAST(PW.aspect_id AS STRING), CAST(PW.itemgroup_int_id AS STRING), CAST(CAL.cy_week_partial_week_id AS STRING)
         , CAST(PW.curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS mtd_skipped_cnt
      ,
      SUM(COALESCE(PW.miss_item_cnt, 0)) OVER (PARTITION BY CAST(PW.client_id AS STRING), PW.wh_id, CAST(PW.move_to_store_id AS STRING)
         , CAST(PW.aspect_id AS STRING), CAST(PW.itemgroup_int_id AS STRING), CAST(CAL.cy_week_partial_week_id AS STRING)
         , CAST(PW.curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
      mtd_miss_item_cnt,
      SUM(COALESCE(PW.day_cnt, 0)) OVER (PARTITION BY CAST(PW.client_id AS STRING), PW.wh_id, CAST(PW.move_to_store_id AS STRING)
         , CAST(PW.aspect_id AS STRING), CAST(PW.itemgroup_int_id AS STRING), CAST(CAL.cy_week_partial_week_id AS STRING)
         , CAST(PW.curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
      mtd_store_day_cnt,
      SUM(COALESCE(PW.skipped_cnt_vj, 0)) OVER (PARTITION BY CAST(PW.client_id AS STRING), PW.wh_id, CAST(PW.move_to_store_id AS STRING)
         , CAST(PW.aspect_id AS STRING), CAST(PW.itemgroup_int_id AS STRING), CAST(CAL.cy_week_partial_week_id AS STRING)
         , CAST(PW.curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
      mtd_skipped_cnt_vj,
      SUM(COALESCE(PW.miss_item_cnt_vj, 0)) OVER (PARTITION BY CAST(PW.client_id AS STRING), PW.wh_id, CAST(PW.move_to_store_id AS STRING)
         , CAST(PW.aspect_id AS STRING), CAST(PW.itemgroup_int_id AS STRING), CAST(CAL.cy_week_partial_week_id AS STRING)
         , CAST(PW.curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
      mtd_miss_item_cnt_vj,
      SUM(COALESCE(PW.day_cnt_vj, 0)) OVER (PARTITION BY CAST(PW.client_id AS STRING), PW.wh_id, CAST(PW.move_to_store_id AS STRING)
         , CAST(PW.aspect_id AS STRING), CAST(PW.itemgroup_int_id AS STRING), CAST(CAL.cy_week_partial_week_id AS STRING)
         , CAST(PW.curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
      mtd_store_day_cnt_vj,
      CAST(NULL AS BIGNUMERIC) AS ytd_skipped_cnt,
      CAST(NULL AS BIGNUMERIC) AS ytd_miss_item_cnt,
      CAST(NULL AS BIGNUMERIC) AS ytd_store_day_cnt,
      CAST(NULL AS BIGNUMERIC) AS ytd_skipped_cnt_vj,
      CAST(NULL AS BIGNUMERIC) AS ytd_miss_item_cnt_vj,
      CAST(NULL AS BIGNUMERIC) AS ytd_store_day_cnt_vj
     FROM ldl_p_lew_mart_lead.v_agg_miss_wgi_store_partial_week AS PW
      INNER JOIN ldl_p_lew_bil_ac.v_cal_week_partial_week AS CAL ON PW.busyear = CAL.busyear AND PW.cy_month = CAL.cy_month
          AND PW.cy_week_partial_week_id <= CAL.cy_week_partial_week_id
     UNION ALL
     SELECT DISTINCT M.client_id,
      M.loc_sid_wh,
      M.move_to_store_id,
      M.wh_id,
      M.orig_store_nr,
      M.item_grp_int_sid,
      M.itemgroup_int_id,
      M.aspect_id,
      M.currency_iso_cd,
      M.curr_tot_id,
      CAL.cy_week_partial_week_id,
      CAL.cy_month,
      M.busyear,
      CAST(NULL AS BIGNUMERIC) AS skipped_cnt_wtd,
      CAST(NULL AS BIGNUMERIC) AS day_cnt_wtd,
      CAST(NULL AS BIGNUMERIC) AS miss_item_cnt_d1,
      CAST(NULL AS BIGNUMERIC) AS miss_item_cnt_d2,
      CAST(NULL AS BIGNUMERIC) AS miss_item_cnt_d3,
      CAST(NULL AS BIGNUMERIC) AS miss_item_cnt_d4,
      CAST(NULL AS BIGNUMERIC) AS miss_item_cnt_d5,
      CAST(NULL AS BIGNUMERIC) AS miss_item_cnt_d6,
      CAST(NULL AS BIGNUMERIC) AS miss_item_cnt_d7,
      CAST(NULL AS BIGNUMERIC) AS miss_item_cnt_wtd,
      CAST(NULL AS BIGNUMERIC) AS day_cnt_wtd_vj,
      CAST(NULL AS BIGNUMERIC) AS skipped_cnt_wtd_vj,
      CAST(NULL AS BIGNUMERIC) AS miss_item_cnt_wtd_vj,
      CAST(NULL AS BIGNUMERIC) AS mtd_skipped_cnt,
      CAST(NULL AS BIGNUMERIC) AS mtd_miss_item_cnt,
      CAST(NULL AS BIGNUMERIC) AS mtd_store_day_cnt,
      CAST(NULL AS BIGNUMERIC) AS mtd_skipped_cnt_vj,
      CAST(NULL AS BIGNUMERIC) AS mtd_miss_item_cnt_vj,
      CAST(NULL AS BIGNUMERIC) AS mtd_store_day_cnt_vj,
      SUM(COALESCE(M.skipped_cnt, 0)) OVER (PARTITION BY CAST(M.client_id AS STRING), M.wh_id, CAST(M.move_to_store_id AS STRING)
         , CAST(M.aspect_id AS STRING), CAST(M.itemgroup_int_id AS STRING), CAST(CAL.cy_week_partial_week_id AS STRING)
         , CAST(M.curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ytd_skipped_cnt,
      SUM(COALESCE(M.miss_item_cnt, 0)) OVER (PARTITION BY CAST(M.client_id AS STRING), M.wh_id, CAST(M.move_to_store_id AS STRING)
         , CAST(M.aspect_id AS STRING), CAST(M.itemgroup_int_id AS STRING), CAST(CAL.cy_week_partial_week_id AS STRING)
         , CAST(M.curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ytd_miss_item_cnt
      ,
      SUM(COALESCE(M.day_cnt, 0)) OVER (PARTITION BY CAST(M.client_id AS STRING), M.wh_id, CAST(M.move_to_store_id AS STRING)
         , CAST(M.aspect_id AS STRING), CAST(M.itemgroup_int_id AS STRING), CAST(CAL.cy_week_partial_week_id AS STRING)
         , CAST(M.curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ytd_store_day_cnt
      ,
      SUM(COALESCE(M.skipped_cnt_vj, 0)) OVER (PARTITION BY CAST(M.client_id AS STRING), M.wh_id, CAST(M.move_to_store_id AS STRING)
         , CAST(M.aspect_id AS STRING), CAST(M.itemgroup_int_id AS STRING), CAST(CAL.cy_week_partial_week_id AS STRING)
         , CAST(M.curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
      ytd_skipped_cnt_vj,
      SUM(COALESCE(M.miss_item_cnt_vj, 0)) OVER (PARTITION BY CAST(M.client_id AS STRING), M.wh_id, CAST(M.move_to_store_id AS STRING)
         , CAST(M.aspect_id AS STRING), CAST(M.itemgroup_int_id AS STRING), CAST(CAL.cy_week_partial_week_id AS STRING)
         , CAST(M.curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
      ytd_miss_item_cnt_vj,
      SUM(COALESCE(M.day_cnt_vj, 0)) OVER (PARTITION BY CAST(M.client_id AS STRING), M.wh_id, CAST(M.move_to_store_id AS STRING)
         , CAST(M.aspect_id AS STRING), CAST(M.itemgroup_int_id AS STRING), CAST(CAL.cy_week_partial_week_id AS STRING)
         , CAST(M.curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
      ytd_store_day_cnt_vj
     FROM ldl_p_lew_bil_ac.v_cal_week_partial_week AS CAL
      INNER JOIN ldl_p_lew_mart_lead.v_agg_miss_wgi_store_mth AS M ON CAL.busyear = M.busyear AND CAL.cy_month > M.cy_month
        ) AS w) AS d;