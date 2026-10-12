/* #----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of country/calendar week.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_miss_item_int_week (client_id OPTIONS(description='MIS Client ID'),
cy_week OPTIONS(description='Geschäftsjahr - Woche Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
aspect_id OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'), day_cnt
OPTIONS(description='Anzahl der Tage in dem den Store auf hat'), store_day_cnt
OPTIONS(description='Anzahl der Filialetage'), miss_item_cnt
OPTIONS(description='Anzahl der Fehlartikeln für die Gesellschaft für die ganze Woche'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_avg_day OPTIONS(description='Fehlartikel Durchschnittswert pro Filiale/Tag'), cy_week_vj
OPTIONS(description='Geschäftsjahr - Woche Id - Format "JJJJMM"'), busyear_vj OPTIONS(description='Geschäftsjahr'),
day_cnt_vj OPTIONS(description='Anzahl der Tage in dem den Store auf hat'), store_day_cnt_vj
OPTIONS(description='Anzahl der Filiale aus dem Vorjahr'), miss_item_cnt_vj
OPTIONS(description='Anzahl der Fehlartikeln für die Gesellschaft für die ganze Woche - aus dem Vorjahr'),
skipped_cnt_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'),
miss_item_cnt_avg_day_vj OPTIONS(description='Fehlartikel Durchschnittswert pro Filiale/Tag - aus dem Vorjahr'),
miss_item_cnt_diff
OPTIONS(description='Anzahl der Fehlartikel (in der Woche) aus aktuellem Jahr minus Anzahl der Fehlartikel (in der Woche) aus dem Vorjahr'),
miss_item_avg_day_diff
OPTIONS(description='Aktuelle Durchschnittswert (Filale/Tag) minus Durchschnittswert (Filale/Tag) aus dem Vorjahr'),
miss_item_avg_day_diff_delta
OPTIONS(description='Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'))
OPTIONS(DESCRIPTION = `ANZAHL DER FEHLARTIKEL PRO LAND/WOCHE`) AS SELECT client_id,
 cy_week,
 busyear,
 aspect_id,
 CAST(currency_iso_cd AS STRING) AS currency_iso_cd,
 curr_tot_id,
 day_cnt,
 store_day_cnt,
 miss_item_cnt,
 skipped_cnt,
  CASE
  WHEN store_day_cnt > 0
  THEN miss_item_cnt / store_day_cnt
  ELSE 0
  END AS miss_item_cnt_avg_day,
 cy_week_vj,
 busyear_vj,
 day_cnt_vj,
 store_day_cnt_vj,
 miss_item_cnt_vj,
 skipped_cnt_vj,
  CASE
  WHEN store_day_cnt_vj > 0
  THEN miss_item_cnt_vj / store_day_cnt_vj
  ELSE 0
  END AS miss_item_cnt_avg_day_vj,
  miss_item_cnt - miss_item_cnt_vj AS miss_item_cnt_diff,
   CASE
   WHEN store_day_cnt > 0
   THEN miss_item_cnt / store_day_cnt
   ELSE 0
   END - CASE
   WHEN store_day_cnt_vj > 0
   THEN miss_item_cnt_vj / store_day_cnt_vj
   ELSE 0
   END AS miss_item_avg_day_diff,
  CASE
  WHEN CASE
    WHEN store_day_cnt_vj > 0
    THEN miss_item_cnt_vj / store_day_cnt_vj
    ELSE 0
    END > 0
  THEN (CASE
       WHEN store_day_cnt > 0
       THEN miss_item_cnt / store_day_cnt
       ELSE 0
       END - CASE
       WHEN store_day_cnt_vj > 0
       THEN miss_item_cnt_vj / store_day_cnt_vj
       ELSE 0
       END) / CASE
     WHEN store_day_cnt_vj > 0
     THEN miss_item_cnt_vj / store_day_cnt_vj
     ELSE 0
     END * 100
  ELSE 0
  END AS miss_item_avg_day_diff_delta
FROM (SELECT DISTINCT client_id,
   cy_week,
   busyear,
   aspect_id,
   currency_iso_cd,
   curr_tot_id,
   SUM(CASE
     WHEN miss_item_cnt IS NOT NULL
     THEN 1
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_week AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS day_cnt,
   SUM(store_cnt) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_week AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS store_day_cnt,
   SUM(miss_item_cnt) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_week AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt,
   SUM(skipped_cnt) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_week AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt,
   cy_week_vj,
   busyear_vj,
   SUM(CASE
     WHEN miss_item_cnt_vj IS NOT NULL
     THEN 1
     ELSE 0
     END) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_week AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS day_cnt_vj,
   SUM(store_cnt_vj) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_week AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS store_day_cnt_vj,
   SUM(miss_item_cnt_vj) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_week AS STRING)
      , CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_vj,
   SUM(skipped_cnt_vj) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_week AS STRING)
      , CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt_vj
  FROM ldl_p_lew_mart_lead.v_agg_miss_item_int_day) AS ww;