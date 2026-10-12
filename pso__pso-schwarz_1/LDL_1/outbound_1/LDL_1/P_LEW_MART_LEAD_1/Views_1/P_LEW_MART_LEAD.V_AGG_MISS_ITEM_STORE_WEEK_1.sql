/* #-----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/calendar_1 week.
#
#----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_miss_item_store_week_1 (client_id OPTIONS(description='MIS Client ID'),
loc_sid_wh OPTIONS(description='S-Key der Gesellschaft'), move_to_store_id
OPTIONS(description='S-Key der Location_1, hier der Filiale'), wh_id OPTIONS(description='Gesellschaft ID'), orig_store_nr
OPTIONS(description='Store ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'), day_cnt
OPTIONS(description='Anzahl der Tage in dem den Store auf hat'), cy_week
OPTIONS(description='Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
miss_item_cnt OPTIONS(description='Anzahl der Fehlartikeln für die ganze Woche_1'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_avg_day OPTIONS(description='Fehlartikel Durchschnittswert pro Filiale/Tag_1'), day_cnt_vj
OPTIONS(description='Anzahl der öffenen Tage der Woche_1 aus dem Vorjahr'), cy_week_vj
OPTIONS(description='Geschäftsjahr - Woche_1 Id - Format "JJJJMM" - Vorjahr'), busyear_vj
OPTIONS(description='Geschäftsjahr - Vorjahr'), miss_item_cnt_vj
OPTIONS(description='Anzahl der Fehlartikeln innerhalb des Monats'), skipped_cnt_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'),
miss_item_cnt_avg_day_vj OPTIONS(description='Durchschnittliche Fehlartikeltageswert/Tag_1 aus dem Vorjahr'),
miss_item_cnt_diff
OPTIONS(description='Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'),
miss_item_avg_day_diff OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr'),
miss_item_avg_day_diff_delta
OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent'))
OPTIONS(DESCRIPTION = `COUNTS THE MISSING ITEMS PER STORE/WEEK`) AS SELECT client_id,
 loc_sid_wh,
 move_to_store_id,
 wh_id,
 orig_store_nr,
 aspect_id,
 currency_iso_cd,
 curr_tot_id,
 day_cnt,
 cy_week,
 busyear,
 miss_item_cnt,
 skipped_cnt,
  CASE
  WHEN day_cnt > 0
  THEN miss_item_cnt / day_cnt
  ELSE 0
  END AS miss_item_cnt_avg_day,
 day_cnt_vj,
 cy_week_vj,
 busyear_vj,
 miss_item_cnt_vj,
 skipped_cnt_vj,
  CASE
  WHEN day_cnt_vj > 0
  THEN miss_item_cnt_vj / day_cnt_vj
  ELSE 0
  END AS miss_item_cnt_avg_day_vj,
  miss_item_cnt - miss_item_cnt_vj AS miss_item_cnt_diff,
   CASE
   WHEN day_cnt > 0
   THEN miss_item_cnt / day_cnt
   ELSE 0
   END - CASE
   WHEN day_cnt_vj > 0
   THEN miss_item_cnt_vj / day_cnt_vj
   ELSE 0
   END AS miss_item_avg_day_diff,
  CASE
  WHEN CASE
    WHEN day_cnt_vj > 0
    THEN miss_item_cnt_vj / day_cnt_vj
    ELSE 0
    END > 0
  THEN (CASE
       WHEN day_cnt > 0
       THEN miss_item_cnt / day_cnt
       ELSE 0
       END - CASE
       WHEN day_cnt_vj > 0
       THEN miss_item_cnt_vj / day_cnt_vj
       ELSE 0
       END) / CASE
     WHEN day_cnt_vj > 0
     THEN miss_item_cnt_vj / day_cnt_vj
     ELSE 0
     END * 100
  ELSE 0
  END AS miss_item_avg_day_diff_delta
FROM (SELECT DISTINCT client_id,
   loc_sid_wh,
   move_to_store_id,
   wh_id,
   orig_store_nr,
   aspect_id,
   currency_iso_cd,
   curr_tot_id,
   SUM(skipped_fg) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(move_to_store_id AS STRING), wh_id, CAST(orig_store_nr AS STRING)
      , CAST(aspect_id AS STRING), CAST(cy_week AS STRING), CAST(busyear AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
    AND UNBOUNDED FOLLOWING) AS skipped_cnt,
   SUM(CASE
     WHEN skipped_fg = 0 AND miss_item_cnt IS NOT NULL
     THEN 1
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(move_to_store_id AS STRING), wh_id, CAST(orig_store_nr AS STRING)
      , CAST(aspect_id AS STRING), CAST(cy_week AS STRING), CAST(busyear AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
    AND UNBOUNDED FOLLOWING) AS day_cnt,
   cy_week,
   busyear,
   SUM(CASE
     WHEN skipped_fg = 0
     THEN miss_item_cnt
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(move_to_store_id AS STRING), wh_id, CAST(orig_store_nr AS STRING)
      , CAST(aspect_id AS STRING), CAST(cy_week AS STRING), CAST(busyear AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
    AND UNBOUNDED FOLLOWING) AS miss_item_cnt,
   SUM(CASE
     WHEN skipped_fg_vj_dat = 0 AND miss_item_cnt_vj_dat IS NOT NULL
     THEN 1
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(move_to_store_id AS STRING), wh_id, CAST(orig_store_nr AS STRING)
      , CAST(aspect_id AS STRING), CAST(cy_week_vj_dat AS STRING), CAST(busyear_vj_dat AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS day_cnt_vj,
   SUM(skipped_fg_vj_dat) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(move_to_store_id AS STRING),
      wh_id, CAST(orig_store_nr AS STRING), CAST(aspect_id AS STRING), CAST(cy_week_vj_dat AS STRING), CAST(busyear_vj_dat AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt_vj,
   cy_week_vj_dat AS cy_week_vj,
   busyear_vj_dat AS busyear_vj,
   SUM(CASE
     WHEN skipped_fg_vj_dat = 0
     THEN miss_item_cnt_vj_dat
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), loc_sid_wh, CAST(move_to_store_id AS STRING), wh_id, CAST(orig_store_nr AS STRING)
      , CAST(aspect_id AS STRING), CAST(cy_week_vj_dat AS STRING), CAST(busyear_vj_dat AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_vj
  FROM ldl_p_lew_mart_lead.v_agg_miss_item_store_day_1) AS w;