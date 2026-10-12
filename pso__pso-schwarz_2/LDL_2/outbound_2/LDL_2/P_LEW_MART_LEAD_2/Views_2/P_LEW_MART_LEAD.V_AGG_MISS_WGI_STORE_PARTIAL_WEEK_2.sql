/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of store/product group/partial week.
#-----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     17.08.2022      Michael Morris             Comparison with previous year added
#  1.2     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_miss_wgi_store_partial_week_2 (client_id
OPTIONS(description='MIS Client ID'), loc_sid_wh OPTIONS(description='S-Key der Gesellschaft'), move_to_store_id
OPTIONS(description='S-Key der Location_2, hier der Filiale'), wh_id OPTIONS(description='Gesellschaft ID'), orig_store_nr
OPTIONS(description='Store ID'), item_grp_int_sid OPTIONS(description='S-Key für Internationale Warengruppe'),
itemgroup_int_id OPTIONS(description='Warengruppe ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'),
cy_week_partial_week_id OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), cy_month
OPTIONS(description='Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'), day_cnt
OPTIONS(description='Anzahl der öffenen Tage des Monats'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt OPTIONS(description='Anzahl der Fehlartikeln innerhalb des Monats'), miss_item_cnt_avg_day
OPTIONS(description='Durchschnittliche Fehlartikeltageswert'), day_cnt_vj
OPTIONS(description='Anzahl der öffenen Tage der Woche_2 aus dem Vorjahr'), skipped_cnt_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'),
miss_item_cnt_vj OPTIONS(description='Anzahl der Fehlartikeln innerhalb des Monats'), miss_item_cnt_avg_day_vj
OPTIONS(description='Durchschnittliche Fehlartikeltageswert/Tag_2 aus dem Vorjahr'), miss_item_cnt_diff
OPTIONS(description='Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'),
miss_item_avg_day_diff OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr'),
miss_item_avg_day_diff_delta
OPTIONS(description='Unterschied zwischen aktuellem Durschnittswert und den aus dem Vorjahr in Prozent'))
OPTIONS(DESCRIPTION = `COUNTS THE MISSING ITEMS PER STORE/PRODUCT GROUP/PARTIAL WEEK`) AS SELECT client_id,
 loc_sid_wh,
 move_to_store_id,
 wh_id,
 orig_store_nr,
 item_grp_int_sid,
 itemgroup_int_id,
 aspect_id,
 CAST(currency_iso_cd AS STRING) AS currency_iso_cd,
 curr_tot_id,
 cy_week_partial_week_id,
 cy_month,
 busyear,
 day_cnt,
 skipped_cnt,
 miss_item_cnt,
  CASE
  WHEN day_cnt > 0
  THEN miss_item_cnt / day_cnt
  ELSE 0
  END AS miss_item_cnt_avg_day,
 day_cnt_vj,
 skipped_cnt_vj_cal AS skipped_cnt_vj,
 miss_item_cnt_vj_cal AS miss_item_cnt_vj,
  CASE
  WHEN day_cnt_vj > 0
  THEN miss_item_cnt_vj_cal / day_cnt_vj
  ELSE 0
  END AS miss_item_cnt_avg_day_vj,
  miss_item_cnt - miss_item_cnt_vj_cal AS miss_item_cnt_diff,
   CASE
   WHEN day_cnt > 0
   THEN miss_item_cnt / day_cnt
   ELSE 0
   END - CASE
   WHEN day_cnt_vj > 0
   THEN miss_item_cnt_vj_cal / day_cnt_vj
   ELSE 0
   END AS miss_item_avg_day_diff,
  CASE
  WHEN CASE
    WHEN day_cnt_vj > 0
    THEN miss_item_cnt_vj_cal / day_cnt_vj
    ELSE 0
    END > 0
  THEN (CASE
       WHEN day_cnt > 0
       THEN miss_item_cnt / day_cnt
       ELSE 0
       END - CASE
       WHEN day_cnt_vj > 0
       THEN miss_item_cnt_vj_cal / day_cnt_vj
       ELSE 0
       END) / CASE
     WHEN day_cnt_vj > 0
     THEN miss_item_cnt_vj_cal / day_cnt_vj
     ELSE 0
     END * 100
  ELSE 0
  END AS miss_item_avg_day_diff_delta
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
   SUM(skipped_fg) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(item_grp_int_sid AS STRING)
      , CAST(aspect_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt,
   SUM(CASE
     WHEN skipped_fg = 0 AND miss_item_cnt IS NOT NULL
     THEN 1
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(item_grp_int_sid AS STRING)
      , CAST(aspect_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS day_cnt,
   SUM(CASE
     WHEN skipped_fg = 0
     THEN miss_item_cnt
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(item_grp_int_sid AS STRING)
      , CAST(aspect_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt,
   SUM(CASE
     WHEN skipped_fg_vj_cal = 0 AND miss_item_cnt_vj_cal IS NOT NULL
     THEN 1
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(item_grp_int_sid AS STRING)
      , CAST(aspect_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS day_cnt_vj,
   SUM(skipped_fg_vj_cal) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(item_grp_int_sid AS STRING)
      , CAST(aspect_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt_vj_cal,
   SUM(CASE
     WHEN skipped_fg_vj_cal = 0
     THEN miss_item_cnt_vj_cal
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(move_to_store_id AS STRING), CAST(item_grp_int_sid AS STRING)
      , CAST(aspect_id AS STRING), CAST(cy_week_partial_week_id AS STRING), CAST(curr_tot_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_vj_cal
  FROM ldl_p_lew_mart_lead.v_agg_miss_wgi_store_day_2) AS w;