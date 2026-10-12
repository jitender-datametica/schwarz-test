/* #----------------------------------------------------------------------------
# Description:
# This view provides an aggregated list of missing items with the granularity of country_2/month.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13.04.2022      Michael Morris             Initial Versiuon
#  1.1     01.11.2022      Michael Morris             Währungsspalten hinzugefügt
#
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_miss_item_int_mth_2 (client_id OPTIONS(description='MIS Client ID'),
cy_month OPTIONS(description='Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
aspect_id OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), currency_iso_cd
OPTIONS(description='3 stelliger Währungs-Code'), curr_tot_id OPTIONS(description='Interner Währungs-Code'), day_cnt
OPTIONS(description='Anzahl der Tage in dem den Store auf hat'), store_day_cnt
OPTIONS(description='Anzahl der Filialetage'), miss_item_cnt
OPTIONS(description='Anzahl der Fehlartikeln für die Gesellschaft für den ganzen Monat_2'), skipped_cnt
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt) ausgeschlossen wurde.'),
miss_item_cnt_avg_day OPTIONS(description='Fehlartikel Durchschnittswert pro Filiale/Tag_2'), cy_month_vj
OPTIONS(description='Geschäftsjahr - Woche_2 Id - Format "JJJJMM"'), busyear_vj OPTIONS(description='Geschäftsjahr'),
day_cnt_vj OPTIONS(description='Anzahl der Tage in dem den Store auf hat - aus dem Vorjahr'), store_day_cnt_vj
OPTIONS(description='Anzahl der Filialetage aus dem Vorjahr'), miss_item_cnt_vj
OPTIONS(description='Anzahl der Fehlartikeln für die Gesellschaft für den ganzen Monat_2'), skipped_cnt_vj
OPTIONS(description='Anzahl der Tage die wegen fehlende Bestände aus der Aggrgation (miss_item_cnt_vj) ausgeschlossen wurde.'),
miss_item_cnt_avg_day_vj OPTIONS(description='Fehlartikel Durchschnittswert pro Filiale/Tag_2'), miss_item_cnt_diff
OPTIONS(description='Anzahl der Fehlartikel (im Monat_2) aus aktuellem Jahr minus Anzahl der Fehlartikel (im Monat_2) aus dem Vorjahr'),
miss_item_avg_day_diff
OPTIONS(description='Aktuelle Durchschnittswert (Filale/Tag_2) minus Durchschnittswert (Filale/Tag_2) aus dem Vorjahr'),
miss_item_avg_day_diff_delta
OPTIONS(description='Unterschied zwischen Fehlartkelanzahl aktuelles Jahr und Fehlartkelanzahl des Vorjahres in Prozent'))
OPTIONS(DESCRIPTION = `ANZAHL DER FEHLARTIKEL PRO LAND_2/MONAT_2`) AS SELECT client_id,
 cy_month,
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
 cy_month_vj,
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
   cy_month,
   busyear,
   aspect_id,
   currency_iso_cd,
   curr_tot_id,
   MAX(day_cnt) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_month AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS day_cnt,
   SUM(day_cnt) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_month AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS store_day_cnt,
   SUM(miss_item_cnt) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_month AS STRING)
      , CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt,
   SUM(skipped_cnt) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_month AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt,
   cy_month_vj,
   busyear_vj,
   MAX(day_cnt_vj) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_month AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS day_cnt_vj,
   SUM(day_cnt_vj) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_month AS STRING), CAST(curr_tot_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS store_day_cnt_vj,
   SUM(miss_item_cnt_vj) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_month AS STRING)
      , CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS miss_item_cnt_vj,
   SUM(skipped_cnt_vj) OVER (PARTITION BY CAST(client_id AS STRING), CAST(aspect_id AS STRING), CAST(cy_month AS STRING)
      , CAST(curr_tot_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS skipped_cnt_vj
  FROM ldl_p_lew_mart_lead.v_agg_miss_item_store_mth_2) AS ww;