/* #----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/partial week.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Version
#  1.1     17.08.2022      Michael Morris             Comparison with previous year added
#  1.2     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#  1.3     12.07.2023      Marvin Rekovsky            Added columns for same date previous year logic
#
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_miss_item_store_partial_week (client_id
OPTIONS(description='MIS Client ID'), loc_sid_wh OPTIONS(description='S-Key der Gesellschaft'), move_to_store_id
OPTIONS(description='S-Key der Location, hier der Filiale'), wh_id OPTIONS(description='Gesellschaft ID'), orig_store_nr
OPTIONS(description='Store ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
day_cnt OPTIONS(description='Anzahl der öffenen Tage des Monats'), cy_week_partial_week_id
OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), cy_month
OPTIONS(description='Geschäftsjahr - Woche Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
miss_item_cnt OPTIONS(description='Anzahl der Fehlartikeln innerhalb des Monats'), miss_item_cnt_avg_day
OPTIONS(description='Durchschnittliche Fehlartikeltageswert'), skipped_cnt_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'),
day_cnt_vj OPTIONS(description='Anzahl der öffenen Tage der Woche aus dem Vorjahr'), miss_item_cnt_vj
OPTIONS(description='Anzahl der Fehlartikeln innerhalb des Monats'), miss_item_cnt_vj_dat
OPTIONS(description='Anzahl der Fehlartikeln innerhalb des Monats (gleiches Datum)'), skipped_cnt_vj_dat
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde (gleiches Datum).'),
day_cnt_vj_dat OPTIONS(description='Anzahl der öffenen Tage der Woche aus dem Vorjahr (gleiches Datum)'),
miss_item_cnt_avg_day_vj OPTIONS(description='Durchschnittliche Fehlartikeltageswert/Tag aus dem Vorjahr'),
miss_item_cnt_diff
OPTIONS(description='Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'),
miss_item_avg_day_diff OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr'),
miss_item_avg_day_diff_delta
OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent'),
miss_item_cnt_avg_day_vj_dat
OPTIONS(description='Durchschnittliche Fehlartikeltageswert/Tag aus dem Vorjahr (gleiches Datum)'),
miss_item_cnt_diff_dat
OPTIONS(description='Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr (gleiches Datum)'),
miss_item_avg_day_diff_dat
OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr (gleiches Datum)'),
miss_item_avg_day_diff_delta_dat
OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent (gleiches Datum)'))
OPTIONS(DESCRIPTION = `COUNTS THE MISSING ITEMS PER STORE/MONTH`) AS SELECT client_id,
 loc_sid_wh,
 move_to_store_id,
 wh_id,
 orig_store_nr,
 aspect_id,
 currency_iso_cd,
 curr_tot_id,
 skipped_cnt,
 day_cnt,
 cy_week_partial_week_id,
 cy_month,
 busyear,
 miss_item_cnt,
  CASE
  WHEN day_cnt > 0
  THEN miss_item_cnt / day_cnt
  ELSE 0
  END AS miss_item_cnt_avg_day,
 skipped_cnt_vj,
 day_cnt_vj,
 miss_item_cnt_vj,
 miss_item_cnt_vj_dat,
 skipped_cnt_vj_dat,
 day_cnt_vj_dat,
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
  END AS miss_item_avg_day_diff_delta,
  CASE
  WHEN day_cnt_vj_dat > 0
  THEN miss_item_cnt_vj_dat / day_cnt_vj_dat
  ELSE 0
  END AS miss_item_cnt_avg_day_vj_dat,
  miss_item_cnt - miss_item_cnt_vj_dat AS miss_item_cnt_diff_dat,
   CASE
   WHEN day_cnt > 0
   THEN miss_item_cnt / day_cnt
   ELSE 0
   END - CASE
   WHEN day_cnt_vj_dat > 0
   THEN miss_item_cnt_vj_dat / day_cnt_vj_dat
   ELSE 0
   END AS miss_item_avg_day_diff_dat,
  CASE
  WHEN CASE
    WHEN day_cnt_vj_dat > 0
    THEN miss_item_cnt_vj_dat / day_cnt_vj_dat
    ELSE 0
    END > 0
  THEN (CASE
       WHEN day_cnt > 0
       THEN miss_item_cnt / day_cnt
       ELSE 0
       END - CASE
       WHEN day_cnt_vj_dat > 0
       THEN miss_item_cnt_vj_dat / day_cnt_vj_dat
       ELSE 0
       END) / CASE
     WHEN day_cnt_vj_dat > 0
     THEN miss_item_cnt_vj_dat / day_cnt_vj_dat
     ELSE 0
     END * 100
  ELSE 0
  END AS miss_item_avg_day_diff_delta_dat
FROM (SELECT DISTINCT client_id,
   loc_sid_wh,
   move_to_store_id,
   wh_id,
   orig_store_nr,
   aspect_id,
   currency_iso_cd,
   curr_tot_id,
   SUM(skipped_fg) OVER (PARTITION BY CAST(client_id AS STRING), CAST(move_to_store_id AS STRING), CAST(curr_tot_id AS STRING)
      , CAST(aspect_id AS STRING), CAST(cy_week_partial_week_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS skipped_cnt,
   SUM(CASE
     WHEN skipped_fg = 0 AND miss_item_cnt IS NOT NULL
     THEN 1
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), CAST(move_to_store_id AS STRING), CAST(curr_tot_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_week_partial_week_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS day_cnt,
   cy_week_partial_week_id,
   cy_month,
   busyear,
   SUM(CASE
     WHEN skipped_fg = 0
     THEN miss_item_cnt
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), CAST(move_to_store_id AS STRING), CAST(curr_tot_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_week_partial_week_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   miss_item_cnt,
   SUM(CASE
     WHEN skipped_fg_vj_cal = 0 AND miss_item_cnt_vj_cal IS NOT NULL
     THEN 1
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), CAST(move_to_store_id AS STRING), CAST(curr_tot_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_week_partial_week_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS day_cnt_vj
   ,
   SUM(skipped_fg_vj_cal) OVER (PARTITION BY CAST(client_id AS STRING), CAST(move_to_store_id AS STRING), CAST(curr_tot_id AS STRING)
      , CAST(aspect_id AS STRING), CAST(cy_week_partial_week_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS skipped_cnt_vj,
   busyear_vj_cal AS busyear_vj,
   SUM(CASE
     WHEN skipped_fg_vj_cal = 0
     THEN miss_item_cnt_vj_cal
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), CAST(move_to_store_id AS STRING), CAST(curr_tot_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_week_partial_week_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   miss_item_cnt_vj,
   SUM(CASE
     WHEN skipped_fg_vj_dat = 0 AND miss_item_cnt_vj_dat IS NOT NULL
     THEN 1
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), CAST(move_to_store_id AS STRING), CAST(curr_tot_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_week_partial_week_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   day_cnt_vj_dat,
   SUM(skipped_fg_vj_dat) OVER (PARTITION BY CAST(client_id AS STRING), CAST(move_to_store_id AS STRING), CAST(curr_tot_id AS STRING)
      , CAST(aspect_id AS STRING), CAST(cy_week_partial_week_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS skipped_cnt_vj_dat,
   busyear_vj_dat,
   SUM(CASE
     WHEN skipped_fg_vj_dat = 0
     THEN miss_item_cnt_vj_dat
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), CAST(move_to_store_id AS STRING), CAST(curr_tot_id AS STRING), CAST(aspect_id AS STRING)
      , CAST(cy_week_partial_week_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   miss_item_cnt_vj_dat
  FROM ldl_p_lew_mart_lead.v_agg_miss_item_store_day) AS w;