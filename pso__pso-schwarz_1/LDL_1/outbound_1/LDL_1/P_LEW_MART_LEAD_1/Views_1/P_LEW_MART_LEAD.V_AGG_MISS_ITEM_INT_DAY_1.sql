/*
#----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of country_1/day.
#-----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_miss_item_int_day_1 (client_id OPTIONS(description='MIS Client ID'),
dat_formdate OPTIONS(description='Bezugsdatum'), day_of_week OPTIONS(description='Tag_1 der Woche_1'), cy_month
OPTIONS(description='Monat_1 des Geschäftsjahres im Format "JJJJMM"'), cy_week_partial_week_id
OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), cy_week
OPTIONS(description='Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
aspect_id OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'), store_cnt
OPTIONS(description='Anzahl der Filiale'), miss_item_cnt
OPTIONS(description='Anzahl der Fehlartikel über allen Filialen der Gesellschaft'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_avg_day OPTIONS(description='Durchschnittliche Fehlartikeltageswert pro Filiale'), cal_dt_swday_prev_1y
OPTIONS(description='Datum des Vorjahres (gleiche Wochentag)'), cy_week_vj
OPTIONS(description='Geschäftsjahr - Woche_1 Id - Format "JJJJMM" - von Vorjahr'), cy_month_vj
OPTIONS(description='Monat_1 des Geschäftsjahres im Format "JJJJMM" - von Vorjahr'), busyear_vj
OPTIONS(description='Geschäftsjahr - von Vorjahr'), store_cnt_vj
OPTIONS(description='Anzahl der Filiale aus dem Vorjahr'), miss_item_cnt_vj
OPTIONS(description='Anzahl der Fehlartikel vom Vorjahr'), skipped_cnt_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'),
miss_item_cnt_avg_day_vj OPTIONS(description='Fehlartikel Durchschnittswert pro Filiale/Tag_1 - aus dem Vorjahr'),
miss_item_cnt_diff
OPTIONS(description='Anzahl der Fehlartikel aus aktuellem Jahr minus Anzahl der Fehlartikel aus dem Vorjahr'),
miss_item_avg_day_diff
OPTIONS(description='Aktuelle Durchschnittswert (Filale/Tag_1) minus Durchschnittswert (Filale/Tag_1) aus dem Vorjahr'),
miss_item_avg_day_diff_delta
OPTIONS(description='Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'))
OPTIONS(DESCRIPTION = `ANZAHL DER FEHLARTIKEL PRO LAND_1/TAG_1`) AS SELECT client_id,
 dat_formdate,
 day_of_week,
 cy_month,
 cy_week_partial_week_id,
 cy_week,
 busyear,
 aspect_id,
 CAST(currency_iso_cd AS STRING) AS currency_iso_cd,
 curr_tot_id,
 store_cnt,
 miss_item_cnt,
 skipped_cnt,
  CASE
  WHEN store_cnt > 0
  THEN miss_item_cnt / store_cnt
  ELSE 0
  END AS miss_item_cnt_avg_day,
 cal_dt_vj_cal AS cal_dt_swday_prev_1y,
 cy_week_vj_cal AS cy_week_vj,
 cy_month_vj_cal AS cy_month_vj,
 busyear_vj_cal AS busyear_vj,
 store_cnt_vj_cal AS store_cnt_vj,
 miss_item_cnt_vj_cal AS miss_item_cnt_vj,
 skipped_cnt_vj_cal AS skipped_cnt_vj,
  CASE
  WHEN store_cnt_vj_cal > 0
  THEN miss_item_cnt_vj_cal / store_cnt_vj_cal
  ELSE 0
  END AS miss_item_cnt_avg_day_vj,
  miss_item_cnt - miss_item_cnt_vj_cal AS miss_item_cnt_diff,
   CASE
   WHEN store_cnt > 0
   THEN miss_item_cnt / store_cnt
   ELSE 0
   END - CASE
   WHEN store_cnt_vj_cal > 0
   THEN miss_item_cnt_vj_cal / store_cnt_vj_cal
   ELSE 0
   END AS miss_item_avg_day_diff,
  CASE
  WHEN miss_item_cnt_vj_cal > 0
  THEN (miss_item_cnt - miss_item_cnt_vj_cal) / miss_item_cnt_vj_cal * 100
  ELSE 0
  END AS miss_item_diff_delta
FROM (SELECT DISTINCT client_id,
   dat_formdate,
   day_of_week,
   cy_month,
   cy_week_partial_week_id,
   cy_week,
   busyear,
   aspect_id,
   currency_iso_cd,
   curr_tot_id,
   SUM(CASE
     WHEN miss_item_cnt IS NOT NULL AND skipped_fg = 0
     THEN 1
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), dat_formdate, CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS store_cnt,
   SUM(CASE
     WHEN skipped_fg = 0
     THEN miss_item_cnt
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), dat_formdate, CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt,
   SUM(skipped_fg) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), dat_formdate, CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt,
   MAX(cal_dt_vj_cal) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), dat_formdate, CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cal_dt_vj_cal,
   MAX(cy_week_vj_cal) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), dat_formdate, CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cy_week_vj_cal,
   MAX(cy_month_vj_cal) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), dat_formdate, CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cy_month_vj_cal,
   MAX(busyear_vj_cal) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), dat_formdate, CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS busyear_vj_cal,
   SUM(CASE
     WHEN miss_item_cnt_vj_cal IS NOT NULL AND skipped_fg_vj_cal = 0
     THEN 1
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), dat_formdate, CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS store_cnt_vj_cal,
   SUM(CASE
     WHEN skipped_fg_vj_cal = 0
     THEN miss_item_cnt_vj_cal
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), dat_formdate, CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_vj_cal,
   SUM(skipped_fg_vj_cal) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), dat_formdate, CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt_vj_cal
  FROM ldl_p_lew_mart_lead.v_agg_miss_item_store_day_1) AS whd;